import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:ble_app/main.dart';


@GenerateMocks([
  FlutterBluePlus,
  BluetoothDevice,
  ScanResult,
  BluetoothService,
  BluetoothCharacteristic,
])
void main() {
  group('Parse QR code scanner result', () {
    test(
        'ScanSetting should Save BT address when image is captured and data is converted to String',
        () {
      var settings = ScanSettings();
      List<String> data = ["76:36:32:12:34", "1234", "Charger", "A"];
      settings.saveInfo(data);

      expect(settings.btAddress, "76:36:32:12:34");
    });

    test(
        'ScanSetting should Save password when image is captured and data is converted to String',
        () {
      var settings = ScanSettings();
      List<String> data = ["76:36:32:12:34", "1234", "Charger", "A"];

      settings.saveInfo(data);

      expect(settings.pwd, "1234");
    });

    test(
        'ScanSetting should Save name of charger when image is captured and data is converted to String',
        () {
      var settings = ScanSettings();
      List<String> data = ["76:36:32:12:34", "1234", "Charger", "A"];
      expect(settings.chargerName, "Unknown");
      settings.saveInfo(data);

      expect(settings.chargerName, "Charger A");
    });
    test(
        'ScanSetting should Save name of charger as defualt value when not included in QR Code',
        () {
      var settings = ScanSettings();
      List<String> data = ["76:36:32:12:34", "1234"];
      expect(settings.chargerName, "Unknown");
      settings.saveInfo(data);

      expect(settings.chargerName, "Charger");
    });
  });
}
