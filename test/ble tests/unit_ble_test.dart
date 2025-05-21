import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:mockito/annotations.dart';

import 'package:ble_app/ble.dart';


@GenerateMocks([
  FlutterBluePlus,
  BluetoothDevice,
  ScanResult,
  BluetoothService,
  BluetoothCharacteristic,
])
void main() {
  group('Test ChargeSettings Class', () {
    test(
        "Charge Settings Construction should set values to default when object is created",
        () {
      ChargeSettings settings = ChargeSettings();

      expect(settings.maxTime, 60.00);
      expect(settings.maxCost, 100.00);

      expect(settings.settingsChoice, radioListItems[0]);
      expect(settings.currentSelectedValue, 0);
      expect(settings.currentSliderValueTime, 20);
      expect(settings.currentSliderValueCost, 60);
      expect(settings.currentSliderValuePercent, 30);
      expect(settings.isSelectedTime, true);
      expect(settings.isSelectedCost, false);
      expect(settings.isSelectedPerc, false);

      expect(settings.dropdownValue, null);
      expect(settings.datetime, "");

      expect(settings.chargeSessionStarted, false);
      expect(settings.maxCapacity, 100.0);
      expect(settings.currentCharge, 0.0);
      expect(settings.chargeSpeed, 15);
      expect(settings.chargePrice, 0.48);
    });

    test(
        'Change Selection function should set selected choice to Max Time and that time is selected when those variables are passed',
        () {
      ChargeSettings settings = ChargeSettings();

      expect(settings.settingsChoice, radioListItems[0]);
      expect(settings.isSelectedTime, true);
      expect(settings.isSelectedCost, false);
      expect(settings.isSelectedPerc, false);

      settings.changeSelection("Max Time", true, false, false);

      expect(settings.settingsChoice, "Max Time");
      expect(settings.isSelectedTime, true);
      expect(settings.isSelectedCost, false);
      expect(settings.isSelectedPerc, false);
    });

    test(
        'Change Selection function should set selected choice to Max Cost and that time is selected when those variables are passed',
        () {
      ChargeSettings settings = ChargeSettings();

      expect(settings.settingsChoice, radioListItems[0]);
      expect(settings.isSelectedTime, true);
      expect(settings.isSelectedCost, false);
      expect(settings.isSelectedPerc, false);

      settings.changeSelection("Max Cost", false, true, false);

      expect(settings.settingsChoice, "Max Cost");
      expect(settings.isSelectedTime, false);
      expect(settings.isSelectedCost, true);
      expect(settings.isSelectedPerc, false);
    });

    test(
        'Change Selection function should set selected choice to Max Perc and that time is selected when those variables are passed',
        () {
      ChargeSettings settings = ChargeSettings();

      expect(settings.settingsChoice, radioListItems[0]);
      expect(settings.isSelectedTime, true);
      expect(settings.isSelectedCost, false);
      expect(settings.isSelectedPerc, false);

      settings.changeSelection("Max %", false, false, true);

      expect(settings.settingsChoice, "Max %");
      expect(settings.isSelectedTime, false);
      expect(settings.isSelectedCost, false);
      expect(settings.isSelectedPerc, true);
    });
    test(
        'Reset function should reset settings to default values when function is called',
        () {
      ChargeSettings settings = ChargeSettings();

      expect(settings.currentCharge, 0.0);
      expect(settings.settingsChoice, radioListItems[0]);
      expect(settings.isSelectedTime, true);
      expect(settings.isSelectedCost, false);
      expect(settings.isSelectedPerc, false);
      expect(settings.stopwatch.isRunning, false);
      expect(settings.stopwatch.elapsedMilliseconds, 0);

      settings.changeSelection("Max Cost", false, true, false);
      settings.currentCharge = 50.0;
      settings.stopwatch.start();

      expect(settings.currentCharge, 50.0);
      expect(settings.settingsChoice, "Max Cost");
      expect(settings.isSelectedTime, false);
      expect(settings.isSelectedCost, true);
      expect(settings.isSelectedPerc, false);
      expect(settings.stopwatch.isRunning, true);

      settings.reset();

      expect(settings.currentCharge, 0.0);
      expect(settings.settingsChoice, radioListItems[0]);
      expect(settings.isSelectedTime, true);
      expect(settings.isSelectedCost, false);
      expect(settings.isSelectedPerc, false);
      expect(settings.stopwatch.isRunning, false);
      expect(settings.stopwatch.elapsedMilliseconds, 0);
    });

    test(
        'Set selected value function should set the selected value when called',
        () {
      ChargeSettings settings = ChargeSettings();

      expect(settings.currentSelectedValue, 0);
      settings.setSelectedValue(10);
      expect(settings.currentSelectedValue, 10);
    });
    test(
        'Start Session function should set the chargeSessionValue flag to true when called',
        () {
      ChargeSettings settings = ChargeSettings();

      expect(settings.chargeSessionStarted, false);
      settings.startSession();
      expect(settings.chargeSessionStarted, true);
    });

    test(
        'End Session function should set the chargeSessionValue flag to false when called',
        () {
      ChargeSettings settings = ChargeSettings();

      expect(settings.chargeSessionStarted, false);
      settings.startSession();
      expect(settings.chargeSessionStarted, true);
      settings.endSession();
      expect(settings.chargeSessionStarted, false);
    });
  });
  group('Test Remaining Time Calculation and Selection', () {
    ChargeSettings settings = ChargeSettings();
    String dateTime = "";
    String testBTAddrs = "12:23:34:45:56:57";
    List<BluetoothService> services = [];
    BluetoothDevice device = BluetoothDevice.fromId(testBTAddrs);
    test(
        'Set Remaining Time should choose used Time time when user picked Time with 20 min',
        () {
      String settingChoice = "Max Time";
      double selectedValue = 20.00;

      settings.setSelectedValue(selectedValue);
      settings.setSettingsChoice(settingChoice);

      SendChargeSettingsData charger =
          SendChargeSettingsData(services: services, device: device);

      charger.setRemainingTime(settings);

      expect(settings.totalTime, 1200.0);
    });
    test(
        'Set Remaining Time should choose used Cost time when user picked Cost with \$2 ',
        () {
      String settingChoice = "Max Cost";
      double selectedValue = 2.00;

      settings.setSelectedValue(selectedValue);
      settings.setSettingsChoice(settingChoice);

      SendChargeSettingsData charger =
          SendChargeSettingsData(services: services, device: device);

      charger.setRemainingTime(settings);

      expect(settings.totalTime, 15000.0);
    });
    test(
        'Set Remaining Time should choose used Calc Percent time when user picked Charge % with 20 %',
        () {
      String settingChoice = "Charge %";
      double selectedValue = 20.00;

      settings.setSelectedValue(selectedValue);
      settings.setSettingsChoice(settingChoice);

      SendChargeSettingsData charger =
          SendChargeSettingsData(services: services, device: device);

      charger.setRemainingTime(settings);

      expect(settings.totalTime, 4800.0);
    });

    test(
        'Set Remaining Time should choose used Percent time when user picked Time with 450 min',
        () {
      String settingChoice = "Max Time";
      double selectedValue = 450.00;

      settings.setSelectedValue(selectedValue);
      settings.setSettingsChoice(settingChoice);

      SendChargeSettingsData charger =
          SendChargeSettingsData(services: services, device: device);

      charger.setRemainingTime(settings);

      expect(settings.totalTime, 24000.0);
    });
    test(
        'Set Remaining Time should choose used Percent time when user picked Cost with \$250 ',
        () {
      String settingChoice = "Max Cost";
      double selectedValue = 250.00;

      settings.setSelectedValue(selectedValue);
      settings.setSettingsChoice(settingChoice);

      SendChargeSettingsData charger =
          SendChargeSettingsData(services: services, device: device);

      charger.setRemainingTime(settings);

      expect(settings.totalTime, 24000.0);
    });
  });
  group("Test Set Current Charge Caculation", () {
    String settingChoice = "Max Time";
    double selectedValue = 5.00;
    String dateTime = "";
    String testBTAddrs = "12:23:34:45:56:57";
    List<BluetoothService> services = [];
    BluetoothDevice device = BluetoothDevice.fromId(testBTAddrs);
    testWidgets(
        "Set Current Time should set current charge to 0.42 rounded when starting at 0 charge after 1 sec",
        (WidgetTester tester) async {
      ChargeSettings settings = ChargeSettings();
      settings.chargeSessionStarted = true;
      ChargingPage session = ChargingPage(
        services: services,
        device: device,
        dateTime: dateTime,
        settingChoice: settingChoice,
        selectedValue: selectedValue,
      );

      expect(settings.currentCharge, 0.0);
      settings.stopwatch.start();
      while (settings.stopwatch.elapsedMilliseconds != 1000) {}
      settings.stopwatch.stop();
      expect(settings.stopwatch.elapsedMilliseconds, 1000);
      session.setCurrentCharge(settings);
      expect(session.prevTime, 1000);
      expect(settings.currentCharge.toStringAsFixed(2), "4.17");
    });

    testWidgets(
        "Set Current Time should set current charge to max capcity 1 when starting at 0 charge after 2.5 sec",
        (WidgetTester tester) async {
      ChargeSettings settings = ChargeSettings();
      settings.chargeSessionStarted = true;
      settings.maxCapacity = 1.0;

      ChargingPage session = ChargingPage(
        services: services,
        device: device,
        dateTime: dateTime,
        settingChoice: settingChoice,
        selectedValue: selectedValue,
      );

      expect(settings.currentCharge, 0.0);
      settings.stopwatch.start();
      while (settings.stopwatch.elapsedMilliseconds != 2500) {}
      settings.stopwatch.stop();
      expect(settings.stopwatch.elapsedMilliseconds, 2500);
      session.setCurrentCharge(settings);
      expect(session.prevTime, 2500);
      expect(settings.currentCharge.toStringAsFixed(2), "1.00");
    });
  });
  
  /*
  group('Built Settings messages to send charger (board)', () {
    test(
        'Build Charge Setting Message should build message with Max time and value when Max time is selected',
        () {
      String testBTAddrs = "12:23:34:45:56:57";
      List<BluetoothService> services = [];
      BluetoothDevice device = BluetoothDevice.fromId(testBTAddrs);
      var sendData = SendChargeSettingsData(services: services, device: device);
      var chargeSetting = ChargeSettings();

      chargeSetting.currentSliderValueTime = 20;
      chargeSetting.isSelectedTime = true;
      chargeSetting.isSelectedCost = false;
      chargeSetting.isSelectedPerc = false;
      chargeSetting.settingsChoice = "Max Time";

      String message = sendData.buildSettingsMessage(chargeSetting);
      expect(message, "\$5\nMax Time20#");
    });
    test(
        'Build Charge Setting Message should build message with Max cost and value when Max cost is selected',
        () {
      String testBTAddrs = "12:23:34:45:56:57";
      List<BluetoothService> services = [];
      BluetoothDevice device = BluetoothDevice.fromId(testBTAddrs);
      var sendData = SendChargeSettingsData(services: services, device: device);
      var chargeSetting = ChargeSettings();

      chargeSetting.currentSliderValueCost = 60.00;
      chargeSetting.isSelectedTime = false;
      chargeSetting.isSelectedCost = true;
      chargeSetting.isSelectedPerc = false;
      chargeSetting.settingsChoice = "Max Cost";

      var message = sendData.buildSettingsMessage(chargeSetting);
      expect(message, "\$5\rMax Cost60.00#");
    });
    test(
        'Build Charge Setting Message should build message with Charge % and value when Charge % is selected',
        () {
      String testBTAddrs = "12:23:34:45:56:57";
      List<BluetoothService> services = [];
      BluetoothDevice device = BluetoothDevice.fromId(testBTAddrs);
      var sendData = SendChargeSettingsData(services: services, device: device);
      var chargeSetting = ChargeSettings();

      chargeSetting.currentSliderValuePercent = 60.00;
      chargeSetting.isSelectedTime = false;
      chargeSetting.isSelectedCost = false;
      chargeSetting.isSelectedPerc = true;
      chargeSetting.settingsChoice = "Charge %";

      var message = sendData.buildSettingsMessage(chargeSetting);
      expect(message, "\$5\nCharge %60#");
    });
  });
  group("Charge Settings Messages", () {
    BluetoothCharacteristic characteristic = MockBluetoothCharacteristic();
    String testBTAddrs = "12:23:34:45:56:57";
    List<BluetoothService> services = [];
    BluetoothDevice device = BluetoothDevice.fromId(testBTAddrs);
    var chargeSetting = ChargeSettings();
    String message = "\$5\nMax Time20#";
    chargeSetting.currentSliderValueTime = 20;
    chargeSetting.isSelectedTime = true;
    chargeSetting.isSelectedCost = false;
    chargeSetting.isSelectedPerc = false;
    chargeSetting.settingsChoice = "Max Time";

    setUp(() => reset(characteristic));
    test(
        "Send Charge Settings message should send built message with Max time and value when Max time is selected",
        () async {
      SendChargeSettingsData charger =
          SendChargeSettingsData(services: services, device: device);

      when(characteristic.write(utf8.encode(message), withoutResponse: false))
          .thenAnswer((realInvocation) => Future.value(null));

      bool state = await charger.writeChargeSettingsMessage(
          characteristic, chargeSetting);
      expect(state, true);
    });

    test(
        "Send Charge Settings message should fail to send built message with Max time and value when write fails",
        () async {
      SendChargeSettingsData charger =
          SendChargeSettingsData(services: services, device: device);

      when(characteristic.write(utf8.encode(message), withoutResponse: false))
          .thenAnswer((realInvocation) =>
              throw Exception('Failed to write the characteristic'));

      bool state = await charger.writeChargeSettingsMessage(
          characteristic, chargeSetting);
      expect(state, false);
    });
  });

  group("Start Charge Messages", () {
    BluetoothCharacteristic characteristic = MockBluetoothCharacteristic();
    String message = '\$3\x011#';
    String testBTAddrs = "12:23:34:45:56:57";
    List<BluetoothService> services = [];
    BluetoothDevice device = BluetoothDevice.fromId(testBTAddrs);

    test(
        "Send Start Charge message should send start command to board and pass when write message is sent after start charge slider button activated",
        () async {
      SendChargeSettingsData charger =
          SendChargeSettingsData(services: services, device: device);

      when(characteristic.write(utf8.encode(message), withoutResponse: false))
          .thenAnswer((realInvocation) => Future.value(null));

      bool state = await charger.writeStartChargeMessage(characteristic);
      expect(state, true);
    });

    test(
        "Send Start Charge message should send start command to board and fail when write message returns an error",
        () async {
      SendChargeSettingsData charger =
          SendChargeSettingsData(services: services, device: device);

      when(characteristic.write(utf8.encode(message), withoutResponse: false))
          .thenAnswer((realInvocation) =>
              throw Exception('Failed to write the characteristic'));

      bool state = await charger.writeStartChargeMessage(characteristic);
      expect(state, false);
    });
  });
  group("Remaining Time Messages", () {
    BluetoothCharacteristic characteristic = MockBluetoothCharacteristic();
    String message = '\$5\x071200000#';
    String dateTime = "";
    String testBTAddrs = "12:23:34:45:56:57";
    List<BluetoothService> services = [];
    BluetoothDevice device = BluetoothDevice.fromId(testBTAddrs);
    String settingChoice = "Max Time";
    double selectedValue = 20.00;

    test(
        "Send Remaining Time message should send total reaming time to board and pass when total time is calculated and write message succeeds",
        () async {
      ChargingPage session = ChargingPage(
          services: services,
          device: device,
          dateTime: dateTime,
          settingChoice: settingChoice,
          selectedValue: selectedValue);

      session.totalTime = 1200000;

      expect(session.totalTime, 1200000);
      reset(characteristic);
      when(characteristic.write(utf8.encode(message), withoutResponse: false))
          .thenAnswer((realInvocation) => Future.value(null));

      bool state = await session.writeRemainingTimeMessage(characteristic);
      expect(session.message, message);
      expect(state, true);
    });

    test(
        "Send Remaining Time message should send total reaming time to board and fail when total time is calculated and write message fails",
        () async {
      ChargingPage session = ChargingPage(
          services: services,
          device: device,
          dateTime: dateTime,
          settingChoice: settingChoice,
          selectedValue: selectedValue);

      session.totalTime = 1200000;

      expect(session.totalTime, 1200000);
      reset(characteristic);
      when(characteristic.write(utf8.encode(message), withoutResponse: false))
          .thenAnswer((realInvocation) =>
              throw Exception('Failed to write the characteristic'));

      bool state = await session.writeRemainingTimeMessage(characteristic);
      expect(state, false);
    });
  });
  
  group('Read Total Charge Messages', () {
    BluetoothCharacteristic characteristic = MockBluetoothCharacteristic();
    String dateTime = "";
    String testBTAddrs = "12:23:34:45:56:57";
    List<BluetoothService> services = [];
    BluetoothDevice device = BluetoothDevice.fromId(testBTAddrs);
    String settingChoice = "Max Time";
    double selectedValue = 20.00;

    test(
        "Read Total Charge message should set total charge variable when message is of type 5 and total charge is 50.00",
        () async {
      ChargingPage session = ChargingPage(
          services: services,
          device: device,
          dateTime: dateTime,
          settingChoice: settingChoice,
          selectedValue: selectedValue);

      String message = '\$5\x0550.00#';
      List<int> encodedMessage = utf8.encode(message);

      reset(characteristic);
      when(characteristic.read()).thenAnswer((realInvocation) async {
        return encodedMessage;
      });

      expect(session.totalCharge, 0.00);
      bool state = await session.readTotalChargeMessage(characteristic);
      // expect(charger.decodedMessage, message);
      expect(session.totalCharge, 50.00);

      expect(state, true);
    });

    test(
        "Read Total Charge message should set total charge variable when message is of type 5 and total charge is 120.25",
        () async {
      ChargingPage session = ChargingPage(
          services: services,
          device: device,
          dateTime: dateTime,
          settingChoice: settingChoice,
          selectedValue: selectedValue);

      String message = '\$5\x06120.25#';
      List<int> encodedMessage = utf8.encode(message);

      reset(characteristic);
      when(characteristic.read()).thenAnswer((realInvocation) async {
        return encodedMessage;
      });

      expect(session.totalCharge, 0.00);
      bool state = await session.readTotalChargeMessage(characteristic);
      expect(session.totalCharge, 120.25);

      // expect(charger.decodedMessage, message);
      expect(state, true);
    });

    test(
        "Read Total Charge message should fail to set charge speed variable when message is not type 5",
        () async {
      ChargingPage session = ChargingPage(
          services: services,
          device: device,
          dateTime: dateTime,
          settingChoice: settingChoice,
          selectedValue: selectedValue);

      String message = '\$3\x011#';
      List<int> encodedMessage = utf8.encode(message);

      reset(characteristic);
      when(characteristic.read()).thenAnswer((realInvocation) async {
        return encodedMessage;
      });

      bool state = await session.readTotalChargeMessage(characteristic);
      // expect(charger.decodedMessage, message);
      expect(state, false);
    });
  });
*/
}
