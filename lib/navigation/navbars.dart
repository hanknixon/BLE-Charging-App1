import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'navigation.dart';
import '../utils/ui.dart';
import '../utils/colors.dart';
import '../screen_views/account_v.dart';

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
  Widget _buildNavItem(BuildContext context, String label, String iconPath, VoidCallback onTap, bool isSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          enableFeedback: false,
          iconSize: 32,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.all(0),
          onPressed: onTap,
          icon: SvgPicture.asset(
            iconPath,
            color: isSelected ? MCColors.green : MCColors.grey,
          ),
        ),
        Container(
          height: 20,
          alignment: Alignment.topCenter,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? MCColors.green : MCColors.grey,
              fontSize: 12
            )
          )
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '';
    final isAccountPage = context.widget is AccountV;
    final isChargePage = currentRoute == '/charge';

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
              _buildNavItem(
                context, 
                'Map', 
                'assets/images/tab_map.svg',
                () {
                  if (isAccountPage) {
                    Navigator.of(context).pop();
                  }
                },
                false
              ),
              _buildNavItem(
                context, 
                'Charge', 
                'assets/images/tab_charge.svg',
                () {
                  if (isAccountPage) {
                    Navigator.of(context).pop();
                  }
                },
                !isAccountPage && !isChargePage
              ),
              _buildNavItem(
                context, 
                'Community', 
                'assets/images/tab_community.svg',
                () {
                  if (isAccountPage) {
                    Navigator.of(context).pop();
                  }
                },
                false
              ),
              _buildNavItem(
                context, 
                'Account', 
                'assets/images/tab_account.svg',
                () {
                  if (!isAccountPage) {
                    NavigatorMain.navStack.push(NavStackRecord(this, context));
                    Navigator.of(context).push(
                      MCUI.getSlideAnimationRouteBuilder(AccountV()),
                    );
                  }
                },
                isAccountPage
              ),
            ],
          ),
        ));
  }
}