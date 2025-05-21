// ignore_for_file: constant_identifier_names
//import 'dart:ffi';

import 'package:ble_app/ble.dart';
import 'package:flutter/material.dart';
// import 'ble.dart';
// import 'main.dart';
import 'dart:convert';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:intl/intl.dart';
import 'package:binary/binary.dart';
import 'dart:async';


enum ChargePointStateENUM {
  CHARGE_POINT_IDLE,
  CHARGE_POINT_INITIALIZATION,
  CHARGE_POINT_AUTHORIZATION,
  CHARGE_POINT_CHARGING,
  CHARGE_POINT_END_OF_CHARGING,
  CHARGE_POINT_ERROR,
}

enum PaymentENUM {
  PAYMENT_OTHER,
  PAYMENT_CASH,
  PAYMENT_CONTRACT,
  PAYMENT_PREPAID,
}

enum RegisteredENUM {
  NOT_REGISTERED,
  REGISTERED,
}

enum ConditionENUM {
  CONDITION_UNKNOWN,
  CONDITION_OK,
  CONDITION_NOTOK,
}

enum StopStartChENUM {
  STOP_CHARGINING,
  START_CHARGING,
}

enum SessionActiveENUM {
  SESSION_NO_ACTIVE,
  SESSION_ACTIVE,
}

enum ErrorCode1ENUM {
  ERROR_CODE_1_INVAILD_OPERATOR_ID,
  ERROR_CODE_1_POWERFAIL,
  ERROR_CODE_1_INVALID_SESSION_ID,
  ERROR_CODE_1_CHECKSUM_ERROR,
  ERROR_CODE_1_LESS_MIN_CURRENT,
}

enum ErrorCode2ENUM {
  ERROR_CODE_2_MAINS_LOW,
  ERROR_CODE_2_MAINS_HIGH,
  ERROR_CODE_2_OUTPUT_CURRENT_HIGH,
  ERROR_CODE_2_EARTH_DISCONNECT,
  ERROR_CODE_2_EARTH_LEAKAGE,
  ERROR_CODE_2_NEUTRAL_EARTH_DETECT,
  ERROR_CODE_2_EMERGENCY,
  ERROR_CODE_2_TEMPERARURE_FAILURE,
}

enum PaymentMethodENUM {
  PAYMENT_METHOD_AMEX,
  PAYMENT_METHOD_VISA,
  PAYMENT_METHOD_MASTERCARD,
  PAYMENT_METHOD_PAYPAL,
}

enum ReasonforStopENUM {
  REASON_FOR_STOP_NORMAL,
  REASON_FOR_STOP_SUSPENDED_BY_CHARGER,
  REASON_FOR_STOP_SUSPENDED_BY_USER,
  REASON_FOR_STOP_LEV_CHARG_NOT_READY,
  REASON_FOR_STOP_TIMEOUT,
  REASON_FOR_STOP_POWER_FAIL,
  REASON_FOR_STOP_MAINS_LOW,
  REASON_FOR_STOP_MAINS_HI,
  REASON_FOR_STOP_OUT_CURR_HI,
  REASON_FOR_STOP_EARTH_LEAKAGE,
  REASON_FOR_STOP_EARTH_DISCONNECT,
  REASON_FOR_STOP_NUTRALEARTH,
  REASON_FOR_STOP_EMERGANCY,
  REASON_FOR_STOP_TEMPERATURE_FAIL,
}

bool endHeartbeat = false;
bool startCharging = false;
bool firstDiagnosticRecieved = false;
bool responseEndoFChargingRecieved = false;
bool responseChargingRecieved = false;
bool responseAuthenticationRecieved = false;

double currentMeterValue = 0.0;

ChargePointStateENUM currentChargerState =
    ChargePointStateENUM.CHARGE_POINT_IDLE;

// Timer heartBeat = Timer(Duration.zero, () {});
int heartBeatFreq = 1; //seconds
List<StreamSubscription> messageSubStream = [];

/// Setup timer to send diagnostic after the timer finishes or stop if flag is set
///
/// @param {BluetoothCharacteristic} characteristic - BLE characteristic of charge station to send a message
void heartBeatInit(BluetoothCharacteristic characteristic) {
  if (endHeartbeat == true) {
    debugPrint(
        "\n <<<<<<<<********>>>>>>>> Heartbeat Already Started <<<<<<<<********>>>>>>>> \n");
    return;
  }
  Timer timer = Timer.periodic(Duration(seconds: heartBeatFreq), (timer) async {
    // debugPrint("\n ******** Diagnostic ${timer.tick} ******** \n");
    if (endHeartbeat == true) {
      debugPrint("\n ******** End Diagnostic ${timer.tick} ******** \n");

      timer.cancel();
      return;
    }
    bool state5 = await writeDiagnosticMessage(characteristic);
    if (state5 == false) {
      // debugPrint(
      // "\n ***** writeDiagnosticMessage Failed ${timer.tick} ***** \n");
      // endHeartbeat = true;
      // timer.cancel();
    }
  });
}

