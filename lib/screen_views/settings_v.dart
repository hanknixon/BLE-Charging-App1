import 'package:ble_app/navigation/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slider_button/slider_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:async';

import '../navigation/navbars.dart';
import '../utils/ui.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../ble.dart';
import '../blemessages.dart';
import '../main.dart';
import 'session_v.dart';

class SettingsV extends StatefulWidget implements PoppingWidget {
  SettingsV(
      {Key? key,
      required this.device,
      required this.services,
      this.bypassMode = false})
      : super(key: key);

  final BluetoothDevice device;
  final List<BluetoothService> services;
  final bool bypassMode;

  @override
  State<SettingsV> createState() => _SettingsVState();

  @override
  void pepareToPop(BuildContext context) async {
    if (!bypassMode) {
      bool shouldNavigateBack = true;
      Provider.of<ChargeSettings>(context, listen: false)
          .intendedBLEDisconnect = true;

      try {
        await device.disconnect().timeout(
            Duration(seconds: MCConstants.bleActionTimeoutSec), onTimeout: () {
          shouldNavigateBack = false;
        });
      } on Exception catch (e) {
        shouldNavigateBack = false;
        debugPrint("\nNotify Error $e\n");
      }

      TopNavBar.poppingWidget = this;
      TopNavBar.poppingWidgetContext = context;
      TopNavBar.shouldNavigateBack = shouldNavigateBack;
    }
  }

  void setSelectedInfo(ChargeSettings chargeSetting) {
    if (chargeSetting.isSelectedTime) {
      chargeSetting.setSelectedValue(chargeSetting.currentSliderValueTime);
    } else if (chargeSetting.isSelectedCost) {
      chargeSetting.setSelectedValue(chargeSetting.currentSliderValueCost);
    } else if (chargeSetting.isSelectedPerc) {
      chargeSetting.setSelectedValue(chargeSetting.currentSliderValuePercent);
    } else {
      debugPrint("\n ***** ERROR: UNKNOWN SELECTION ***** \n");
    }
  }

  void setRemainingTime(ChargeSettings chargeSetting) {
    switch (chargeSetting.settingsChoice) {
      case "Max Time":
        double percTime =
            ((chargeSetting.maxCapacity - chargeSetting.startingCharge) /
                    chargeSetting.chargeSpeed) *
                3.6e+6;
        double timeTime = chargeSetting.currentSelectedValue * 60000;
        chargeSetting.totalTime = percTime < timeTime ? percTime : timeTime;
        if (chargeSetting.totalTime < 0) {
          chargeSetting.totalTime = 0;
        }
        chargeSetting.timeSet = true;
        return;
      case "Max Cost":
        double percTime =
            ((chargeSetting.maxCapacity - chargeSetting.startingCharge) /
                    chargeSetting.chargeSpeed) *
                3.6e+6;
        double costTime = chargeSetting.currentSelectedValue *
            3.6e+6 /
            (chargeSetting.chargePrice * chargeSetting.chargeSpeed);
        chargeSetting.totalTime = percTime < costTime ? percTime : costTime;
        if (chargeSetting.totalTime < 0) {
          chargeSetting.totalTime = 0;
        }
        chargeSetting.timeSet = true;
        return;
      case "Charge %":
        chargeSetting.totalTime = (((chargeSetting.currentSelectedValue /
                        100.0 *
                        chargeSetting.maxCapacity) -
                    chargeSetting.startingCharge) /
                chargeSetting.chargeSpeed) *
            3.6e+6;
        if (chargeSetting.totalTime < 0 ||
            chargeSetting.currentSelectedValue ==
                chargeSetting.startingCharge) {
          chargeSetting.totalTime = 0;
        }
        chargeSetting.timeSet = true;
        return;
    }
  }
}

class _SettingsVState extends State<SettingsV> {
  int index = 0;

