import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:here_sdk/core.dart';
import 'ble.dart';
import 'navigation/navigation.dart';
import 'navigation/navbars.dart';
import 'utils/colors.dart';

/// Characterstics UUID set to Microchip Transparent UART UUID
Guid characteristicsUUID = Guid(
    "49535343-1e4d-4bd9-ba61-23c647249616");

/// Data stream of BLE connection saved
List<StreamSubscription> connectionSubStream = [];

/// Setup providers for the settings within the app and call the app setup
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  
  // Load environment variables
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print('Error loading .env file: $e');
  }
  
  // HERE SDK will be initialized in MainActivity.kt
  // No need to initialize here
  SdkContext.init(IsolateOrigin.main);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ScanSettings()),
        ChangeNotifierProvider(create: (context) => ChargeSettings()),
      ],
      child: MyApp(),
    ),
  );
}



final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

/// Setup of themes and colors for the app and call the home page to be built
class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      // TODO: Add App icon and change name of app
      title: 'EV Charging App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Inter",
      ),
      home: MyHomePage()
    );
  }
}

/// Variables and functions to save data from a QR Code scan
///
/// @class
/// @classdesc ChangeNotifier to keep track of infomation that is shared by different pages
class ScanSettings extends ChangeNotifier {
  BarcodeCapture? capture;
  String btAddress = "";
  String pwd = "";
  String chargerName = "Unknown";
  bool scanQR = false;
  String operatorID = '1234';
  String sessionID = '';
  bool messageListen = false;
  String PrevConnectedBtAddress = "";

  /// Get the Information from the QR code capture and call the parse function to save the data
  ///
  /// @param {BarcodeCapture} capture - the captured frame from scanning a QR code
  void setCapture(BarcodeCapture? capture) {
    // capture!.image!.removeAt(0); //added so that it does not reuse old image
    this.capture = capture;
    var splitted =
        this.capture!.barcodes.first.displayValue.toString().split(' ');
    // savebtAddress(splitted[1]);
    // savePwd(splitted[3]);
    saveInfo(splitted);
    notifyListeners();
  }

  /// Parses a String List to get the BLE address, Pin code (unused), Charge Station Name
  ///
  /// @param {List<String>} data - data from the QR code in list string format
  void saveInfo(List<String> data) {
    btAddress = data[0];
    PrevConnectedBtAddress = btAddress;
    pwd = data[1];
    chargerName = '';
    if (data.length > 2) {
      for (int i = 2; i < data.length; i++) {
        chargerName += "${data[i]} ";
      }
      chargerName = chargerName.trimRight();
    } else {
      chargerName = 'Charger';
    }

    notifyListeners();
  }

  /// Setter function to set the BLE Adress of the Charge station
  ///
  /// @param {String} btAddress - string format of the BLE address
  void saveBtAddress(String btAddress) {
    this.btAddress = btAddress;
    notifyListeners();
  }

  /// Setter function to set the pin/password of the Charge Station
  ///
  /// @param {String} pwd - string format of the password/pin
  void savePwd(String pwd) {
    this.pwd = pwd;
    notifyListeners();
  }

  /// Setter function to set the name of the Charge Station
  ///
  /// @param {String} name - string format of the Charge Station name
  void saveChargerName(String name) {
    chargerName = name;
    notifyListeners();
  }

  /// Setter function to set a flag if the camera view has been opened
  void scanQROpened() {
    scanQR = !scanQR;
    notifyListeners();
  }

  /// Setter function to clear and return to default values of the ScanSettings
  void reset() {
    saveBtAddress("");
    saveChargerName("Unknown");
    capture = null;
    // operatorID = '1234';
    // sessionID = '';
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// Context reference for full screen UI.
BuildContext? ctxScreen;

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    ctxScreen = context;

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        backgroundColor: MCColors.white,
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 20), child: TopNavBar()),
          Expanded(child: NavigatorMain.navigator()),
        ]),
        bottomNavigationBar: BottomNavBar());
  }
}