///Prints information on devices scanned thorugh BLE
void printScanBLE() async {
  debugPrint("************************************");
  // Start scanning
  BluetoothDevice device = BluetoothDevice.fromId("34:81:F4:D0:8E:74" //,
      //name: "Test",
      );
  debugPrint('${device.platformName} found! address: ${device.id}\n');
  device.disconnect();
  await device.connect(autoConnect: false).timeout(Duration(seconds: 30),
      onTimeout: () {
    debugPrint('timeout occurred');
  });
  int i = 0;
  device.connectionState.listen((state) async {
    debugPrint("Attempting to Connect");
    if (state == BluetoothConnectionState.connected) {
      List<BluetoothService> services = await device.discoverServices();
      for (var s in services) {
        // print("Service;\t\t${s.uuid}\n");
        for (var c in s.characteristics) {
          // print("\tCharacteristic;\t${c.uuid};\t${c.properties}\n");
          try {
            await c.write(utf8.encode("${c.uuid}"));
          } on Exception catch (e) {
            debugPrint("${i++} ");
            debugPrint("$e");
          }
        }
      }
      debugPrint("DONE");
    } else {
      debugPrint("FAILED TO CONNECT");
    }
  });
}

/// Calculates a messages checksum and compares it to the checksum in the recieved messages
///
/// @param {List<int>} value - Message in a list of ints format
///
/// @param {int} dataLen - The length of the data section of the message
bool verifyCheckSum(List<int> value, int dataLen) {
  int checkSumC = 0;
  for (int i = 3; i < 3 + dataLen; i++) {
    checkSumC += value[i];
  }

  int checkSumR = value[3 + dataLen];
  checkSumR *= 100;
  checkSumR += value[3 + dataLen + 1];

  if (checkSumC != checkSumR) {
    debugPrint("\n Checksums do not match Rec: $checkSumR Calc: $checkSumC \n");
    return false;
  }

  // debugPrint("\n Checksum Rec: $checkSumR Calc: $checkSumC \n");
  return true;
}

var charSubscriptionStream;

/// Setup and listen to the data stream from the BLE characterisitics and decide on the type of messages has been recieved
///
/// @param {BluetoothCharacteristic} characteristic - Characteristics of the BLE of the Charge Station
///
/// @retuns {bool} - result of setup of the substriction stream to the charge station
Future<bool> listenMessages(BluetoothCharacteristic characteristic) async {
  debugPrint("\n listenMessages: ");
  try {
    charSubscriptionStream = characteristic.value.listen((value) {
      if (value.isNotEmpty) {
        debugPrint("\n listenMessages Packet: $value \n");
        int messageType = value[1];
        switch (messageType) {
          case 1:
            debugPrint("parseInitializationResponseMessage \n");
            parseInitializationResponseMessage(value);
            break;
          case 2:
            debugPrint("parseAuthorizationResponseMessage \n");
            parseAuthorizationResponseMessage(value);
            break;
          case 3:
            debugPrint("parseChargingResponseMessage \n");
            parseChargingResponseMessage(value);
            break;
          case 4:
            debugPrint("parseEndoFChargingResponseMessage \n");
            parseEndoFChargingResponseMessage(value);
            break;
          case 5:
            // debugPrint("parseDiagnosticResponseMessage \n");
            parseDiagnosticResponseMessage(value);
            break;
          case 7:
            debugPrint("parseTimeSyncMessage \n");
            parseTimeSyncMessage(value);
            break;
          case 8:
            debugPrint("parseOperatorRegResponseMessage \n");
            parseOperatorRegResponseMessage(value);
            break;
          case 10:
            debugPrint("parseEVOwnerRegResponseMessage \n");
            parseEVOwnerRegResponseMessage(value);
            break;
          case 11:
            debugPrint("parseScheduleChargeRequestResponseMessage \n");
            parseScheduleChargeRequestResponseMessage(value);
            break;
          default:
            // debugPrint("Message Type Not Recognized: $messageType \n");
            break;
        }
      }
    });
    if (messageSubStream.isEmpty) {
      messageSubStream.add(charSubscriptionStream);
    } else {
      messageSubStream[0].cancel();
      messageSubStream.add(charSubscriptionStream);
    }
  } on Exception catch (e) {
    debugPrint("\n listenMessages ERROR: $e\n");
    return false;
  }
  debugPrint("\n listenMessages Subscription Stream Setup Complete \n");
  return true;
}