  List<Widget> _chargeSettingsCard(
      {required bool isExpanded,
      required ChargeSettings chargeSetting,
      required TextEditingController ctrl,
      required String settingString,
      required String settingMessage,
      required String settingInputHint,
      required double sliderValue,
      required double maxValue,
      required Function(String? value) radioOnChanged,
      required Function(double) sliderOnChanged,
      required Function() textOnTap,
      required bool Function(String inputValue) textOnSubmitted}) {
    bool isValidText = true;

    List<Widget> result = [
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(width: MCUI.adjustedWidthWithCotext(64, context)),
        SizedBox(
            width: 20,
            child: Radio<String>(
              fillColor: WidgetStateProperty.resolveWith<Color>(
                  (Set<WidgetState> states) {
                return MCColors.green;
              }),
              value: settingString,
              groupValue: chargeSetting.settingsChoice,
              onChanged: (String? value) {
                setState(() {
                  radioOnChanged(value);
                });
              },
            )),
        Expanded(
            child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(settingString,
                          style: TextStyle(fontSize: 15, color: MCColors.grey)),
                      Text(settingMessage,
                          style: TextStyle(fontSize: 15, color: MCColors.grey))
                    ]))),
        SizedBox(width: MCUI.adjustedWidthWithCotext(64, context)),
      ])
    ];

    if (isExpanded) {
      result.addAll([
        Padding(
            padding: EdgeInsets.only(
                left: MCUI.adjustedWidthWithCotext(44, context),
                right: MCUI.adjustedWidthWithCotext(44, context)),
            child: Slider(
              activeColor: isExpanded ? MCColors.green : MCColors.greyLight,
              value: sliderValue,
              max: maxValue,
              min: 0,
              onChanged: (double value) {
                setState(() {
                  sliderOnChanged(value);
                  isValidText = true;
                });
              },
            )),
        SizedBox(height: MCUI.adjustedHeightWithCotext(8, context)),
        Padding(
            padding: EdgeInsets.only(left: 64),
            child: SizedBox(
                width: MCUI.adjustedWidthWithCotext(167, context),
                height: MCUI.adjustedHeightWithCotext(40, context),
                child: TextField(
                  controller: ctrl,
                  style: TextStyle(
                    color: isExpanded ? MCColors.grey : MCColors.greyLight,
                  ),
                  onTap: () {
                    ctrl.clear();
                    textOnTap();
                  },
                  onSubmitted: (inputValue) {
                    isValidText = textOnSubmitted(inputValue);
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    errorText: isValidText ? null : "Please enter valid Number",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: MCColors.greyLight,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: MCColors.green,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    hintText: settingInputHint,
                    hintStyle: TextStyle(color: MCColors.greyLight),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                )))
      ]);
    }

    return result;
  }

  Widget _cardDivider({required bool isTopExpanded}) {
    return Column(children: [
      Padding(
          padding: EdgeInsets.only(
              left: MCUI.adjustedWidthWithCotext(64, context),
              right: MCUI.adjustedWidthWithCotext(64, context),
              top: isTopExpanded
                  ? MCUI.adjustedHeightWithCotext(32, context)
                  : MCUI.adjustedHeightWithCotext(10, context)),
          child: Container(height: 1, color: MCColors.green)),
      SizedBox(height: MCUI.adjustedHeightWithCotext(10, context))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    TopNavBar.poppingWidget = widget;
    TopNavBar.poppingWidgetContext = context;

    double slideBtnHeight =
        MCUI.adjustedHeightWithCotext(MCConstants.ctaBtnHeight, context);

    var ctrlTime = TextEditingController();
    var ctrlCost = TextEditingController();
    var ctrlPercent = TextEditingController();

    var chargeState = context.watch<ChargeSettings>();

    BuildContext? dcontext;

    int timestamp;
    DateTime tsdate;
    timestamp = DateTime.now().millisecondsSinceEpoch;
    tsdate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    chargeState.setDateTime(tsdate);

    Future<void> showNeedToSwipeAgain(String dispalyText) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          dcontext = context;
          return AlertDialog(
            title: Text(dispalyText),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  dcontext = null;
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
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

    var s, c;
    for (s in widget.services) {
      for (c in s.characteristics) {
        if (c.uuid == characteristicsUUID) {
          break;
        }
      }
    }

    chargeState.chargeSessionStarted = true;

    return Consumer<ChargeSettings>(
        builder: (context, chargeSetting, child) => Material(
            color: MCColors.white,
            child: SingleChildScrollView(
              child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height:
                                  MCUI.adjustedHeightWithCotext(34, context)),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: MCUI.adjustedWidthWithCotext(
                                      64, context)),
                              child: Text("Select Charging Type",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: MCColors.green))),
                          SizedBox(
                              height:
                                  MCUI.adjustedHeightWithCotext(8, context)),
                          AnimatedContainer(
                              duration: Duration(seconds: 0),
                              curve: Curves.easeInOut,
                              child: InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  onTap: () {
                                    setState(() {
                                      chargeSetting.changeSelection(
                                          "Max Time", true, false, false);
                                    });
                                  },
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _chargeSettingsCard(
                                          chargeSetting: chargeSetting,
                                          isExpanded:
                                              chargeSetting.isSelectedTime,
                                          ctrl: ctrlTime,
                                          settingString: "Max Time",
                                          settingMessage:
                                              "${chargeSetting.currentSliderValueTime.round().toString()} Minute(s)",
                                          settingInputHint: "Input Time",
                                          sliderValue: chargeSetting
                                              .currentSliderValueTime,
                                          maxValue: chargeSetting.maxTime,
                                          radioOnChanged: (String? value) {
                                            chargeSetting.changeSelection(
                                                value, true, false, false);
                                          },
                                          sliderOnChanged: (double value) {
                                            chargeSetting
                                                .currentSliderValueTime = value;
                                            ctrlTime.text =
                                                value.round().toString();
                                            chargeSetting.changeSelection(
                                                "Max Time", true, false, false);
                                          },
                                          textOnTap: () {},
                                          textOnSubmitted: (String inputValue) {
                                            if (inputValue.isNotEmpty &&
                                                (double.parse(inputValue) >=
                                                        0.00 &&
                                                    double.parse(inputValue) <=
                                                        chargeSetting
                                                            .maxTime)) {
                                              setState(() {
                                                chargeSetting
                                                        .currentSliderValueTime =
                                                    double.parse(inputValue);
                                                ctrlTime.text = inputValue;
                                                ctrlTime.text = "";
                                              });
                                              return true;
                                            } else {
                                              setState(() {
                                                chargeSetting
                                                    .currentSliderValueTime = 0;
                                                ctrlTime.text = "0";
                                              });
                                              return false;
                                            }
                                          })))),
                          _cardDivider(
                              isTopExpanded: chargeSetting.isSelectedTime),
                          AnimatedContainer(
                              duration: Duration(seconds: 0),
                              curve: Curves.easeInOut,
                              child: InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  onTap: () {
                                    setState(() {
                                      chargeSetting.changeSelection(
                                          "Max Cost", false, true, false);
                                    });
                                  },
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _chargeSettingsCard(
                                          chargeSetting: chargeSetting,
                                          isExpanded:
                                              chargeSetting.isSelectedCost,
                                          ctrl: ctrlCost,
                                          settingString: "Max Cost",
                                          settingMessage:
                                              "\$${chargeSetting.currentSliderValueCost.toStringAsFixed(2)}",
                                          settingInputHint: "Input Cost",
                                          sliderValue: chargeSetting
                                              .currentSliderValueCost,
                                          maxValue: chargeSetting.maxCost,
                                          radioOnChanged: (String? value) {
                                            chargeSetting.changeSelection(
                                                value, false, true, false);
                                          },
                                          sliderOnChanged: (double value) {
                                            chargeSetting
                                                .currentSliderValueCost = value;
                                            ctrlCost.text =
                                                value.round().toString();
                                            chargeSetting.changeSelection(
                                                "Max Cost", false, true, false);
                                          },
                                          textOnTap: () {},
                                          textOnSubmitted: (String inputValue) {
                                            if (inputValue.isNotEmpty &&
                                                (double.parse(inputValue) >=
                                                        0.00 &&
                                                    double.parse(inputValue) <=
                                                        chargeSetting
                                                            .maxCost)) {
                                              setState(() {
                                                chargeSetting
                                                        .currentSliderValueCost =
                                                    double.parse(inputValue);
                                                ctrlCost.text = inputValue;
                                                ctrlCost.text = "";
                                              });
                                              return true;
                                            } else {
                                              setState(() {
                                                chargeSetting
                                                    .currentSliderValueCost = 0;
                                                ctrlCost.text = "0";
                                              });
                                              return false;
                                            }
                                          })))),
                          _cardDivider(
                              isTopExpanded: chargeSetting.isSelectedCost),
                          AnimatedContainer(
                              duration: Duration(seconds: 0),
                              curve: Curves.easeInOut,
                              child: InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  onTap: () {
                                    setState(() {
                                      chargeSetting.changeSelection(
                                          "Charge %", false, false, true);
                                    });
                                  },
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _chargeSettingsCard(
                                          chargeSetting: chargeSetting,
                                          isExpanded:
                                              chargeSetting.isSelectedPerc,
                                          ctrl: ctrlPercent,
                                          settingString: "Charge %",
                                          settingMessage:
                                              "${chargeSetting.currentSliderValuePercent.round().toString()}%",
                                          settingInputHint: "Input Percentage",
                                          sliderValue: chargeSetting
                                              .currentSliderValuePercent,
                                          maxValue: chargeSetting.maxCapacity,
                                          radioOnChanged: (String? value) {
                                            chargeSetting.changeSelection(
                                                value, false, false, true);
                                          },
                                          sliderOnChanged: (double value) {
                                            chargeSetting
                                                    .currentSliderValuePercent =
                                                value;
                                            ctrlPercent.text =
                                                value.round().toString();
                                            chargeSetting.changeSelection(
                                                "Charge %", false, false, true);
                                          },
                                          textOnTap: () {},
                                          textOnSubmitted: (String inputValue) {
                                            if (inputValue.isNotEmpty &&
                                                (double.parse(inputValue) >=
                                                        0.00 &&
                                                    double.parse(inputValue) <=
                                                        chargeSetting
                                                            .maxCapacity)) {
                                              setState(() {
                                                chargeSetting
                                                        .currentSliderValuePercent =
                                                    double.parse(inputValue);
                                                ctrlPercent.text = inputValue;
                                                ctrlPercent.text = "";
                                              });
                                              return true;
                                            } else {
                                              setState(() {
                                                chargeSetting
                                                    .currentSliderValuePercent = 0;
                                                ctrlPercent.text = "0";
                                              });
                                              return false;
                                            }
                                          })))),
                          SizedBox(
                            height: 60,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MCUI.adjustedWidthWithCotext(44, context),
                                right:
                                    MCUI.adjustedWidthWithCotext(44, context),
                                bottom:
                                    MCUI.adjustedHeightWithCotext(32, context)),
                            child: AbsorbPointer(
                                absorbing: chargeSetting.settingsChoice == null,
                                child: Container(
                                  width: MCUI.adjustedWidthWithCotext(
                                      MCConstants.ctaBtnWidth, context),
                                  height: slideBtnHeight,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: chargeSetting.settingsChoice !=
                                                  null
                                              ? MCColors.green
                                              : MCColors.greyLight),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(slideBtnHeight / 2))),
                                  child: Consumer<ChargeSettings>(
                                      builder: (context, chargeSetting, child) {
                                    return SliderButton(
                                        width: MCUI.adjustedWidthWithCotext(
                                            305, context),
                                        height: slideBtnHeight,
                                        buttonSize: slideBtnHeight,
                                        backgroundColor: MCColors.white,
                                        buttonColor:
                                            chargeSetting.settingsChoice != null
                                                ? MCColors.green
                                                : MCColors.greyLight,
                                        highlightedColor: MCColors.grey,
                                        shimmer: false,
                                        alignLabel: Alignment(0, 0),
                                        label: Text(
                                          "Swipe to Start",
                                          style: TextStyle(
                                              color: chargeSetting
                                                          .settingsChoice !=
                                                      null
                                                  ? MCColors.green
                                                  : MCColors.greyLight,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        icon: Center(
                                          child: SvgPicture.asset(
                                            'assets/images/slide_button_icon.svg',
                                            width: MCUI.adjustedWidthWithCotext(
                                                30, context),
                                          ),
                                        ),
                                        action: () async {
                                          if (widget.bypassMode) {
                                            NavigatorMain.navStack.push(
                                                NavStackRecord(
                                                    widget, context));
                                            await Future.delayed(Duration(
                                                milliseconds:
                                                    10)); // let UI settle
                                            Navigator.of(context).push(
                                              MCUI.getSlideAnimationRouteBuilder(
                                                SessionV(
                                                  device: widget.device,
                                                  services: widget.services,
                                                  dateTime:
                                                      chargeState.datetime,
                                                  settingChoice: chargeSetting
                                                      .settingsChoice!,
                                                  selectedValue: chargeState
                                                      .currentSelectedValue,
                                                ),
                                              ),
                                            );
                                          }
                                          chargeSetting.startSession();
                                          MCUI.showProgressOverlayWithBackground(
                                              msg: "Charging Starting");
                                          setState(() {
                                            index = 2;
                                            startCharging = false;
                                            responseChargingRecieved = false;
                                            responseAuthenticationRecieved =
                                                false;
                                          });

                                          try {
                                            widget
                                                .setSelectedInfo(chargeSetting);
                                            widget.setRemainingTime(
                                                chargeSetting);

                                            bool state2 =
                                                await writeAuthenticationMessage(
                                                    c, chargeSetting);
                                            if (state2 == false) {}

                                            await waitWhile(() =>
                                                    responseAuthenticationRecieved)
                                                .timeout(
                                                    const Duration(seconds: 10),
                                                    onTimeout: () =>
                                                        setState(() {
                                                          index = 0;
                                                          if (dcontext !=
                                                              null) {
                                                            dcontext = null;
                                                          }
                                                          showNeedToSwipeAgain(
                                                              "Failed to Authenticate, Please Reswipe");
                                                        }));
                                            if (responseAuthenticationRecieved ==
                                                true) {
                                              bool state3 =
                                                  await writeChargingMessage(c);
                                              if (state3 == true) {}
                                            } else {
                                              debugPrint(
                                                  "\n ************* responseAuthenticationRecieved NO RESPONSE ************* \n");
                                            }
                                          } on Exception catch (e) {
                                            debugPrint("\nNotify Error $e\n");
                                          }
                                          if (responseAuthenticationRecieved ==
                                              true) {
                                            await waitWhile(() =>
                                                    responseChargingRecieved)
                                                .timeout(
                                                    const Duration(seconds: 10),
                                                    onTimeout: () =>
                                                        setState(() {
                                                          index = 0;
                                                          if (dcontext !=
                                                              null) {
                                                            dcontext = null;
                                                          }
                                                          showNeedToSwipeAgain(
                                                              "Failed to Start Charge, Please Reswipe");
                                                        }));

                                            if (responseChargingRecieved ==
                                                true) {
                                              if (dcontext != null) {
                                                dcontext = null;
                                              }
                                              debugPrint(
                                                  "\n ************* responseChargingRecieved $dcontext ************* \n");

                                              await waitWhile(
                                                  () => startCharging);

                                              setState(() {
                                                index = 1;
                                              });
                                              if (dcontext != null) {
                                                dcontext = null;
                                              }
                                              debugPrint(
                                                  "\n ************* firstDiagnosticRecieved $firstDiagnosticRecieved $currentChargerState************* \n");
                                            } else {
                                              debugPrint(
                                                  "\n ************* responseChargingRecieved NO RESPONSE ************* \n");
                                            }
                                          }

                                          if (context.mounted &&
                                              startCharging == true) {
                                            NavigatorMain.navStack.push(
                                                NavStackRecord(
                                                    widget, context));
                                            Future.delayed(const Duration(
                                                    milliseconds: MCUI
                                                        .backBtnDisplayDelayMilSec))
                                                .then((val) {
                                              backBtnVisible.value = false;
                                            });
                                            await Navigator.of(context).push(
                                              MCUI.getSlideAnimationRouteBuilder(
                                                  SessionV(
                                                device: widget.device,
                                                services: widget.services,
                                                dateTime: chargeState.datetime,
                                                settingChoice: chargeSetting
                                                    .settingsChoice!,
                                                selectedValue: chargeSetting
                                                    .currentSelectedValue,
                                              )),
                                            );
                                          }
                                          return null;
                                        });
                                  }),
                                )),
                          )
                        ]),
                  ]),
            )));
  }
}
