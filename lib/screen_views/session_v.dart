import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../navigation/navigation.dart';
import '../utils/ui.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../main.dart';
import '../ble.dart';
import '../blemessages.dart';

// ignore: must_be_immutable
class SessionV extends StatefulWidget {
  SessionV({
    Key? key,
    required this.services,
    required this.device,
    required this.dateTime,
    required this.settingChoice,
    required this.selectedValue,
  }) : super(key: key);

  final List<BluetoothService> services;
  final BluetoothDevice device;
  final String dateTime;
  final String settingChoice;
  final double selectedValue;
  late BluetoothCharacteristic characteristic;
  int duration = 1000;
  double animatePercent = 0;
  var prevTime = 0;

  bool stopTimer = false;
  String message = '';
  double totalCharge = 0.00;

  bool isCharging = false;

  /// Setter function to calculate and set the current charge of the session based on current charge and time elasped from previous update
  ///
  /// @param {ChargeSettings} chargeState - current state of the session with variables for current charge amount and if session is ongoing
  void setCurrentCharge(ChargeSettings chargeState) {
    // var currTime = chargeState.stopwatch.elapsedMilliseconds;
    // var charge = (chargeState.currentCharge +
    //     ((currTime - prevTime) / 3.6e+6 * chargeState.chargeSpeed)
    //         );
    // prevTime = chargeState.stopwatch.elapsedMilliseconds;
    // if (chargeState.chargeSessionStarted == true) {
    //   if (charge >= chargeState.maxCapacity) {
    //     chargeState.currentCharge = chargeState.maxCapacity;
    //   } else {
    //     chargeState.currentCharge = charge;
    //   }
    // }
    var charge = currentMeterValue + chargeState.startingCharge;
    if (chargeState.chargeSessionStarted == true) {
      if (charge >= chargeState.maxCapacity) {
        chargeState.currentCharge = chargeState.maxCapacity;
      } else {
        chargeState.currentCharge = charge;
      }
    }
  }

  @override
  State<SessionV> createState() => _SessionVState();
}