/*
  Future<void> notifyAllServices(List<BluetoothService> services) async {
    debugPrint("\nnotifyAllServices\n");
    for (var s in services) {
      // print("Service;\t\t${s.uuid}\n");
      for (var c in s.characteristics) {
        // print("\tCharacteristic;\t${c.uuid};\t${c.properties}\n");
        try {
          await c.setNotifyValue(true);
        } on Exception catch (e) {
          // debugPrint("$e\n");
          continue;
        }
      }
    }
    debugPrint("\nnotifyAllServices Complete\n");

    return;
  }

  Future<void> listenAllServices(List<BluetoothService> services) async {
    debugPrint("\nlistenAllServices\n");
    for (var s in services) {
      // print("Service;\t\t${s.uuid}\n");
      for (var c in s.characteristics) {
        // print("\tCharacteristic;\t${c.uuid};\t${c.properties}\n");
        try {
          c.value.listen((value) {
            debugPrint("\nListen ${c.uuid} $value\n");
          });
        } on Exception catch (e) {
          // debugPrint("\n$e\n");
        }
      }
    }
    debugPrint("\nlistenAllServices Complete\n");
  }

  Future<void> readAllServices(List<BluetoothService> services) async {
    debugPrint("\nreadAllServices\n");
    List<int> value;
    for (var s in services) {
      // print("Service;\t\t${s.uuid}\n");
      for (var c in s.characteristics) {
        // print("\tCharacteristic;\t${c.uuid};\t${c.properties}\n");
        try {
          value = await c.read();
          debugPrint("\nRead ${c.uuid} $value\n");
        } on Exception catch (e) {
          // debugPrint("\n$e\n");
        }
      }
    }
    debugPrint("\nreadAllServices Complete\n");
  }
*/

int startByte = 24;
int stopByte = 23;
bool parseInitializationResponseMessage(List<int> value) {
  //String startByte = value[0].toRadixString(16);
  //String endByte = value.last.toRadixString(16);
  if (value[0] != startByte) {
    // $ start byte
    debugPrint("\n Wrong Start Byte \n");
    return false;
  }
  if (value.last != stopByte) {
    //  # end byte
    debugPrint("\n Wrong End Byte \n");
    return false;
  }

  int length = value[2];
  if (length < 4) {
    debugPrint("\n Missing Data Fields or Data Length Too Short \n");
    return false;
  }
  if (verifyCheckSum(value, length) == false) {
    return false;
  }

  int state = value[3];
  String levIDno = '';
  levIDno += value[4].toRadixString(16);
  levIDno += value[5].toRadixString(16);
  levIDno += value[6].toRadixString(16);
  levIDno += value[7].toRadixString(16);

  debugPrint(
      "\n Initialization Parsed Packet: $length, ${ChargePointStateENUM.values.elementAt(state)}, $levIDno \n");
  return true;
}

bool parseAuthorizationResponseMessage(List<int> value) {
  //String startByte = value[0].toRadixString(16);
  //String endByte = value.last.toRadixString(16);
  if (value[0] != 24) {
    // $ start byte
    debugPrint("\n Wrong Start Byte \n");
    return false;
  }
  if (value.last != 23) {
    //  # end byte
    debugPrint("\n Wrong End Byte \n");
    return false;
  }

  int length = value[2];
  if (length > 7) {
    debugPrint("\n Missing Data Fields or Data Length Too Long \n");
    return false;
  }
  if (verifyCheckSum(value, length) == false) {
    return false;
  }

  int sessionID = value[3] << 8;
  sessionID |= (0xFF & value[4]);
  int sessionStart = value[5];
  int payment = value[6];
  int chargPready = value[7];
  int state = value[8];

  responseAuthenticationRecieved = true;

  debugPrint(
      "\n Authorization Parsed Packet: $length, $sessionID, $sessionStart, ${PaymentENUM.values.elementAt(payment)}, $chargPready, ${ChargePointStateENUM.values.elementAt(state)} \n");
  return true;
}

