import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../utils/ui.dart';
import '../utils/colors.dart';
import '../main.dart';
import '../navigation/navigation.dart';
import 'connect_v.dart';
import 'dart:typed_data';

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
  // Test QR code data
  final String testQRData = "34:81:F4:D0:8E:74 1234 Test_EVSE";

  void handleSuccessfulScan(BuildContext context, ScanSettings scanSettings) {
    // Create a fake capture for the test QR code
    final fakeBarcode = Barcode(
      rawValue: testQRData,
      displayValue: testQRData,
      format: BarcodeFormat.qrCode,
    );
    
    final fakeCapture = BarcodeCapture(
      barcodes: [fakeBarcode],
      image: null,
      raw: Uint8List(0),
    );

    scanSettings.setCapture(fakeCapture);
    scanSettings.scanQROpened();
    
    ScannerV.stopScanner();
    
    NavigatorMain.navStack.push(NavStackRecord(widget, context));
    Future.delayed(const Duration(milliseconds: MCUI.backBtnDisplayDelayMilSec))
        .then((val) {
      backBtnVisible.value = NavigatorMain.navStack.isNotEmpty;
    });
    
    Navigator.of(context).push(
      MCUI.getSlideAnimationRouteBuilder(ConnectV()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var scanSettings = context.watch<ScanSettings>();

    return Scaffold(
      backgroundColor: MCColors.white,
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            height: MCUI.adjustedHeightWithCotext(336, context),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/welcome_background.jpg"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Test QR Code',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: MCColors.green,
                      ),
                    ),
                    SizedBox(height: 10),
                    QrImageView(
                      data: testQRData,
                      version: QrVersions.auto,
                      size: 200.0,
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(height: 20),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: MCColors.white,
                        side: BorderSide(color: MCColors.green),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => handleSuccessfulScan(context, scanSettings),
                      child: Text(
                        'Simulate QR Scan',
                        style: TextStyle(color: MCColors.green),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