class _SessionVState extends State<SessionV>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  // ignore: unused_field
  late Animation _animation;

  /// Function to create a timer and controller for the animation of the pulsing battery to show total charge percentage
  @override
  void initState() {
    // timeSyncMessage(widget.services, widget.currTime);
    // Timer.periodic(const Duration(seconds: 5), (timer) async {
    //   timerObj = timer;
    //   timeSyncMessage(widget.services, widget.currTime);
    //   if (widget.stopTimer == true) {
    //     timer.cancel();
    //   }
    // });
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animationController.repeat(reverse: true);
    _animation = Tween(begin: 2.0, end: 15.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  /// Function to delete the animination timer/controller
  @override
  dispose() {
    _animationController.dispose(); // you need this
    super.dispose();
  }

  Future waitWhile(bool Function() test,
      [Duration pollInterval = Duration.zero]) {
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

  @override
  Widget build(BuildContext context) {
    var chargeState = context.watch<ChargeSettings>();
    //final scanSettings = context.watch<ScanSettings>();

    BuildContext? dcontext;
    chargeState.device = widget.device;
    chargeState.services = widget.services;

    chargeState.chargeSessionStarted = true;

    Future<void> showNeedToTapAgain(String dispalyText) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          dcontext = context;
          return AlertDialog(
            title: Text(dispalyText),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  dcontext = null;
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }

    void endChargingCleanUp() async {
      if (chargeState.chargeSessionStarted == true) {
        setState(() {
          chargeState.intendedBLEDisconnect = true;
        });
        try {
          await writeEndoFChargingMessage(widget.characteristic);
          await widget.device.disconnect();
          debugPrint(
              "\n <<<<<<<<******>>>>>>>> DISCONNECTING CHARGE DONE <<<<<<<<******>>>>>>>> \n");
        } on Exception catch (e) {
          debugPrint("\nNotify Error $e\n");
        }
      }
    }

    String formatDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      int hours = duration.inHours;
      int minutes = duration.inMinutes.remainder(60);
      int seconds = duration.inSeconds.remainder(60);
      return "${(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}";
    }

    String getRemainingTime(int totalTime, Stopwatch stopwatch) {
      int remainingMilliseconds = totalTime - stopwatch.elapsedMilliseconds;
      if (remainingMilliseconds < 0) {
        remainingMilliseconds = 0;
      }
      Duration remainingDuration =
          Duration(milliseconds: remainingMilliseconds);
      return formatDuration(remainingDuration);
    }

    Widget listEntry(String title, String details) {
      return Padding(
          padding: EdgeInsets.only(
              left: MCUI.adjustedWidthWithCotext(64, context),
              right: MCUI.adjustedWidthWithCotext(64, context)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(title,
                style: TextStyle(
                    fontSize: 15,
                    color: MCColors.grey,
                    fontWeight: FontWeight.w600)),
            Text(details,
                style: TextStyle(
                    fontSize: 15,
                    color: MCColors.grey,
                    fontWeight: FontWeight.w600))
          ]));
    }

    Widget cardEntry(String info, String details, SvgPicture icon) {
      return SizedBox(
          width: MCUI.adjustedWidthWithCotext(MCConstants.ctaBtnWidth, context),
          height:
              MCUI.adjustedHeightWithCotext(MCConstants.ctaBtnHeight, context),
          child: Card(
              margin: EdgeInsets.all(0),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(MCConstants.ctaBtnCornerRadius),
              ),
              color: MCColors.greenLight,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: MCUI.adjustedWidthWithCotext(30, context)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              info.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: MCColors.green,
                                  letterSpacing: MCConstants.letterSpacing1,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              details.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 22,
                                  color: MCColors.green,
                                  letterSpacing: MCConstants.letterSpacing1,
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: MCUI.adjustedWidthWithCotext(30, context)),
                      child: icon,
                    )
                  ])));
    }

    Scaffold chargingPage(BuildContext context, ChargeSettings chargeState,
        bool currentlyCharging) {
      return Scaffold(
        backgroundColor: MCColors.white,
        body: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  SizedBox(height: MCUI.adjustedHeightWithCotext(17, context)),
                  Stack(
                      alignment: AlignmentDirectional.center,
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                            width: 138,
                            height: 66,
                            child:
                                Image.asset('assets/images/battery_empty.png')),
                        SizedBox(
                          width: 137,
                          height: 65,
                          child: Padding(
                            padding: EdgeInsets.only(
                                right:
                                    MCUI.adjustedWidthWithCotext(0, context)),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ClipRect(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: chargeState.currentCharge /
                                      chargeState.maxCapacity,
                                  child: Image.asset(
                                    'assets/images/battery_juice.png',
                                    height: 65,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       right: MCUI.adjustedWidthWithCotext(3, context)),
                        //   child: Transform.flip(
                        //     flipX: false,
                        //     child: SizedBox(
                        //       height: 64,
                        //       width: 140,
                        //       child: LinearPercentIndicator(
                        //         // width: 145.0,
                        //         lineHeight: 55,
                        //         percent: chargeState.currentCharge /
                        //             chargeState.maxCapacity,
                        //         barRadius: Radius.elliptical(8, 32),
                        //         // backgroundColor: Colors.transparent,
                        //         backgroundColor: Color(0xFFE9FBF3),
                        //         // progressColor: Colors.transparent,
                        //         progressColor: Color(0xFF00AB56),
                        //         // animation: false,
                        //         // animationDuration: widget.duration,
                        //         // animateFromLastPercent: true,
                        //         // onAnimationEnd: () {
                        //         //   currentlyCharging
                        //         //       ? setState(() {
                        //         //           if (widget.animatePercent == 0) {
                        //         //             widget.animatePercent =
                        //         //                 chargeState.currentCharge /
                        //         //                     chargeState.maxCapacity *
                        //         //                     100.0;
                        //         //             widget.duration = 2000;
                        //         //           } else {
                        //         //             widget.animatePercent = 0;
                        //         //             widget.duration = 10;
                        //         //           }
                        //         //         })
                        //         //       : widget.animatePercent =
                        //         //           chargeState.currentCharge;
                        //         // },
                        //         // barRadius: Radius.circular(10),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //     width: 138,
                        //     height: 66,
                        //     child: Image.asset(
                        //         'assets/images/battery_filter.png')),
                        SizedBox(
                            width: 150,
                            height: 35,
                            child: Image.asset(
                                'assets/images/battery_textbox.png')),
                        Padding(
                            padding: EdgeInsets.only(
                                right:
                                    MCUI.adjustedWidthWithCotext(13, context)),
                            child: Text(
                                "${((chargeState.currentCharge / chargeState.maxCapacity) * 100.0).floor()}%",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: MCColors.green,
                                    fontWeight: FontWeight.w900))),
                      ]),
                  SizedBox(height: MCUI.adjustedHeightWithCotext(30, context)),
                  listEntry(
                      widget.settingChoice,
                      widget.settingChoice == "Max Time"
                          ? "${widget.selectedValue.round().toString()} Minute(s)"
                          : widget.settingChoice == "Max Cost"
                              ? "\$${widget.selectedValue.toStringAsFixed(2)}"
                              : "${widget.selectedValue.round().toString()}%"),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MCUI.adjustedWidthWithCotext(64, context),
                        right: MCUI.adjustedWidthWithCotext(64, context)),
                    child: Container(
                        color: MCColors.green,
                        height: 1,
                        margin: EdgeInsets.only(
                            top: MCUI.adjustedHeightWithCotext(8, context),
                            bottom: MCUI.adjustedHeightWithCotext(8, context))),
                  ),
                  listEntry("Price:", "\$${chargeState.chargePrice} / kWh"),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MCUI.adjustedWidthWithCotext(64, context),
                        right: MCUI.adjustedWidthWithCotext(64, context)),
                    child: Container(
                        color: MCColors.green,
                        height: 1,
                        margin: EdgeInsets.only(
                            top: MCUI.adjustedHeightWithCotext(8, context),
                            bottom: MCUI.adjustedHeightWithCotext(8, context))),
                  ),
                  listEntry("Total Cost:",
                      "\$${((chargeState.currentCharge - chargeState.startingCharge) * chargeState.chargePrice).toStringAsFixed(2)}"),
                  SizedBox(height: MCUI.adjustedHeightWithCotext(16, context)),
                  cardEntry("Output Power", "${chargeState.chargeSpeed} kW",
                      SvgPicture.asset('assets/images/card_icon_station.svg')),
                  SizedBox(height: MCUI.adjustedHeightWithCotext(8, context)),
                  cardEntry(
                      "Delivered Energy",
                      "${(currentMeterValue).toStringAsFixed(2)} kWh",
                      SvgPicture.asset('assets/images/card_icon_ev.svg')),
                  SizedBox(height: MCUI.adjustedHeightWithCotext(8, context)),
                  cardEntry(
                      "Time Elapsed",
                      formatDuration(chargeState.stopwatch.elapsed),
                      SvgPicture.asset('assets/images/card_icon_time_el.svg')),
                  SizedBox(height: MCUI.adjustedHeightWithCotext(8, context)),
                  cardEntry(
                      "Time Remaining",
                      currentlyCharging
                          ? getRemainingTime(
                              chargeState.totalTime.round() + 1000,
                              chargeState.stopwatch)
                          : "0:00:00",
                      SvgPicture.asset('assets/images/card_icon_time_rm.svg')),
                ],
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MCUI.adjustedWidthWithCotext(24, context)),
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(
                          MCUI.adjustedWidthWithCotext(
                              MCConstants.ctaBtnWidth, context),
                          MCUI.adjustedHeightWithCotext(
                              MCConstants.ctaBtnHeight, context)),
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
                    onPressed: () async {
                      if (!currentlyCharging) {
                        setState(() {
                          chargeState.intendedBLEDisconnect = true;
                        });
                        chargeState.reset();

                        if (context.mounted) {
                          NavigatorMain.reset();
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        }
                      } else {
                        MCUI.showProgressOverlayWithBackground(
                            msg: "Charging Stopping");
                        setState(() {
                          chargeState.intendedBLEDisconnect = true;
                        });
                        try {
                          await writeEndoFChargingMessage(
                              widget.characteristic);
                        } on Exception catch (e) {
                          debugPrint("\nNotify Error $e\n");
                        }

                        await waitWhile(() => responseEndoFChargingRecieved)
                            .timeout(const Duration(seconds: 10),
                                onTimeout: () {
                          showNeedToTapAgain(
                              "Failed to Stop Charge, Please Retry");
                        });

                        if (responseEndoFChargingRecieved == true) {
                          try {
                            await widget.device.disconnect();
                          } on Exception catch (e) {
                            debugPrint("\nNotify Error $e\n");
                          }
                          widget.stopTimer = true;
                          endHeartbeat = true;
                          chargeState.endSession();

                          debugPrint(
                              "\n ************* responseEndoFChargingRecieved ************* \n");
                        }
                      }
                    },
                    child: Text(currentlyCharging ? "End Charging" : "Close",
                        style: TextStyle(
                            fontSize: 17,
                            letterSpacing: MCConstants.letterSpacing1,
                            color: MCColors.green,
                            fontWeight: FontWeight.bold))),
              ),
            ]),
      );
    }

    // ignore: prefer_typing_uninitialized_variables
    var s, c;
    for (s in widget.services) {
      for (c in s.characteristics) {
        if (c.uuid == characteristicsUUID) {
          break;
        }
      }
    }
    widget.characteristic = c;

    if (chargeState.stopwatch.elapsedMilliseconds == 0 &&
        chargeState.stopwatch.isRunning == false &&
        widget.stopTimer == false) {
      chargeState.stopwatch.start();
    }

    widget.setCurrentCharge(chargeState);

    switch (widget.settingChoice) {
      case "Max Time":
        widget.isCharging = widget.selectedValue <=
                (chargeState.stopwatch.elapsedMilliseconds / 60000).floor() ||
            (chargeState.currentCharge >= chargeState.maxCapacity) ||
            (endHeartbeat == true) ||
            (chargeState.chargeSessionStarted == false);
        if (widget.isCharging) {
          if (chargeState.stopwatch.isRunning) {
            debugPrint("\n ************* endChargingCleanUp ************* \n");
            endChargingCleanUp();
          }
          setState(() {
            chargeState.chargeSessionStarted = false;
            chargeState.stopwatch.stop();
            chargeState.intendedBLEDisconnect = true;
          });

          if (dcontext != null) {
            Navigator.pop(dcontext!);
            dcontext = null;
          }
          // timerObj!.cancel();
          widget.stopTimer = true;

          return chargingPage(context, chargeState, false);
        } else {
          return chargingPage(context, chargeState, true);
        }
      case "Max Cost":
        widget.isCharging = widget.selectedValue <=
                ((chargeState.currentCharge - chargeState.startingCharge) *
                    chargeState.chargePrice) ||
            (chargeState.currentCharge >= chargeState.maxCapacity) ||
            (endHeartbeat == true) ||
            (chargeState.chargeSessionStarted == false);
        if (widget.isCharging) {
          if (chargeState.stopwatch.isRunning) {
            debugPrint("\n ************* endChargingCleanUp ************* \n");
            endChargingCleanUp();
          }
          setState(() {
            chargeState.chargeSessionStarted = false;
            chargeState.stopwatch.stop();
            chargeState.intendedBLEDisconnect = true;
          });
          if (dcontext != null) {
            Navigator.pop(dcontext!);
            dcontext = null;
          }
          // timerObj!.cancel();
          widget.stopTimer = true;

          return chargingPage(context, chargeState, false);
        } else {
          return chargingPage(context, chargeState, true);
        }
      case "Charge %":
        widget.isCharging = (widget.selectedValue <=
                (chargeState.currentCharge / chargeState.maxCapacity) *
                    100.0) ||
            (endHeartbeat == true) ||
            (chargeState.chargeSessionStarted == false);
        if (widget.isCharging) {
          if (chargeState.stopwatch.isRunning) {
            debugPrint("\n ************* endChargingCleanUp ************* \n");
            endChargingCleanUp();
          }
          setState(() {
            chargeState.chargeSessionStarted = false;
            chargeState.stopwatch.stop();
            chargeState.intendedBLEDisconnect = true;
          });
          if (dcontext != null) {
            Navigator.pop(dcontext!);
            dcontext = null;
          }
          // timerObj!.cancel();
          widget.stopTimer = true;

          return chargingPage(context, chargeState, false);
        } else {
          return chargingPage(context, chargeState, true);
        }
    }
    return Text("ISSUE HAS OCCURRED - SHOULD NOT BE HERE");
  }
}
