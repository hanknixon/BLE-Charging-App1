
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/ui.dart';
import '../utils/colors.dart';
import '../main.dart';
import '../navigation/navigation.dart';
import 'connect_v.dart';


class ScannerV extends StatefulWidget implements PopTargetWidget {
  @override
  State<ScannerV> createState() => _ScannerVState();

  static MobileScannerController? _scanner;

  static MobileScannerController get scanner {
    if (_scanner == null) {
      createScanner();
    }
    return _scanner!;
  }

  static void createScanner() {
    _scanner = MobileScannerController(
      torchEnabled: true, 
      autoStart: false
      );
  }

  static void startScanner() {
    scanner.start();
  }

  static void stopScanner() {
    scanner.stop();
  }

  @override
  void pepare(BuildContext context) {
    startScanner();
  }
}

class _ScannerVState extends State<ScannerV> {
  Widget cameraView() {
    var scanSettings = context.watch<ScanSettings>();

    return Builder(
      builder: (context) {
        return RotatedBox(
          quarterTurns:
              MediaQuery.of(context).orientation == Orientation.landscape
                  ? 3
                  : 0,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: MobileScanner(
                startDelay: false,
                controller: ScannerV.scanner,
                fit: BoxFit.fitHeight,
                onDetect: (capture) {
                  if (NavigatorMain.navStack.peek.backWidget != widget) {
                    NavigatorMain.navStack
                        .push(NavStackRecord(widget, context));
                    Future.delayed(const Duration(
                            milliseconds: MCUI.backBtnDisplayDelayMilSec))
                        .then((val) {
                      backBtnVisible.value = NavigatorMain.navStack.isNotEmpty;
                    });
                    ScannerV.stopScanner();
                    Navigator.of(context).push(
                      MCUI.getSlideAnimationRouteBuilder(ConnectV()),
                    );
                    setState(() {
                      scanSettings.setCapture(capture);
                      scanSettings.scanQROpened();
                    });
                  }
                },
              )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MCColors.white,
        body: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          clipBehavior: Clip.none,
          children: [
            Container(
              height: MCUI.adjustedHeightWithCotext(336, context),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/welcome_background.jpg"),
                    fit: BoxFit.fitWidth),
              ),
            ),
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                  width: MCUI.adjustedWidthWithCotext(19, context),
                  height: MCUI.adjustedHeightWithCotext(19, context)),
              Center(
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: MCUI.adjustedWidthWithCotext(336, context),
                      height: MCUI.adjustedHeightWithCotext(522, context),
                      child: cameraView()))
            ]),
            Positioned(
                top: MCUI.adjustedHeightWithCotext(126, context),
                left: MCUI.adjustedHeightWithCotext(20, context),
                right: MCUI.adjustedHeightWithCotext(20, context),
                child: SvgPicture.asset(
                  'assets/images/scanner_frame.svg',
                  alignment: Alignment.center,
                  width: MCUI.adjustedWidthWithCotext(276, context),
                  height: MCUI.adjustedHeightWithCotext(276, context),
                ))
          ],
        ));
  }
}

