import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:ble_app/blemessages.dart';
import 'package:ble_app/ble.dart';
import 'unit_ble_messages_test.mocks.dart';

@GenerateMocks([
  FlutterBluePlus,
  BluetoothDevice,
  ScanResult,
  BluetoothService,
  BluetoothCharacteristic,
])
void main() {
  group('Send Initialization Messages', () {
    BluetoothCharacteristic characteristic = MockBluetoothCharacteristic();
    List<int> message = [24, 1, 2, 12, 34, 0, 46, 23];

    setUp(() {
      reset(characteristic);
    });
    test(
        'Send Initialization Message to board and pass when function called after device is connected',
        () async {
      when(characteristic.write(message, withoutResponse: false))
          .thenAnswer((realInvocation) => Future.value(null));

      bool state = await writeInitializationMessage(characteristic);

      expect(state, true);
    });

    test('Send Initialization Message should Fail when write message fails',
        () async {
      when(characteristic.write(message, withoutResponse: false)).thenAnswer(
          (realInvocation) =>
              throw Exception('Failed to write the characteristic'));

      bool state = await writeInitializationMessage(characteristic);

      expect(state, false);
    });
  });
  group('Send Authentication Messages', () {
    BluetoothCharacteristic characteristic = MockBluetoothCharacteristic();
    List<int> message = [24, 2, 8, 12, 34, 10, 3, 0, 0, 90, 90, 2, 39, 23];
    ChargeSettings settings = ChargeSettings();

    setUp(() {
      reset(characteristic);
    });
    test(
        'Send Authentication Message send pin/password to board and pass when function called after device is connected',
        () async {
      when(characteristic.write(message, withoutResponse: false))
          .thenAnswer((realInvocation) => Future.value(null));

      bool state = await writeAuthenticationMessage(characteristic, settings);

      expect(state, true);
    });

    test(
        'Send Authentication Message should Fail when password or pin write message fails',
        () async {
      when(characteristic.write(message, withoutResponse: false)).thenAnswer(
          (realInvocation) =>
              throw Exception('Failed to write the characteristic'));

      bool state = await writeAuthenticationMessage(characteristic, settings);

      expect(state, false);
    });
  });
  group('Send Charging Messages', () {
    BluetoothCharacteristic characteristic = MockBluetoothCharacteristic();
    List<int> message = [24, 3, 7, 12, 34, 1, 99, 88, 12, 34, 2, 80, 23];

    setUp(() {
      reset(characteristic);
    });
    test(
        'Send Charging Message to board and pass when function called after device is connected',
        () async {
      when(characteristic.write(message, withoutResponse: false))
          .thenAnswer((realInvocation) => Future.value(null));

      bool state = await writeChargingMessage(characteristic);

      expect(state, true);
    });

    test('Send Charging Message should Fail when write message fails',
        () async {
      when(characteristic.write(message, withoutResponse: false)).thenAnswer(
          (realInvocation) =>
              throw Exception('Failed to write the characteristic'));

      bool state = await writeChargingMessage(characteristic);

      expect(state, false);
    });
  });
  group("EndofCharging Messages", () {
    BluetoothCharacteristic characteristic = MockBluetoothCharacteristic();
    List<int> message = [24, 4, 3, 12, 34, 2, 0, 48, 23];

    setUp(() {
      reset(characteristic);
    });

    test(
        "Send EndofCharging message should send end command to board and pass when write message is sent after charge end conditions are met",
        () async {
      when(characteristic.write(message, withoutResponse: false))
          .thenAnswer((realInvocation) => Future.value(null));

      bool state = await writeEndoFChargingMessage(characteristic);
      expect(state, true);
    });

    test(
        "EndofCharging message should send end command to board and fail when write message returns an error",
        () async {
      when(characteristic.write(message, withoutResponse: false)).thenAnswer(
          (realInvocation) =>
              throw Exception('Failed to write the characteristic'));

      bool state = await writeEndoFChargingMessage(characteristic);
      expect(state, false);
    });
  });
  group("Diagnostic / Power Failure Messages", () {
    BluetoothCharacteristic characteristic = MockBluetoothCharacteristic();
    List<int> message = [24, 5, 4, 99, 88, 12, 34, 2, 33, 23];

    setUp(() {
      reset(characteristic);
    });

    test(
        "Send Diagnostic / Power Failure message should send command to board and pass when write message is sent",
        () async {
      when(characteristic.write(message, withoutResponse: false))
          .thenAnswer((realInvocation) => Future.value(null));

      bool state = await writeDiagnosticMessage(characteristic);
      expect(state, true);
    });

    test(
        "Diagnostic / Power Failure message should fail when write message returns an error",
        () async {
      when(characteristic.write(message, withoutResponse: false)).thenAnswer(
          (realInvocation) =>
              throw Exception('Failed to write the characteristic'));

      bool state = await writeDiagnosticMessage(characteristic);
      expect(state, false);
    });
  });
  group('Send Time Synce Messages', () {
    BluetoothCharacteristic characteristic = MockBluetoothCharacteristic();
    List<int> message = [24, 7, 9, 1, 99, 88, 17, 4, 23, 19, 0, 0, 2, 51, 23];
    DateTime tsdate = DateTime.parse("2023-04-17 19:00");

    setUp(() {
      reset(characteristic);
    });

    test(
        'Send Time Synce Message should Pass when function is called and write message succeds after authentication',
        () async {
      when(characteristic.write(message, withoutResponse: false))
          .thenAnswer((realInvocation) => Future.value(null));

      bool state = await writeTimeSyncMessage(characteristic, tsdate);
      // expect(connectDevice.message, message);
      expect(state, true);
    });
    test('Send Time Synce Message should Fail when write message fails',
        () async {
      when(characteristic.write(message, withoutResponse: false)).thenAnswer(
          (realInvocation) =>
              throw Exception('Failed to write the characteristic'));

      bool state = await writeTimeSyncMessage(characteristic, tsdate);

      expect(state, false);
    });
  });
  group("OperatorReg Messages", () {
    BluetoothCharacteristic characteristic = MockBluetoothCharacteristic();
    List<int> message = [24, 8, 3, 99, 88, 1, 1, 88, 23];

    setUp(() {
      reset(characteristic);
    });

    test(
        "OperatorReg message should send command to board and pass when write message is sent",
        () async {
      when(characteristic.write(message, withoutResponse: false))
          .thenAnswer((realInvocation) => Future.value(null));

      bool state = await writeOperaotrRegMessage(characteristic);
      expect(state, true);
    });

    test("OperatorReg message should fail when write message returns an error",
        () async {
      when(characteristic.write(message, withoutResponse: false)).thenAnswer(
          (realInvocation) =>
              throw Exception('Failed to write the characteristic'));

      bool state = await writeOperaotrRegMessage(characteristic);
      expect(state, false);
    });
  });
  group("EV Owner Reg Messages", () {
    BluetoothCharacteristic characteristic = MockBluetoothCharacteristic();
    List<int> message = [24, 10, 3, 9, 9, 1, 0, 19, 23];

    setUp(() {
      reset(characteristic);
    });

    test(
        "EV Owner Reg message should send command to board and pass when write message is sent",
        () async {
      when(characteristic.write(message, withoutResponse: false))
          .thenAnswer((realInvocation) => Future.value(null));

      bool state = await writeEVOwnerRegRegMessage(characteristic);
      expect(state, true);
    });

    test("EV Owner Reg message should fail when write message returns an error",
        () async {
      when(characteristic.write(message, withoutResponse: false)).thenAnswer(
          (realInvocation) =>
              throw Exception('Failed to write the characteristic'));

      bool state = await writeEVOwnerRegRegMessage(characteristic);
      expect(state, false);
    });
  });
  group("Schedule Charge Request Messages", () {
    BluetoothCharacteristic characteristic = MockBluetoothCharacteristic();
    List<int> message = [
      24,
      11,
      14,
      99,
      88,
      17,
      4,
      23,
      19,
      0,
      0,
      17,
      4,
      23,
      19,
      30,
      0,
      3,
      43,
      23
    ];
    DateTime tsdate = DateTime.parse("2023-04-17 19:00");

    setUp(() {
      reset(characteristic);
    });

    test(
        "Schedule Charge Request message should send command to board and pass when write message is sent",
        () async {
      when(characteristic.write(message, withoutResponse: false))
          .thenAnswer((realInvocation) => Future.value(null));

      bool state =
          await writeScheduleChargeRequestMessage(characteristic, tsdate, 30);
      expect(state, true);
    });

    test(
        "Schedule Charge Request message should fail when write message returns an error",
        () async {
      when(characteristic.write(message, withoutResponse: false)).thenAnswer(
          (realInvocation) =>
              throw Exception('Failed to write the characteristic'));

      bool state =
          await writeScheduleChargeRequestMessage(characteristic, tsdate, 30);
      expect(state, false);
    });
  });
}
