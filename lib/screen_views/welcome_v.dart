import 'package:flutter/material.dart';

import '../navigation/navigation.dart';
import '../utils/ui.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import 'scanner_v.dart';

class WelcomeV extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MCColors.white,
      body: SingleChildScrollView(
        // ✅ Make it scrollable
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MCUI.adjustedHeightWithCotext(60, context)),
            SizedBox(
              width: MCUI.adjustedWidthWithCotext(280, context),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Scan the Station's",
                  style: TextStyle(
                    fontSize: 32,
                    color: MCColors.grey,
                    letterSpacing: MCConstants.letterSpacing1,
                    height: 1.2,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: " QR code ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: MCConstants.letterSpacing1,
                        fontSize: 32,
                        color: MCColors.green,
                      ),
                    ),
                    TextSpan(
                      text: "to start charging your EV",
                      style: TextStyle(
                        fontSize: 32,
                        color: MCColors.grey,
                        letterSpacing: MCConstants.letterSpacing1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MCUI.adjustedHeightWithCotext(32, context)),
            Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  fixedSize: Size(
                    MCUI.adjustedWidthWithCotext(
                        MCConstants.ctaBtnWidth, context),
                    MCUI.adjustedHeightWithCotext(
                        MCConstants.ctaBtnHeight, context),
                  ),
                  backgroundColor: MCColors.white,
                  overlayColor: MCColors.green,
                  side: BorderSide(width: 1, color: MCColors.green),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(MCConstants.ctaBtnCornerRadius),
                  ),
                ),
                onPressed: () {
                  NavigatorMain.navStack.push(NavStackRecord(this, context));
                  Future.delayed(const Duration(
                          milliseconds: MCUI.backBtnDisplayDelayMilSec))
                      .then((val) {
                    backBtnVisible.value = NavigatorMain.navStack.isNotEmpty;
                  });
                  Navigator.of(context)
                      .push(MCUI.getSlideAnimationRouteBuilder(ScannerV()));
                  ScannerV.createScanner();
                  ScannerV.startScanner();
                },
                child: Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: 17,
                    letterSpacing: MCConstants.letterSpacing1,
                    color: MCColors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Replaces the Expanded
            Container(
              height: MCUI.adjustedHeightWithCotext(336, context),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/welcome_background.jpg"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
