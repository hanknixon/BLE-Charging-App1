import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:mockito/mockito.dart';

import 'package:ble_app/main.dart';
import 'package:ble_app/ble.dart';
import 'test_navigator_observer.dart';

import 'widget_main_test.mocks.dart';

@GenerateMocks([
  FlutterBluePlus,
  BluetoothDevice,
  ScanResult,
])
void main() {
  group('QR Code Tests', () {
    testWidgets('Camera should appear when Scan charger button is pressed',
        (WidgetTester tester) async {
      Widget testWidget = MediaQuery(
          data: MediaQueryData(), child: MaterialApp(home: MyHomePage()));
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => ScanSettings()),
            ChangeNotifierProvider(create: (context) => ChargeSettings()),
          ],
          child: Builder(
            builder: (_) => testWidget,
          ),
        ),
      );

      expect(
          find.descendant(
              of: find.byType(Center),
              matching:
                  find.widgetWithText(ElevatedButton, "Scan Charger Code")),
          findsOneWidget);

      await tester.tap(
        find.descendant(
            of: find.byType(Center),
            matching: find.widgetWithText(ElevatedButton, "Scan Charger Code")),
      );
      await tester.pumpAndSettle(Duration(seconds: 5));

      expect(
          find.descendant(
              of: find.byType(Center),
              matching: find.byType(BarcodeScannerPageView)),
          findsOneWidget);

      await tester.tap(
        find.descendant(
            of: find.byType(Center),
            matching: find.widgetWithText(ElevatedButton, "Scan Charger Code")),
      );
      await tester.pumpAndSettle(Duration(seconds: 5));
    });

    testWidgets(
        'Connect To Charger button should appear when BT address is saved ',
        (WidgetTester tester) async {
      Widget testWidget = MediaQuery(
          data: MediaQueryData(), child: MaterialApp(home: ConnectToDevice()));

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => ScanSettings()),
            ChangeNotifierProvider(create: (context) => ChargeSettings()),
          ],
          child: Builder(
            builder: (context) {
              return testWidget;
            },
          ),
        ),
      );
      final BuildContext context = tester.element(find.byWidget(testWidget));
      ScanSettings settings = Provider.of<ScanSettings>(context, listen: false);

      List<String> data = [
        "BTA:",
        "76:36:32:12:34",
        "PWD:",
        "1234",
        "NAME:",
        "Charger A"
      ];

      expect(
          find.descendant(
              of: find.byType(Center),
              matching:
                  find.widgetWithText(ElevatedButton, "Connect To Charger")),
          findsNothing);

      settings.saveInfo(data);

      await tester.pump();

      expect(
          find.descendant(
              of: find.byType(Center),
              matching:
                  find.widgetWithText(ElevatedButton, "Connect To Charger")),
          findsOneWidget);
    });

    testWidgets(
        'Connect To Charger button should attempt to connect to BT address but fails when button is clicked',
        (WidgetTester tester) async {
      TestNavigatorObserver navObserver = TestNavigatorObserver();
      var isPushed = false;
      Widget testWidget = MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
            home: ConnectToDevice(), navigatorObservers: [navObserver]),
      );
      List<String> data = [
        "BTA:",
        "76:36:32:12:34",
        "PWD:",
        "1234",
        "NAME:",
        "Charger A"
      ];

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => ScanSettings()),
            ChangeNotifierProvider(create: (context) => ChargeSettings()),
          ],
          child: Builder(
            builder: (context) {
              return testWidget;
            },
          ),
        ),
      );

      final BuildContext context = tester.element(find.byWidget(testWidget));
      ScanSettings settings = Provider.of<ScanSettings>(context, listen: false);

      expect(
          find.descendant(
              of: find.byType(Center),
              matching:
                  find.widgetWithText(ElevatedButton, "Connect To Charger")),
          findsNothing);

      settings.saveInfo(data);

      await tester.pump();

      expect(
          find.descendant(
              of: find.byType(Center),
              matching:
                  find.widgetWithText(ElevatedButton, "Connect To Charger")),
          findsOneWidget);

      navObserver.attachPushRouteObserver('/another_screen', () {
        isPushed = true;
      });

      await tester.tap(find.descendant(
        of: find.byType(Center),
        matching: find.widgetWithText(ElevatedButton, "Connect To Charger"),
      ));

      await tester.pump();

      expect(isPushed, false);
    });

    testWidgets(
        'Connect To Charger button should connect to BT address when button is clicked',
        (WidgetTester tester) async {
      TestNavigatorObserver navObserver = TestNavigatorObserver();
      var isPushed = false;
      Widget testWidget = MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
            home: ConnectToDevice(), navigatorObservers: [navObserver]),
      );
      List<String> data = [
        "BTA:",
        "76:36:32:12:34",
        "PWD:",
        "1234",
        "NAME:",
        "Charger A"
      ];

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => ScanSettings()),
            ChangeNotifierProvider(create: (context) => ChargeSettings()),
          ],
          child: Builder(
            builder: (context) {
              return testWidget;
            },
          ),
        ),
      );

      final BuildContext context = tester.element(find.byWidget(testWidget));
      ScanSettings settings = Provider.of<ScanSettings>(context, listen: false);
      final FlutterBluePlus flutterBlue = MockFlutterBluePlus();
      final BluetoothDevice myDevice = MockBluetoothDevice();
      bool isConnected = false;

      when(myDevice.connect().whenComplete(
            () => isConnected = true,
          ));
      expect(
          find.descendant(
              of: find.byType(Center),
              matching:
                  find.widgetWithText(ElevatedButton, "Connect To Charger")),
          findsNothing);

      settings.saveInfo(data);

      await tester.pump();

      expect(
          find.descendant(
              of: find.byType(Center),
              matching:
                  find.widgetWithText(ElevatedButton, "Connect To Charger")),
          findsOneWidget);

      navObserver.attachPushRouteObserver('/another_screen', () {
        isPushed = true;
      });

      await tester.tap(find.descendant(
        of: find.byType(Center),
        matching: find.widgetWithText(ElevatedButton, "Connect To Charger"),
      ));

      await tester.pump();
      await myDevice.connect();

      expect(isPushed, false);
      expect(isConnected, true);
    });
  });

  // group('Build Page based on current charger state', () {
  //   testWidgets(
  //       'buildCurrentStatePage should build charge settings page when current state is Idle',
  //       (WidgetTester tester) async {
  //     final BluetoothDevice device = MockBluetoothDevice();
  //     List<BluetoothService> services = [];
  //     TestNavigatorObserver navObserver = TestNavigatorObserver();

  //     Widget testWidget = MediaQuery(
  //       data: MediaQueryData(),
  //       child: MaterialApp(
  //           home: ConnectToDevice(), navigatorObservers: [navObserver]),
  //     );

  //     await tester.pumpWidget(
  //       MultiProvider(
  //         providers: [
  //           ChangeNotifierProvider(create: (context) => ScanSettings()),
  //           ChangeNotifierProvider(create: (context) => ChargeSettings()),
  //         ],
  //         child: Builder(
  //           builder: (context) {
  //             return testWidget;
  //           },
  //         ),
  //       ),
  //     );
  //     final BuildContext context = tester.element(find.byWidget(testWidget));
  //     ConnectToDevice Connect = ConnectToDevice();

  //     Connect.buildCurrentStatePage(
  //         ChargePointStateENUM.CHARGE_POINT_IDLE, context, device, services);

  //     await tester.pumpAndSettle();

  //     expect(find.byType(DropdownButtonPayment), findsOneWidget);
  //   });
  // });
}