bool parseChargingResponseMessage(List<int> value) {
  //String startByte = value[0].toRadixString(16);
  //String endByte = value.last.toRadixString(16);
  if (value[0] != startByte) {
    // $ start byte
    debugPrint("\n Wrong Start Byte \n");
    return false;
  }
  if (value.last != stopByte) {
    //  # end byte
    debugPrint("\n Wrong End Byte \n");
    return false;
  }
  int length = value[2];
  if (length <= 7) {
    debugPrint("\n Missing Data Fields or Data Length Too Short \n");
    return false;
  }
  if (verifyCheckSum(value, length) == false) {
    return false;
  }

  // String sessionID = '';
  // sessionID += value[3].toRadixString(16);
  // sessionID += value[4].toRadixString(16);
  int sessionID = value[3] << 8;
  sessionID |= (0xFF & value[4]);
  int stopStartCh = value[5];
  int meterValue = value[6] << 8;
  meterValue |= (0xFF & value[7]);
  int errorCode1 = value[8];
  Int8 e1 = Int8(errorCode1);
  int errorCode2 = value[9];
  Int8 e2 = Int8(errorCode2);
  int state = value[10];

  responseChargingRecieved = true;

  if (state == ChargePointStateENUM.CHARGE_POINT_END_OF_CHARGING.index) {
    if (errorCode1 != 0 || errorCode2 != 0) {
      debugPrint(
          "\n ******* ERROR CODE RECEIVED [${e1.toBinaryPadded()}], [${e2.toBinaryPadded()}] ******* \n");
      for (int i = 0; i < 5; i++) {
        if (e1.getBit(i) == 1) {
          debugPrint("ERRORCODE1 ${ErrorCode1ENUM.values.elementAt(i)} \n");
        }
      }
      for (int i = 0; i < 8; i++) {
        if (e2.getBit(i) == 1) {
          debugPrint("ERRORCODE2 ${ErrorCode2ENUM.values.elementAt(i)} \n");
        }
      }
    }
    debugPrint("\n ****** Charging ERROR Charging Ended ****** \n");
    endHeartbeat = true;

    return false;
  }

  // debugPrint(
  //     "\n Charging Parsed Packet: $length, $sessionID, ${StopStartChENUM.values.elementAt(stopStartCh)}, $meterValue, ${ErrorCode1ENUM.values.elementAt(errorCode1)}, ${ErrorCode2ENUM.values.elementAt(errorCode2)}, ${ChargePointStateENUM.values.elementAt(state)}} \n");
  debugPrint(
      "\n Charging Parsed Packet: $length, $sessionID, ${StopStartChENUM.values.elementAt(stopStartCh)}, $meterValue, [${e1.toBinaryPadded()}], [${e2.toBinaryPadded()}], ${ChargePointStateENUM.values.elementAt(state)} \n");

  return true;
}

///Ends heartbeat timer when End of Charging Messages is recieved
bool parseEndoFChargingResponseMessage(List<int> value) {
  //String startByte = value[0].toRadixString(16);
  //String endByte = value.last.toRadixString(16);
  if (value[0] != startByte) {
    // $ start byte
    debugPrint("\n Wrong Start Byte \n");
    return false;
  }
  if (value.last != stopByte) {
    //  # end byte
    debugPrint("\n Wrong End Byte \n");
    return false;
  }
  int length = value[2];
  if (length < 5) {
    debugPrint("\n Missing Data Fields or Data Length Too Short \n");
    return false;
  }
  if (verifyCheckSum(value, length) == false) {
    return false;
  }

  endHeartbeat = true;
  responseEndoFChargingRecieved = true;

  int sessionID = value[3] << 8;
  sessionID |= (0xFF & value[4]);
  int state = value[5];
  int reasonForStop = value[6];
  int meterValue = value[7] << 8;
  meterValue |= (0xFF & value[8]);
  // currentMeterValue = meterValue.toDouble() / 1000.0;

  currentChargerState = ChargePointStateENUM.values.elementAt(state);

  debugPrint(
      "\n End Of Charging Parsed Packet: $length, $sessionID, ${ChargePointStateENUM.values.elementAt(state)}, ${ReasonforStopENUM.values.elementAt(reasonForStop)}, $meterValue \n");
  return true;
}

