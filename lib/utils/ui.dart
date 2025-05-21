
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../main.dart';
import 'colors.dart';
import 'constants.dart';


class MCUI {
  static const int backBtnDisplayDelayMilSec = 300;

  static const double overlayOpacity = 0.95;

  static double adjustedHeightWithCotext(double height, BuildContext context) {
    double ratio = height / 851;
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * ratio;
  }

  static double adjustedWidthWithCotext(double width, BuildContext context) {
    double ratio = width / 393;
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * ratio;
  }

  static getSlideAnimationRouteBuilder(Widget destination) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destination,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static void showProgressOverlay() {
    showGeneralDialog(
        context: ctxScreen!,
        barrierColor: Colors.transparent,
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: 2,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation(MCColors.greenDark),
                        ),
                      ),
                    ]),
              ));
        });
  }

  static void dismissOverlay() {
    Navigator.pop(ctxScreen!);
  }

  static void showInfoOverlay({required String msg, autodismiss = true}) {
    showGeneralDialog(
        context: ctxScreen!,
        barrierColor: MCColors.green.withOpacity(MCUI.overlayOpacity), // Background color
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        msg,
                        style: TextStyle(fontSize: 32, color: MCColors.white),
                      ),
                    ]),
              ));
        });

    if (autodismiss) {
      Future.delayed(const Duration(seconds: 2)).then((val) {
        Navigator.pop(ctxScreen!);
      });
    }
  }

  static void showProgressOverlayWithBackground(
      {required String msg, autodismiss = true}) {
    showGeneralDialog(
        context: ctxScreen!,
        barrierColor: MCColors.green.withOpacity(MCUI.overlayOpacity), // Background color
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.scale(
                      scale: 2,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(MCColors.white),
                      ),
                    ),
                    SizedBox(
                      height: MCUI.adjustedHeightWithCotext(36, ctxScreen!),
                    ),
                    Text(
                      msg,
                      style: TextStyle(fontSize: 32, color: MCColors.white),
                    ),
                    SizedBox(
                      height: MCUI.adjustedHeightWithCotext(100, ctxScreen!),
                    ),
                  ]),
            ),
            //)
          );
        });

    if (autodismiss) {
      Future.delayed(const Duration(seconds: 2)).then((val) {
        Navigator.pop(ctxScreen!);
      });
    }
  }

  static void showErrorOverlay(
      {required String message, String buttonTitle="Dismiss", autodismiss = true}) {
    showGeneralDialog(
        context: ctxScreen!,
        barrierColor: MCColors.errorRed
            .withOpacity(MCUI.overlayOpacity), // Background color
        barrierDismissible: false,
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Transform.scale(
                        scale: 2,
                        child: SvgPicture.asset('assets/images/error_icon.svg',
                            width:
                                MCUI.adjustedWidthWithCotext(90, ctxScreen!))),
                    SizedBox(
                      height: MCUI.adjustedHeightWithCotext(46, ctxScreen!),
                    ),
                    Text(
                      "Error",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: MCConstants.letterSpacing1,
                          color: MCColors.white),
                    ),
                    SizedBox(
                      height: MCUI.adjustedHeightWithCotext(21, ctxScreen!),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                      child: Text(
                        message,
                        style: TextStyle(
                            fontSize: 20,
                            letterSpacing: MCConstants.letterSpacing1,
                            color: MCColors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: MCUI.adjustedHeightWithCotext(160, ctxScreen!),
                    ),
                    Center(
                  child: Visibility(
                    visible: !autodismiss,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          fixedSize: Size(
                              MCUI.adjustedWidthWithCotext(305, ctxScreen!),
                              MCUI.adjustedHeightWithCotext(67, ctxScreen!)),
                          backgroundColor: Colors.transparent,
                          //overlayColor: MCColors.green,
                          side: BorderSide(
                            width: 1,
                            color: MCColors.white,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                MCConstants.ctaBtnCornerRadius),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(ctxScreen!);
                        },
                        child: Text(buttonTitle,
                            style: TextStyle(
                                fontSize: 17,
                                letterSpacing: MCConstants.letterSpacing1,
                                color: MCColors.white,
                                fontWeight: FontWeight.bold))),
                  ),
                ),
                SizedBox(
                      height: MCUI.adjustedHeightWithCotext(130, ctxScreen!),
                    ),
                  ]),
            ),
            //)
          );
        });

    if (autodismiss) {
      Future.delayed(const Duration(seconds: 2)).then((val) {
        Navigator.pop(ctxScreen!);
      });
    }
  }

}

