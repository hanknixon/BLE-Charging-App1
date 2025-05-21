
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

/// Variables that keep track of the state of the charging session
/// Keeps track of variables that are used and changed by multiple classes
///
/// @class
/// @classdesc Containers setters and getters to change the values of charge 
/// session settings to then be displayed on different pages
class ChargeSettings extends ChangeNotifier {
  bool intendedBLEDisconnect = true;
  bool showReconnect = false;

  double maxTime = 60.00;
  double maxCost = 100.00;

  String? _settingsChoice;//radioListItems[0];
  double _currentSelectedValue = 0;
  double _currentSliderValueTime = 20;
  double _currentSliderValueCost = 60;
  double _currentSliderValuePercent = 30;
  bool isSelectedTime = false;
  bool isSelectedCost = false;
  bool isSelectedPerc = false;

  String? dropdownValue;

  String datetime = "";

  bool chargeSessionStarted = false;
  double maxCapacity = 50.0; // kW
  double startingCharge = 5.0;
  double currentCharge = 0.0; //kW
  int chargeSpeed = 25; //kWh
  double chargePrice = 0.48; //$

  final stopwatch = Stopwatch();

  double totalTime = 0; //MilliSeconds
  bool timeSet = false;

  late BluetoothDevice device;
  List<BluetoothService> services = [];

  String? get settingsChoice => _settingsChoice;
  double get currentSelectedValue => _currentSelectedValue;
  double get currentSliderValueTime => _currentSliderValueTime;
  double get currentSliderValueCost => _currentSliderValueCost;
  double get currentSliderValuePercent => _currentSliderValuePercent;

  /// Setter function to set what settings was selected from the radio button list
  ///
  /// @param {String} value - name of the setting selected
  void setSettingsChoice(String? value) {
    _settingsChoice = value;
    notifyListeners();
  }

  /// Setter function to set the value of the time slider
  ///
  /// @param {double} value - value of the time the slidder is set to
  set currentSliderValueTime(double value) {
    _currentSliderValueTime = value;
    notifyListeners();
  }

  /// Setter function to set the value of the cost slider
  ///
  /// @param {double} value - value of the cost the slidder is set to
  set currentSliderValueCost(double value) {
    _currentSliderValueCost = value;
    notifyListeners();
  }

  /// Setter function to set the value of the charge percent slider
  ///
  /// @param {double} value - value of the charge percent the slidder is set to
  set currentSliderValuePercent(double value) {
    _currentSliderValuePercent = value;
    notifyListeners();
  }

  /// Setter function to clear and return to default values of the ChargeSettings
  void reset() {
    _settingsChoice = null;//radioListItems[0];
    isSelectedTime = false;
    isSelectedCost = false;
    isSelectedPerc = false;
    totalTime = 0.0;
    timeSet = false;

    stopwatch.stop();
    stopwatch.reset();

    chargeSessionStarted = false;

    _currentSliderValueTime = 20;
    _currentSliderValueCost = 60;
    _currentSliderValuePercent = 30;

    dropdownValue = null;
    datetime = "";

    maxCapacity = 50.0;
    currentCharge = 0.0;
    chargeSpeed = 25;
    chargePrice = 0.48;
  }

  /// Setter function to set what setting is currently selected
  ///
  /// @param {String} value - name of the setting selected
  /// @param {bool} selectedTime - flag if time setting is selected
  /// @param {bool} selectedCost - flag if cost setting is selected
  /// @param {bool} selectedPerc - flag if charge percent setting is selected
  void changeSelection(
      String? value, bool selectedTime, bool selectedCost, bool selectedPerc) {
    _settingsChoice = value;
    isSelectedTime = selectedTime;
    isSelectedCost = selectedCost;
    isSelectedPerc = selectedPerc;

    notifyListeners();
  }

  /// Setter function to set the value of the currenlty selected setting
  ///
  /// @param {double} value - value of the selected setting
  void setSelectedValue(double value) {
    _currentSelectedValue = value;

    notifyListeners();
  }

  /// Setter function to set the flag that a charge session has started
  void startSession() {
    chargeSessionStarted = true;
    notifyListeners();
  }

  /// Setter function to set the flag that a charge session has ended
  void endSession() {
    chargeSessionStarted = false;
    notifyListeners();
  }

  /// Setter function to convert from a DateTime object to a string
  /// @param {DateTime} tsdate - time of when the charge session started
  void setDateTime(DateTime tsdate) {
    if (tsdate.minute >= 10) {
      datetime =
          "${tsdate.hour}:${tsdate.minute} ${tsdate.year}/${tsdate.month}/${tsdate.day}";
    } else {
      datetime =
          "${tsdate.hour}:0${tsdate.minute} ${tsdate.year}/${tsdate.month}/${tsdate.day}";
    }
  }
}