///Ends heartbeat timer when Diagnostic response has an error in either ERROR1 or ERROR2 data field
bool parseDiagnosticResponseMessage(List<int> value) {
  //String startByte = value[0].toRadixString(16);
  //String endByte = value.last.toRadixString(16);
  if (value[0] != 24) {
    // $ start byte
    debugPrint("\n Wrong Start Byte \n");
    return false;
  }
  if (value.last != 23) {
    //  # end byte
    debugPrint("\n Wrong End Byte \n");
    return false;
  }
  int length = value[2];

  if (length < 8) {
    // debugPrint("\n Missing Data Fields or Data Length Short \n");
    return false;
  }

  if (verifyCheckSum(value, length) == false) {
    return false;
  }

  int sessionID = (value[3] * 100) + value[4];
  int errorCode1 = value[5];
  Int8 e1 = Int8(errorCode1);
  int errorCode2 = value[6];
  Int8 e2 = Int8(errorCode2);

  int state = value[7];
  // currentChargerState = ChargePointStateENUM.values.elementAt(state);

  if (state == ChargePointStateENUM.CHARGE_POINT_ERROR.index) {
    if (errorCode1 != 0 || errorCode2 != 0) {
      debugPrint(
          "\n ******* ERROR CODE RECEIVED [${e1.toBinaryPadded()}], [${e2.toBinaryPadded()}] ******* \n");
      for (int i = 0; i < 5; i++) {
        if (e1.getBit(i) == 1) {
          debugPrint("ERRORCODE1 ${ErrorCode1ENUM.values.elementAt(i)} \n");
        }
      }
      for (int i = 0; i < 8; i++) {
        if (e2.getBit(i) == 1) {
          debugPrint("ERRORCODE2 ${ErrorCode2ENUM.values.elementAt(i)} \n");
        }
      }
    }
    debugPrint("\n ****** Diagnostic EROOR Charging Ended ****** \n");

    endHeartbeat = true;

    return false;
  }

  if (state == ChargePointStateENUM.CHARGE_POINT_END_OF_CHARGING.index) {
    // debugPrint("\n ****** Diagnostic Got End Of Charging State ****** \n");
    endHeartbeat = true;
  }

  if (state == ChargePointStateENUM.CHARGE_POINT_CHARGING.index) {
    // debugPrint("\n ****** Diagnostic Got Charging State ****** \n");
    startCharging = true;
  }

  int sessionActive = value[8];

  int meterValue = value[9] << 8;
  meterValue |= 0xFF & value[10];
  // int meterValue = (value[9] * 100) + value[10];
  currentMeterValue = meterValue.toDouble() / 1000.0;
  if (firstDiagnosticRecieved == false) {
    firstDiagnosticRecieved = true;
  }

  // debugPrint(
  //     "\n Diagnostic Parsed Packet: $length, $sessionID, ${ErrorCode1ENUM.values.elementAt(errorCode1)}, ${ErrorCode2ENUM.values.elementAt(errorCode2)}, ${ChargePointStateENUM.values.elementAt(state)}}, ${SessionActiveENUM.values.elementAt(sessionActive)}, $meterValue\n");
  // debugPrint(
  //     "\n Diagnostic_Parsed_Packet: $length, $sessionID, [${e1.toBinaryPadded()}], [${e2.toBinaryPadded()}], ${ChargePointStateENUM.values.elementAt(state)}, ${SessionActiveENUM.values.elementAt(sessionActive)}, $meterValue, $currentMeterValue\n");
  return true;
}

bool parseTimeSyncMessage(List<int> value) {
  // String formattedDate = DateFormat('ddMMyy HH:mm:ss').format(tsdate);
  int yearOffset = 128;
//  String startByte = value[0].toRadixString(16);
//  String endByte = value.last.toRadixString(16);

  if (value[0] != 24) {
    // $ start byte
    debugPrint("\n Wrong Start Byte \n");
    return false;
  }
  if (value.last != 23) {
    //  # end byte
    debugPrint("\n Wrong End Byte \n");
    return false;
  }

  int length = value[2];
  if (verifyCheckSum(value, length) == false) {
    return false;
  }

  int requestType = value[3]; // get | set
  // String OperatorID = '';
  int operatorID = (value[4] * 100) + value[5];

  int day = value[6]; //dd
  int month = value[7]; //MM
  int year = value[8]; //yy
  int hour = value[9]; //HH
  int minute = value[10]; //mm
  int second = value[11]; //ss

  DateTime tsdate =
      /*DateTime(year + 2000 - yearOffset, month, day, hour, minute, second);*/
      DateTime(year + 2000, month, day, hour, minute,
          second); // SoSi: Without Offset

  debugPrint(
      "\n Time Sync Parsed Packet: $length, $requestType, $operatorID, $tsdate  \n");
  return true;
}

bool parseOperatorRegResponseMessage(List<int> value) {
//  String startByte = value[0].toRadixString(16);
//  String endByte = value.last.toRadixString(16);
  if (value[0] != 24) {
    // $ start byte
    debugPrint("\n Wrong Start Byte \n");
    return false;
  }
  if (value.last != 23) {
    //  # end byte
    debugPrint("\n Wrong End Byte \n");
    return false;
  }

  int length = value[2];
  if (length > 1) {
    debugPrint("\n Missing Data Fields or Data Length Too Long \n");
    return false;
  }

  if (verifyCheckSum(value, length) == false) {
    return false;
  }

  int state = value[3];

  debugPrint(
      "\n Operator Reg Parsed Packet: $length, ${RegisteredENUM.values.elementAt(state)} \n");
  return true;
}

bool parseEVOwnerRegResponseMessage(List<int> value) {
//  String startByte = value[0].toRadixString(16);
//  String endByte = value.last.toRadixString(16);
  if (value[0] != 24) {
    // $ start byte
    debugPrint("\n Wrong Start Byte \n");
    return false;
  }
  if (value.last != 23) {
    //  # end byte
    debugPrint("\n Wrong End Byte \n");
    return false;
  }

  int length = value[2];
  if (length > 1) {
    debugPrint("\n Missing Data Fields or Data Length Too Long \n");
    return false;
  }
  if (verifyCheckSum(value, length) == false) {
    return false;
  }

  int state = value[3];

  debugPrint(
      "\n EV Owner Reg Parsed Packet: $length, ${ConditionENUM.values.elementAt(state)} \n");
  return true;
}

