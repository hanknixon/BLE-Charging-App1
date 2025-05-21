
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'navigation.dart';
import '../utils/ui.dart';
import '../utils/colors.dart';


class TopNavBar extends StatelessWidget {
  static Widget? poppingWidget;
  static BuildContext? poppingWidgetContext;
  static bool shouldNavigateBack = true;

  static void navigateBack(BuildContext context) {
    if (NavigatorMain.navStack.isNotEmpty) {
      if (poppingWidget != null &&
          poppingWidgetContext != null &&
          poppingWidget is PoppingWidget) {
        (poppingWidget as PoppingWidget).pepareToPop(context);
        if (shouldNavigateBack) {
          poppingWidget = null;
          poppingWidgetContext = null;
        }
      }
      if (!shouldNavigateBack) {
        shouldNavigateBack = true;
        return;
      }
      NavStackRecord navRecord = NavigatorMain.navStack.peek;
      if (navRecord.backWidget is PopTargetWidget) {
        (navRecord.backWidget as PopTargetWidget).pepare(context);
      }
      Future.delayed(
              const Duration(milliseconds: MCUI.backBtnDisplayDelayMilSec))
          .then((val) {
        backBtnVisible.value = NavigatorMain.navStack.isNotEmpty;
      });
      Navigator.of(navRecord.backContext)
          .pop(MCUI.getSlideAnimationRouteBuilder(navRecord.backWidget));
      NavigatorMain.navStack.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: AlignmentDirectional.centerStart,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: MCUI.adjustedHeightWithCotext(100, context),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: MCColors.grey.withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 20,
                offset: Offset(0, 0),
              ),
            ]),
            child: Container(
              color: MCColors.white,
              height: 60,
            ),
          ),
          Center(
              child: Container(
            width: MCUI.adjustedWidthWithCotext(160, context),
            height: MCUI.adjustedHeightWithCotext(60, context),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/logo.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
          )),
          ValueListenableBuilder(
            valueListenable: backBtnVisible,
            builder: (context, value, widget) {
              return Visibility(
                  visible: backBtnVisible.value,
                  child: Positioned(
                      child: Container(
                    padding: EdgeInsets.only(
                        left: MCUI.adjustedHeightWithCotext(24, context),
                        right: MCUI.adjustedHeightWithCotext(24, context)),
                    decoration: BoxDecoration(
                        color: MCColors.greenLight, shape: BoxShape.circle),
                    child: IconButton(
                      enableFeedback: false,
                      iconSize: 32,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        navigateBack(context);
                      },
                      icon: SvgPicture.asset('assets/images/back_arrow.svg'),
                    ),
                  )));
            },
          ),
        ]);
  }
}


class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MCUI.adjustedHeightWithCotext(100, context),
        decoration: BoxDecoration(
          color: MCColors.white,
          boxShadow: [
            BoxShadow(
              color: MCColors.grey.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 20,
              offset: Offset(0, 0),
            ),
          ],
        ),
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                IconButton(
                  enableFeedback: false,
                  iconSize: 32,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.all(0),
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/images/tab_map.svg'),
                ),
                Container(
                    height: 20,
                    alignment: Alignment.topCenter,
                    child: Text("Map",
                        style: TextStyle(color: MCColors.grey, fontSize: 12)))
              ]),
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                IconButton(
                  enableFeedback: false,
                  iconSize: 32,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.all(0),
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/images/tab_charge.svg'),
                ),
                Container(
                    height: 20,
                    alignment: Alignment.topCenter,
                    child: Text("Charge",
                        style: TextStyle(color: MCColors.green, fontSize: 12)))
              ]),
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                IconButton(
                  enableFeedback: false,
                  iconSize: 32,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.all(0),
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/images/tab_community.svg'),
                ),
                Container(
                    height: 20,
                    alignment: Alignment.topCenter,
                    child: Text("Community",
                        style: TextStyle(color: MCColors.grey, fontSize: 12)))
              ]),
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                IconButton(
                  enableFeedback: false,
                  iconSize: 32,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.all(0),
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/images/tab_account.svg'),
                ),
                Container(
                    height: 20,
                    alignment: Alignment.topCenter,
                    child: Text("Account",
                        style: TextStyle(color: MCColors.grey, fontSize: 12)))
              ]),
            ],
          ),
        ));
  }
}

