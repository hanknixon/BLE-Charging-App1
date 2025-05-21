import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:ble_app/main.dart';
import 'package:ble_app/ble.dart';

void main() {
  group('Dropdown Button Payment Method Select', () {
    testWidgets("Dropdown bar should change dropdownValue from empty to Amex",
        (WidgetTester tester) async {
      Widget testWidget = MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(home: DropdownButtonPayment()));

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
      ChargeSettings settings =
          Provider.of<ChargeSettings>(context, listen: false);

      expect(
          find.descendant(
              of: find.byType(Consumer<ChargeSettings>),
              matching: find.byType(DropdownButton<String>)),
          findsOneWidget);

      await tester.tap(find.descendant(
          of: find.byType(Consumer<ChargeSettings>),
          matching: find.byType(DropdownButton<String>)));
      await tester.pumpAndSettle();

      expect(find.text('Amex').last, findsOneWidget);

      await tester.tap(find.text('Amex', skipOffstage: false).last,
          warnIfMissed: true);
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(settings.dropdownValue, "Amex");
    });

    testWidgets("Dropdown bar should change dropdownValue from empty to Paypal",
        (WidgetTester tester) async {
      Widget testWidget = MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(home: DropdownButtonPayment()));

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
      ChargeSettings settings =
          Provider.of<ChargeSettings>(context, listen: false);

      expect(
          find.descendant(
              of: find.byType(Consumer<ChargeSettings>),
              matching: find.byType(DropdownButton<String>)),
          findsOneWidget);

      await tester.tap(find.descendant(
        of: find.byType(Consumer<ChargeSettings>),
        matching: find.byType(DropdownButton<String>),
      ));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('Paypal').last, findsOneWidget);

      await tester.tap(find.text('Paypal', skipOffstage: false).last,
          warnIfMissed: true);
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(settings.dropdownValue, "Paypal");
    });

    testWidgets(
        "Dropdown bar should change dropdownValue from empty to MasterCard",
        (WidgetTester tester) async {
      Widget testWidget = MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(home: DropdownButtonPayment()));

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
      ChargeSettings settings =
          Provider.of<ChargeSettings>(context, listen: false);

      expect(
          find.descendant(
              of: find.byType(Consumer<ChargeSettings>),
              matching: find.byType(DropdownButton<String>)),
          findsOneWidget);

      await tester.tap(find.descendant(
        of: find.byType(Consumer<ChargeSettings>),
        matching: find.byType(DropdownButton<String>),
      ));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('MasterCard').last, findsOneWidget);

      await tester.tap(find.text('MasterCard', skipOffstage: false).last,
          warnIfMissed: true);
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(settings.dropdownValue, "MasterCard");
    });

    testWidgets("Dropdown bar should change dropdownValue from empty to Visa",
        (WidgetTester tester) async {
      Widget testWidget = MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(home: DropdownButtonPayment()));

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
      ChargeSettings settings =
          Provider.of<ChargeSettings>(context, listen: false);

      expect(
          find.descendant(
              of: find.byType(Consumer<ChargeSettings>),
              matching: find.byType(DropdownButton<String>)),
          findsOneWidget);

      await tester.tap(find.descendant(
        of: find.byType(Consumer<ChargeSettings>),
        matching: find.byType(DropdownButton<String>),
      ));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('Visa').last, findsOneWidget);

      await tester.tap(find.text('Visa', skipOffstage: false).last,
          warnIfMissed: true);
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      expect(settings.dropdownValue, "Visa");
    });
  });

  group('Radio Button User Setting Method Select', () {
    testWidgets('Select Time button should select that buitton when clicked',
        (WidgetTester tester) async {
      Widget testWidget = MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(home: RadioButtonChargeSetting()));

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
      ChargeSettings settings =
          Provider.of<ChargeSettings>(context, listen: false);

      expect(
          find.byWidgetPredicate(
            (widget) => widget is Radio<String> && widget.value == "Max Time",
          ),
          findsOneWidget);

      await tester.tap(find.byWidgetPredicate(
        (widget) => widget is Radio<String> && widget.value == "Max Time",
      ));
      await tester.pumpAndSettle();

      expect(settings.settingsChoice, "Max Time");
    });

    testWidgets('Select Cost button should select that buitton when clicked',
        (WidgetTester tester) async {
      Widget testWidget = MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(home: RadioButtonChargeSetting()));

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
      ChargeSettings settings =
          Provider.of<ChargeSettings>(context, listen: false);

      expect(
          find.byWidgetPredicate(
            (widget) => widget is Radio<String> && widget.value == "Max Cost",
          ),
          findsOneWidget);

      await tester.tap(find.byWidgetPredicate(
        (widget) => widget is Radio<String> && widget.value == "Max Cost",
      ));

      expect(settings.settingsChoice, "Max Cost");
    });

    testWidgets(
        'Select Charge % button should select that buitton when clicked',
        (WidgetTester tester) async {
      Widget testWidget = MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(home: RadioButtonChargeSetting()));

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
      ChargeSettings settings =
          Provider.of<ChargeSettings>(context, listen: false);

      expect(
          find.byWidgetPredicate(
            (widget) => widget is Radio<String> && widget.value == "Charge %",
          ),
          findsOneWidget);

      await tester.tap(find.byWidgetPredicate(
        (widget) => widget is Radio<String> && widget.value == "Charge %",
      ));

      expect(settings.settingsChoice, "Charge %");
    });
  });
  group('Radio Button Sliders', () {
    testWidgets("Time Slider should change value when slider is moved",
        (WidgetTester tester) async {
      Widget testWidget = MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(home: RadioButtonChargeSetting()));

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
      ChargeSettings settings =
          Provider.of<ChargeSettings>(context, listen: false);

      expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is Slider &&
                widget.value == settings.currentSliderValueTime,
          ),
          findsOneWidget);

      await tester.drag(
          find.byWidgetPredicate(
            (widget) =>
                widget is Slider &&
                widget.value == settings.currentSliderValueTime,
          ),
          Offset(20, 0));
      await tester.pumpAndSettle();

      expect(settings.currentSliderValueTime.toStringAsFixed(2), "34.76");
    });
    testWidgets("Cost Slider should change value when slider is moved",
        (WidgetTester tester) async {
      Widget testWidget = MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(home: RadioButtonChargeSetting()));

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
      ChargeSettings settings =
          Provider.of<ChargeSettings>(context, listen: false);

      expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is Slider &&
                widget.value == settings.currentSliderValueCost,
          ),
          findsOneWidget);

      await tester.drag(
          find.byWidgetPredicate(
            (widget) =>
                widget is Slider &&
                widget.value == settings.currentSliderValueCost,
          ),
          Offset(20, 0));
      await tester.pumpAndSettle();
      expect(settings.currentSliderValueCost.toStringAsFixed(2), "57.94");
    });
    testWidgets("Charge % Slider should change value when slider is moved",
        (WidgetTester tester) async {
      Widget testWidget = MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(home: RadioButtonChargeSetting()));

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
      ChargeSettings settings =
          Provider.of<ChargeSettings>(context, listen: false);

      expect(
          find.byWidgetPredicate(
            (widget) =>
                widget is Slider &&
                widget.value == settings.currentSliderValuePercent,
          ),
          findsOneWidget);

      await tester.drag(
          find.byWidgetPredicate(
            (widget) =>
                widget is Slider &&
                widget.value == settings.currentSliderValuePercent,
          ),
          Offset(20, 0));
      expect(settings.currentSliderValueCost.round(), 60);
    });
  });

  group('User Input numerical values', () {
    testWidgets(
        "Time User Input should change value when user is done inputting value",
        (WidgetTester tester) async {
      Widget testWidget = MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(home: RadioButtonChargeSetting()));

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
      ChargeSettings settings =
          Provider.of<ChargeSettings>(context, listen: false);

      expect(
          find.ancestor(
            of: find.text("Input Time"),
            matching: find.byType(TextField),
          ),
          findsOneWidget);
      await tester.pumpAndSettle();

      await tester.enterText(
          find.ancestor(
            of: find.text("Input Time"),
            matching: find.byType(TextField),
          ),
          "15");
      await tester.pumpAndSettle();
      expect(find.text("15"), findsOneWidget);
    });
    testWidgets(
        "Cost User Input should change value when user is done inputting value",
        (WidgetTester tester) async {
      Widget testWidget = MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(home: RadioButtonChargeSetting()));

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
      ChargeSettings settings =
          Provider.of<ChargeSettings>(context, listen: false);

      expect(
          find.ancestor(
            of: find.text("Input Cost"),
            matching: find.byType(TextField),
          ),
          findsOneWidget);
      await tester.pumpAndSettle();

      await tester.enterText(
          find.ancestor(
            of: find.text("Input Cost"),
            matching: find.byType(TextField),
          ),
          "15");
      await tester.pumpAndSettle();
      expect(find.text("15"), findsOneWidget);
    });
    testWidgets(
        "Charge % User Input should change value when user is done inputting value",
        (WidgetTester tester) async {
      Widget testWidget = MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(home: RadioButtonChargeSetting()));

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
      ChargeSettings settings =
          Provider.of<ChargeSettings>(context, listen: false);

      expect(
          find.ancestor(
            of: find.text("Input Percent"),
            matching: find.byType(TextField),
          ),
          findsOneWidget);
      await tester.pumpAndSettle();

      await tester.enterText(
          find.ancestor(
            of: find.text("Input Percent"),
            matching: find.byType(TextField),
          ),
          "15");
      await tester.pumpAndSettle();
      expect(find.text("15"), findsOneWidget);
    });
  });

  
}