bool parseScheduleChargeRequestResponseMessage(List<int> value) {
//  String startByte = value[0].toRadixString(16);
//  String endByte = value.last.toRadixString(16);
  if (value[0] != 24) {
    // $ start byte
    debugPrint("\n Wrong Start Byte \n");
    return false;
  }
  if (value.last != 23) {
    //  # end byte
    debugPrint("\n Wrong End Byte \n");
    return false;
  }

  int length = value[2];
  if (length > 1) {
    debugPrint("\n Missing Data Fields or Data Length Too Long \n");
    return false;
  }
  if (verifyCheckSum(value, length) == false) {
    return false;
  }

  int state = value[3];

  debugPrint(
      "\n Schedule Charge Parsed Packet: $length, ${ConditionENUM.values.elementAt(state)} \n");
  return true;
}

Future<bool> writeInitializationMessage(
    BluetoothCharacteristic characteristic) async {
  List<int> requestMessage = List.filled(8, 0);
  String operatorID = "1234";
  requestMessage[0] = 24;
  requestMessage[1] = 1;
  requestMessage[2] = 2;
  requestMessage[3] = int.parse(operatorID.substring(0, 2));
  requestMessage[4] = int.parse(operatorID.substring(2, 4));
  int checkSum = requestMessage[3].toInt() + requestMessage[4].toInt();
  requestMessage[5] = checkSum ~/ 100;
  requestMessage[6] = checkSum % 100;
  requestMessage[7] = 23;

  debugPrint("\n writeInitializationMessage $requestMessage \n");
  try {
    await characteristic.write(requestMessage, withoutResponse: false);
  } on Exception catch (e) {
    debugPrint("\n writeInitializationMessage Failed: $e \n");
    return false;
  }
  debugPrint("\n writeInitializationMessage Complete \n");

  endHeartbeat = false;

  return true;
}

Future<bool> writeAuthenticationMessage(BluetoothCharacteristic characteristic,
    ChargeSettings chargeSetting) async {
  List<int> requestMessage = List.filled(14, 0);
  String sessionID = "1234";
  String evOwnerID = "9090";
  int requestChargeAmount =
      (((chargeSetting.totalTime / 3.6e+6) * chargeSetting.chargeSpeed) * 1000)
          .toInt();

  responseAuthenticationRecieved = false;

  requestMessage[0] = 24;
  requestMessage[1] = 2;
  //Data Length
  requestMessage[2] = 8;
  //SessionID
  requestMessage[3] = int.parse(sessionID.substring(0, 2));
  requestMessage[4] = int.parse(sessionID.substring(2, 4));
  //VehicleType
  requestMessage[5] = 10;
  //PaymentType
  requestMessage[6] = 3;
  //Total Meter Unit Required
  // requestMessage[7] = requestChargeAmount ~/ 100;
  // requestMessage[8] = requestChargeAmount % 100;
  requestMessage[7] = (requestChargeAmount >> 8) & 0xFF;
  requestMessage[8] = (requestChargeAmount >> 0) & 0xFF;
  //EV owner ID Number
  requestMessage[9] = int.parse(evOwnerID.substring(0, 2));
  requestMessage[10] = int.parse(evOwnerID.substring(2, 4));
  //Checksum
  int checkSum = 0;
  for (int i = 3; i < 11; i++) {
    checkSum += requestMessage[i];
  }
  // debugPrint("\nCheckSum $checkSum\n");

  // String hexString = checkSum.decToHex(); //Change Split
  // List<int> checkSumList = getCheckSum(hexString);
  requestMessage[11] = checkSum ~/ 100;
  requestMessage[12] = checkSum % 100;
  requestMessage[13] = 23;

  debugPrint(
      "\n writeAuthenticationMessage $requestMessage with requested charge: $requestChargeAmount and Total Time: ${chargeSetting.totalTime} ${chargeSetting.totalTime / 3.6e+6}\n");
  try {
    await characteristic.write(requestMessage, withoutResponse: false);
  } on Exception catch (e) {
    debugPrint("\n writeAuthenticationMessage Failed: $e \n");
    return false;
  }
  debugPrint("\n writeAuthenticationMessage Complete \n");
  return true;
}

