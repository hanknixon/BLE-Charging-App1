import 'package:ble_app/navigation/navbars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;

import '../navigation/navigation.dart';
import '../utils/ui.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import 'settings_v.dart';
import '../main.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:async';
import '../ble.dart';
import '../blemessages.dart';
import 'scanner_v.dart';

class ConnectV extends StatefulWidget implements PoppingWidget {
  late BluetoothDevice device;
  BluetoothCharacteristic? characteristic; // Add characteristic as class member

  @override
  State<ConnectV> createState() => ConnectVState();

  @override
  void pepareToPop(BuildContext context) {
    ScannerV.startScanner();
  }
}

class ConnectVState extends State<ConnectV> {
  bool showBypassButton = false;
  bool isConnecting = false;

  Future waitWhile(bool Function() test, [Duration pollInterval = Duration.zero]) {
    var completer = Completer();
    check() {
      if (test()) {
        completer.complete();
      } else {
        Timer(pollInterval, check);
      }
    }
    check();
    return completer.future;
  }

  void proceedToSettings(BuildContext context, ChargeSettings chargeSettings) {
    if (mounted) {
      Navigator.of(context).push(
        MCUI.getSlideAnimationRouteBuilder(
          SettingsV(
            device: widget.device,
            services: [],
            bypassMode: true, // Pass characteristic
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scanSettings = context.watch<ScanSettings>();
    var chargeSettings = context.watch<ChargeSettings>();
    chargeSettings.chargeSessionStarted = false;

    widget.device = BluetoothDevice.fromId(scanSettings.btAddress);
    List<BluetoothService> services = [];

    Future<void> messageProtocol(BluetoothCharacteristic characteristic,
        ScanSettings scanSettings) async {
      await listenMessages(characteristic);

      bool state5 = await writeDiagnosticMessage(characteristic);
      if (state5 == false) {
        debugPrint("\n ***** writeDiagnosticMessage FAILED ***** \n");
      }

      bool state1 = await writeInitializationMessage(characteristic);
      if (state1 == false) {
        debugPrint("\n ***** writeInitializationMessage FAILED ***** \n");
      }

      int timestamp = DateTime.now().millisecondsSinceEpoch;
      DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(timestamp);
      bool state7 = await writeTimeSyncMessage(characteristic, tsdate);
      if (state7 == false) {
        debugPrint("\n ***** writeTimeSyncMessage FAILED ***** \n");
      }

      endHeartbeat = false;
      heartBeatInit(characteristic);

      bool state8 = await writeOperaotrRegMessage(characteristic);
      if (state8 == false) {
        debugPrint("\n ***** writeOperaotrRegMessage FAILED ***** \n");
      }

      bool state10 = await writeEVOwnerRegRegMessage(characteristic);
      if (state10 == false) {
        debugPrint("\n ***** writeEVOwnerRegRegMessage FAILED ***** \n");
      }

      bool state11 =
          await writeScheduleChargeRequestMessage(characteristic, tsdate, 30);
      if (state11 == false) {
        debugPrint("\n ***** writeScheduleChargeRequestMessage FAILED ***** \n");
      }
    }

    void showDidNotConnect() {
      setState(() {
        showBypassButton = true;
        isConnecting = false;
      });
      String msg =
          "Did not connect to device. Please try again and check if Bluetooth is enabled";
      MCUI.showErrorOverlay(message: msg, autodismiss: false);
    }

    void connectStartUp() async {
      setState(() {
        isConnecting = true;
      });
      
      MCUI.showProgressOverlay();

      try {
        if (widget.device.isConnected) {
          await widget.device
              .disconnect()
              .timeout(Duration(seconds: MCConstants.bleActionTimeoutSec));
        }
      } on Exception catch (e) {
        debugPrint("\nNotify Error $e\n");
        showDidNotConnect();
        return;
      }

      try {
        await widget.device.connect(autoConnect: false).timeout(
            Duration(seconds: MCConstants.bleActionTimeoutSec), onTimeout: () {
          debugPrint('Timeout occurred');
          MCUI.dismissOverlay();
          showDidNotConnect();
        });
        
        if (Platform.isAndroid) {
          try {
            await widget.device.clearGattCache();
          } catch (e) {
            debugPrint("Clear GATT cache error: $e");
          }
        }
      } on Exception catch (e) {
        debugPrint("\nNotify Error $e\n");
        MCUI.dismissOverlay();
        showDidNotConnect();
        return;
      }

      var stream = widget.device.connectionState.listen((state) async {
        debugPrint(
            "\n ******************** DEVICE STATE STREAM $state ${connectionSubStream.length} ********************** \n");
        if (state == BluetoothConnectionState.connected) {
          setState(() {
            chargeSettings.intendedBLEDisconnect = false;
            chargeSettings.showReconnect = false;
          });

          services = await widget.device.discoverServices();

          BluetoothCharacteristic? foundCharacteristic;
          for (var service in services) {
            for (var characteristic in service.characteristics) {
              if (characteristic.uuid == characteristicsUUID) {
                foundCharacteristic = characteristic;
                break;
              }
            }
            if (foundCharacteristic != null) break;
          }

          if (foundCharacteristic == null) {
            debugPrint(
                "\n ------------- Cannot Find Characteristic UUID $characteristicsUUID -------------------\n");
            widget.device.disconnect();
            showDidNotConnect();
          } else {
            widget.characteristic = foundCharacteristic;

            try {
              debugPrint("\n Notify ${widget.characteristic} \n");
              await widget.characteristic!.setNotifyValue(true);
              await widget.device.requestMtu(32);
            } on Exception catch (e) {
              debugPrint("\nNotify Error $e\n");
            }

            firstDiagnosticRecieved = false;
            responseEndoFChargingRecieved = false;
            responseChargingRecieved = false;
            responseAuthenticationRecieved = false;
            startCharging = false;

            currentChargerState = ChargePointStateENUM.CHARGE_POINT_IDLE;
            await messageProtocol(widget.characteristic!, scanSettings);

            await waitWhile(() => firstDiagnosticRecieved).timeout(
                Duration(seconds: MCConstants.bleActionTimeoutSec),
                onTimeout: () {});

            if (mounted) {
              MCUI.dismissOverlay();
              setState(() {
                isConnecting = false;
              });
              
              Navigator.of(context).push(
                MCUI.getSlideAnimationRouteBuilder(
                  SettingsV(
                    device: widget.device,
                    services: services,
                  ),
                ),
              );
            }
          }
        }
        if (state == BluetoothConnectionState.disconnected) {
          if (connectionSubStream.isNotEmpty) {
            for (var c in connectionSubStream) {
              c.cancel();
            }
            connectionSubStream.clear();
          }

          if (chargeSettings.intendedBLEDisconnect) {
            if (chargeSettings.chargeSessionStarted) {
              MCUI.showInfoOverlay(msg: "Disconnected");
            }
          } else {
            MCUI.showErrorOverlay(message: "Disconnected", autodismiss: false);
            if (mounted) {
              TopNavBar.navigateBack(context);
            }
          }
        }
      });

      if (connectionSubStream.isEmpty) {
        connectionSubStream.add(stream);
      } else {
        connectionSubStream[0].cancel();
        connectionSubStream.removeAt(0);
        connectionSubStream.add(stream);
      }
    }

    return Scaffold(
        backgroundColor: MCColors.white,
        body: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            clipBehavior: Clip.none,
            children: [
              Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    SizedBox(
                        height: MCUI.adjustedHeightWithCotext(164, context)),
                    SizedBox(
                      width: MCUI.adjustedWidthWithCotext(280, context),
                      height: 200,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "Plug the charger into your car to continue",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                letterSpacing: MCConstants.letterSpacing1,
                                color: MCColors.green)),
                      ),
                    ),
                  ])),
              Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                if (showBypassButton)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            fixedSize: Size(
                                MCUI.adjustedWidthWithCotext(305, context),
                                MCUI.adjustedHeightWithCotext(67, context)),
                            backgroundColor: MCColors.white,
                            overlayColor: MCColors.green,
                            side: BorderSide(
                              width: 1,
                              color: MCColors.green,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  MCConstants.ctaBtnCornerRadius),
                            ),
                          ),
                          onPressed: () {
                            widget.device =
                                BluetoothDevice.fromId("00:00:00:00:00:00");
                            proceedToSettings(context, chargeSettings);
                          },
                          child: Text("Continue Without Connection",
                              style: TextStyle(
                                  fontSize: 17,
                                  letterSpacing: MCConstants.letterSpacing1,
                                  color: MCColors.green,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ),
                Center(
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        fixedSize: Size(
                            MCUI.adjustedWidthWithCotext(305, context),
                            MCUI.adjustedHeightWithCotext(67, context)),
                        backgroundColor: MCColors.white,
                        overlayColor: MCColors.green,
                        side: BorderSide(
                          width: 1,
                          color: MCColors.green,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              MCConstants.ctaBtnCornerRadius),
                        ),
                      ),
                      onPressed: isConnecting ? null : () {
                        if (messageSubStream.isNotEmpty) {
                          for (var m in messageSubStream) {
                            m.cancel();
                          }
                          messageSubStream.clear();
                        }
                        if (connectionSubStream.isNotEmpty) {
                          for (var c in connectionSubStream) {
                            c.cancel();
                          }
                          connectionSubStream.clear();
                        }

                        setState(() {
                          showBypassButton = false;
                        });
                        connectStartUp();
                      },
                      child: Text("Connect",
                          style: TextStyle(
                              fontSize: 17,
                              letterSpacing: MCConstants.letterSpacing1,
                              color: MCColors.green,
                              fontWeight: FontWeight.bold))),
                ),
                SizedBox(height: MCUI.adjustedHeightWithCotext(32, context))
              ])
            ]));
  }
}