Future<bool> writeChargingMessage(
    BluetoothCharacteristic characteristic) async {
  List<int> requestMessage = List.filled(13, 0);
  String sessionID = "1234";
  String operatorID = "9988";
  int eVOwnerNumber = 1234;

  responseChargingRecieved = false;

  requestMessage[0] = 24;
  requestMessage[1] = 3;
  requestMessage[2] = 7;
  requestMessage[3] = int.parse(sessionID.substring(0, 2));
  requestMessage[4] = int.parse(sessionID.substring(2, 4));
  requestMessage[5] = 1;
  requestMessage[6] = int.parse(operatorID.substring(0, 2));
  requestMessage[7] = int.parse(operatorID.substring(2, 4));
  requestMessage[8] = eVOwnerNumber ~/ 100;
  requestMessage[9] = eVOwnerNumber % 100;

  int checkSum = 0;
  for (int i = 3; i < 10; i++) {
    checkSum += requestMessage[i];
  }

  requestMessage[10] = checkSum ~/ 100;
  requestMessage[11] = checkSum % 100;
  requestMessage[12] = 23;

  debugPrint("\n writeChargingMessage $requestMessage \n");

  try {
    await characteristic.write(requestMessage, withoutResponse: false);
  } on Exception catch (e) {
    debugPrint("\n writeChargingMessage Failed: $e \n");
    return false;
  }
  debugPrint("\n writeChargingMessage Complete \n");
  return true;
}

Future<bool> writeEndoFChargingMessage(
    BluetoothCharacteristic characteristic) async {
  List<int> requestMessage = List.filled(9, 0);
  String sessionID = "1234";

  responseEndoFChargingRecieved = false;

  requestMessage[0] = 24;
  requestMessage[1] = 4;
  requestMessage[2] = 3;
  requestMessage[3] = int.parse(sessionID.substring(0, 2));
  requestMessage[4] = int.parse(sessionID.substring(2, 4));
  requestMessage[5] = 2;

  int checkSum = 0;
  for (int i = 3; i < 6; i++) {
    checkSum += requestMessage[i];
  }

  requestMessage[6] = checkSum ~/ 100;
  requestMessage[7] = checkSum % 100;
  requestMessage[8] = 23;

  debugPrint("\n writeEndChargingMessage $requestMessage \n");

  try {
    await characteristic.write(requestMessage, withoutResponse: false);
  } on Exception catch (e) {
    debugPrint("\n writeEndChargingMessage Failed: $e \n");
    return false;
  }
  debugPrint("\n writeEndChargingMessage Complete \n");
  return true;
}

Future<bool> writeDiagnosticMessage(
    BluetoothCharacteristic characteristic) async {
  List<int> requestMessage = List.filled(10, 0);
  String sessionID = "1234";
  String operatorID = "9988";

  requestMessage[0] = 24;
  requestMessage[1] = 5;
  requestMessage[2] = 4;
  requestMessage[3] = int.parse(operatorID.substring(0, 2));
  requestMessage[4] = int.parse(operatorID.substring(2, 4));

  requestMessage[5] = int.parse(sessionID.substring(0, 2));
  requestMessage[6] = int.parse(sessionID.substring(2, 4));

  int checkSum = 0;
  for (int i = 3; i < 7; i++) {
    checkSum += requestMessage[i];
  }

  requestMessage[7] = checkSum ~/ 100;
  requestMessage[8] = checkSum % 100;
  requestMessage[9] = 23;

  // debugPrint("\n writeDiagnosticMessage $requestMessage \n");

  try {
    await characteristic.write(requestMessage, withoutResponse: false);
  } on Exception {
    // debugPrint("\n writeDiagnosticMessage Failed: $e \n");
    return false;
  }
  // debugPrint("\n writeDiagnosticMessage Complete \n");
  return true;
}

Future<bool> writeTimeSyncMessage(
    BluetoothCharacteristic characteristic, DateTime tsdate) async {
  String formattedDate = DateFormat('ddMMyy HH:mm:ss').format(tsdate);
  List<int> requestMessage = List.filled(15, 0);
  String operatorID = "9988";

  requestMessage[0] = 24;
  requestMessage[1] = 7;
  requestMessage[2] = 9;

  requestMessage[3] = 1; //Get | Set
  requestMessage[4] = int.parse(operatorID.substring(0, 2));
  requestMessage[5] = int.parse(operatorID.substring(2, 4));
  requestMessage[6] = int.parse(formattedDate.substring(0, 2)); // Day
  requestMessage[7] = int.parse(formattedDate.substring(2, 4)); // Month
  requestMessage[8] = int.parse(formattedDate.substring(4, 6)); // Year
  requestMessage[9] = int.parse(formattedDate.substring(7, 9)); // Hour
  requestMessage[10] = int.parse(formattedDate.substring(10, 12)); // Minute
  requestMessage[11] = int.parse(formattedDate.substring(13)); // Second

  int checkSum = 0;
  for (int i = 3; i < 12; i++) {
    checkSum += requestMessage[i];
  }
  // debugPrint("\nCheckSum $checkSum\n");

  requestMessage[12] = checkSum ~/ 100;
  requestMessage[13] = checkSum % 100;
  requestMessage[14] = 23;

  debugPrint("\n writeTimeSyncMessage $requestMessage \n");
  try {
    await characteristic.write(requestMessage, withoutResponse: false);
  } on Exception catch (e) {
    debugPrint("\n writeTimeSyncMessage Failed: $e \n");
    return false;
  }
  debugPrint("\n writeTimeSyncMessage Complete \n");
  return true;
}

Future<bool> writeOperaotrRegMessage(
    BluetoothCharacteristic characteristic) async {
  List<int> requestMessage = List.filled(9, 0);
  String operatorID = "9988";

  requestMessage[0] = 24;
  requestMessage[1] = 8;
  requestMessage[2] = 3;
  requestMessage[3] = int.parse(operatorID.substring(0, 2));
  requestMessage[4] = int.parse(operatorID.substring(2, 4));
  requestMessage[5] = 1;

  int checkSum = 0;
  for (int i = 3; i < 6; i++) {
    checkSum += requestMessage[i];
  }

  requestMessage[6] = checkSum ~/ 100;
  requestMessage[7] = checkSum % 100;
  requestMessage[8] = 23;

  debugPrint("\n writeOperaotrRegMessage $requestMessage \n");

  try {
    await characteristic.write(requestMessage, withoutResponse: false);
  } on Exception catch (e) {
    debugPrint("\n writeOperaotrRegMessage Failed: $e \n");
    return false;
  }
  debugPrint("\n writeOperaotrRegMessage Complete \n");
  return true;
}

Future<bool> writeEVOwnerRegRegMessage(
    BluetoothCharacteristic characteristic) async {
  List<int> requestMessage = List.filled(9, 0);
  String evOwnerReg = "0909";

  requestMessage[0] = 24;
  requestMessage[1] = 10;
  requestMessage[2] = 3;
  requestMessage[3] = int.parse(evOwnerReg.substring(0, 2));
  requestMessage[4] = int.parse(evOwnerReg.substring(2, 4));
  requestMessage[5] = 1;

  int checkSum = 0;
  for (int i = 3; i < 6; i++) {
    checkSum += requestMessage[i];
  }

  requestMessage[6] = checkSum ~/ 100;
  requestMessage[7] = checkSum % 100;
  requestMessage[8] = 23;

  debugPrint("\n writeEVOwnerRegRegMessage $requestMessage \n");

  try {
    await characteristic.write(requestMessage, withoutResponse: false);
  } on Exception catch (e) {
    debugPrint("\n writeEVOwnerRegRegMessage Failed: $e \n");
    return false;
  }
  debugPrint("\n writeEVOwnerRegRegMessage Complete \n");
  return true;
}

Future<bool> writeScheduleChargeRequestMessage(
    BluetoothCharacteristic characteristic,
    DateTime startTime,
    int mintue) async {
  List<int> requestMessage = List.filled(20, 0);
  DateTime stopTime = startTime.add(Duration(minutes: mintue));
  String formattedStartDate = DateFormat('ddMMyy HH:mm:ss').format(startTime);
  String formattedStopDate = DateFormat('ddMMyy HH:mm:ss').format(stopTime);

  String operatorID = "9988";

  requestMessage[0] = 24;
  requestMessage[1] = 11; //0x0B;
  requestMessage[2] = 14; //0x0E;
  requestMessage[3] = int.parse(operatorID.substring(0, 2));
  requestMessage[4] = int.parse(operatorID.substring(2, 4));
  requestMessage[5] = int.parse(formattedStartDate.substring(0, 2)); // Day
  requestMessage[6] = int.parse(formattedStartDate.substring(2, 4)); // Month
  requestMessage[7] = int.parse(formattedStartDate.substring(4, 6)); // Year
  requestMessage[8] = int.parse(formattedStartDate.substring(7, 9)); // Hour
  requestMessage[9] = int.parse(formattedStartDate.substring(10, 12)); // Minute
  requestMessage[10] = int.parse(formattedStartDate.substring(13)); // Second

  requestMessage[11] = int.parse(formattedStopDate.substring(0, 2)); // Day
  requestMessage[12] = int.parse(formattedStopDate.substring(2, 4)); // Month
  requestMessage[13] = int.parse(formattedStopDate.substring(4, 6)); // Year
  requestMessage[14] = int.parse(formattedStopDate.substring(7, 9)); // Hour
  requestMessage[15] = int.parse(formattedStopDate.substring(10, 12)); // Minute
  requestMessage[16] = int.parse(formattedStopDate.substring(13)); // Second

  int checkSum = 0;
  for (int i = 3; i < 17; i++) {
    checkSum += requestMessage[i];
  }

  requestMessage[17] = checkSum ~/ 100;
  requestMessage[18] = checkSum % 100;
  requestMessage[19] = 23;

  debugPrint("\n writeScheduleChargeRequestMessage $requestMessage \n");

  try {
    await characteristic.write(requestMessage, withoutResponse: false);
  } on Exception catch (e) {
    debugPrint("\n writeScheduleChargeRequestMessage Failed: $e \n");
    return false;
  }
  debugPrint("\n writeScheduleChargeRequestMessage Complete \n");
  return true;
}
