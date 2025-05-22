// Copyright (c) 2018-2025 HERE Global B.V. and its affiliate(s).
// All rights reserved.
//
// This software and other materials contain proprietary information
// controlled by HERE and are protected by applicable copyright legislation.
// Any use and utilization of this software and other materials and
// disclosure to any third parties is conditional upon having a separate
// agreement with HERE for the access, use, utilization or disclosure of this
// software. In the absence of such agreement, the use of the software is not
// allowed.
//

import 'dart:ffi';
import 'package:collection/collection.dart';
import 'package:here_sdk/src/_library_context.dart' as __lib;
import 'package:here_sdk/src/generic_types__conversion.dart';

/// This model defines the empirical consumption mode used in electric vehicles.
///
/// Parameters specific for the electric vehicle, which are then used to calculate
/// energy consumption on a given route.
/// At minimum, you must provide [EmpiricalConsumptionModel.ascentConsumptionInWattHoursPerMeter],
/// [EmpiricalConsumptionModel.descentRecoveryInWattHoursPerMeter] and a
/// [EmpiricalConsumptionModel.freeFlowSpeedTable].
/// **Note:** This is a beta release of this feature, so there could be a few bugs and unexpected behaviors.
/// Related APIs may change for new releases without a deprecation process.

class EmpiricalConsumptionModel {
  /// Rate of energy consumed per meter rise in elevation (in Wh/m, i.e., Watt-hours per meter).
  double ascentConsumptionInWattHoursPerMeter;

  /// Rate of energy recovered per meter fall in elevation (in Wh/m, i.e., Watt-hours per meter).
  double descentRecoveryInWattHoursPerMeter;

  /// Free flow speed table describes energy consumption when traveling at constant speed.
  /// It defines a function curve specifying consumption rate at a given free flow speed
  /// on a flat stretch of road.
  /// Map keys represent speed values that are non-negative integers in units of (km/h).
  /// Map values represent consumption values that are non-negative floating point values
  /// in units of (Wh/m).
  /// The function is linearly interpolated between each successive pair of data points:
  /// For values below the first list value, the first value is used.
  /// For values after the last list value, the last list value is used.
  /// At minimum, one key/value pair must be set. In this case the consumption value is
  /// used for all possible speed keys.
  Map<int, double> freeFlowSpeedTable;

  /// Traffic speed table describes energy consumption when traveling under heavy traffic
  /// conditions, i.e. when the vehicle is expected to often change the travel speed.
  /// It defines a function curve specifying consumption rate at a given speed under traffic
  /// conditions on a flat stretch of road.
  /// Map keys represent traffic speed values that are non-negative integers in units of (km/h).
  /// Map values represent consumption values that are non-negative floating point values
  /// in units of (Wh/m).
  /// The function is linearly interpolated between each successive pair of data points:
  /// For values below the first list value, the first value is used.
  /// For values after the last list value, the last list value is used.
  /// If only one key/value pair is set, the consumption value is
  /// used for all possible traffic speed keys.
  /// If [EmpiricalConsumptionModel.trafficSpeedTable] is empty then only
  /// [EmpiricalConsumptionModel.freeFlowSpeedTable] is used for calculating speed-related
  /// energy consumption.
  Map<int, double> trafficSpeedTable;

  /// Rate of energy (in Wh/s) consumed by the vehicle's auxiliary systems
  /// (e.g., air conditioning, lights) per second of travel.
  double auxiliaryConsumptionInWattHoursPerSecond;

  /// Creates a new instance.

  /// [ascentConsumptionInWattHoursPerMeter] Rate of energy consumed per meter rise in elevation (in Wh/m, i.e., Watt-hours per meter).

  /// [descentRecoveryInWattHoursPerMeter] Rate of energy recovered per meter fall in elevation (in Wh/m, i.e., Watt-hours per meter).

  /// [freeFlowSpeedTable] Free flow speed table describes energy consumption when traveling at constant speed.
  /// It defines a function curve specifying consumption rate at a given free flow speed
  /// on a flat stretch of road.
  /// Map keys represent speed values that are non-negative integers in units of (km/h).
  /// Map values represent consumption values that are non-negative floating point values
  /// in units of (Wh/m).
  /// The function is linearly interpolated between each successive pair of data points:
  /// For values below the first list value, the first value is used.
  /// For values after the last list value, the last list value is used.
  /// At minimum, one key/value pair must be set. In this case the consumption value is
  /// used for all possible speed keys.

  /// [trafficSpeedTable] Traffic speed table describes energy consumption when traveling under heavy traffic
  /// conditions, i.e. when the vehicle is expected to often change the travel speed.
  /// It defines a function curve specifying consumption rate at a given speed under traffic
  /// conditions on a flat stretch of road.
  /// Map keys represent traffic speed values that are non-negative integers in units of (km/h).
  /// Map values represent consumption values that are non-negative floating point values
  /// in units of (Wh/m).
  /// The function is linearly interpolated between each successive pair of data points:
  /// For values below the first list value, the first value is used.
  /// For values after the last list value, the last list value is used.
  /// If only one key/value pair is set, the consumption value is
  /// used for all possible traffic speed keys.
  /// If [EmpiricalConsumptionModel.trafficSpeedTable] is empty then only
  /// [EmpiricalConsumptionModel.freeFlowSpeedTable] is used for calculating speed-related
  /// energy consumption.

  /// [auxiliaryConsumptionInWattHoursPerSecond] Rate of energy (in Wh/s) consumed by the vehicle's auxiliary systems
  /// (e.g., air conditioning, lights) per second of travel.

  EmpiricalConsumptionModel._(this.ascentConsumptionInWattHoursPerMeter, this.descentRecoveryInWattHoursPerMeter, this.freeFlowSpeedTable, this.trafficSpeedTable, this.auxiliaryConsumptionInWattHoursPerSecond);
  EmpiricalConsumptionModel()
    : ascentConsumptionInWattHoursPerMeter = 0.0, descentRecoveryInWattHoursPerMeter = 0.0, freeFlowSpeedTable = {}, trafficSpeedTable = {}, auxiliaryConsumptionInWattHoursPerSecond = 0.0;
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EmpiricalConsumptionModel) return false;
    EmpiricalConsumptionModel _other = other;
    return ascentConsumptionInWattHoursPerMeter == _other.ascentConsumptionInWattHoursPerMeter &&
        descentRecoveryInWattHoursPerMeter == _other.descentRecoveryInWattHoursPerMeter &&
        DeepCollectionEquality().equals(freeFlowSpeedTable, _other.freeFlowSpeedTable) &&
        DeepCollectionEquality().equals(trafficSpeedTable, _other.trafficSpeedTable) &&
        auxiliaryConsumptionInWattHoursPerSecond == _other.auxiliaryConsumptionInWattHoursPerSecond;
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + ascentConsumptionInWattHoursPerMeter.hashCode;
    result = 31 * result + descentRecoveryInWattHoursPerMeter.hashCode;
    result = 31 * result + DeepCollectionEquality().hash(freeFlowSpeedTable);
    result = 31 * result + DeepCollectionEquality().hash(trafficSpeedTable);
    result = 31 * result + auxiliaryConsumptionInWattHoursPerSecond.hashCode;
    return result;
  }
}


// EmpiricalConsumptionModel "private" section, not exported.

final _sdkRoutingEmpiricalconsumptionmodelCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Double, Double, Pointer<Void>, Pointer<Void>, Double),
    Pointer<Void> Function(double, double, Pointer<Void>, Pointer<Void>, double)
  >('here_sdk_sdk_routing_EmpiricalConsumptionModel_create_handle'));
final _sdkRoutingEmpiricalconsumptionmodelReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_EmpiricalConsumptionModel_release_handle'));
final _sdkRoutingEmpiricalconsumptionmodelGetFieldascentConsumptionInWattHoursPerMeter = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Double Function(Pointer<Void>),
    double Function(Pointer<Void>)
  >('here_sdk_sdk_routing_EmpiricalConsumptionModel_get_field_ascentConsumptionInWattHoursPerMeter'));
final _sdkRoutingEmpiricalconsumptionmodelGetFielddescentRecoveryInWattHoursPerMeter = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Double Function(Pointer<Void>),
    double Function(Pointer<Void>)
  >('here_sdk_sdk_routing_EmpiricalConsumptionModel_get_field_descentRecoveryInWattHoursPerMeter'));
final _sdkRoutingEmpiricalconsumptionmodelGetFieldfreeFlowSpeedTable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_EmpiricalConsumptionModel_get_field_freeFlowSpeedTable'));
final _sdkRoutingEmpiricalconsumptionmodelGetFieldtrafficSpeedTable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_EmpiricalConsumptionModel_get_field_trafficSpeedTable'));
final _sdkRoutingEmpiricalconsumptionmodelGetFieldauxiliaryConsumptionInWattHoursPerSecond = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Double Function(Pointer<Void>),
    double Function(Pointer<Void>)
  >('here_sdk_sdk_routing_EmpiricalConsumptionModel_get_field_auxiliaryConsumptionInWattHoursPerSecond'));



Pointer<Void> sdkRoutingEmpiricalconsumptionmodelToFfi(EmpiricalConsumptionModel value) {
  final _ascentConsumptionInWattHoursPerMeterHandle = (value.ascentConsumptionInWattHoursPerMeter);
  final _descentRecoveryInWattHoursPerMeterHandle = (value.descentRecoveryInWattHoursPerMeter);
  final _freeFlowSpeedTableHandle = heresdkRoutingCommonBindingsmapofIntToDoubleToFfi(value.freeFlowSpeedTable);
  final _trafficSpeedTableHandle = heresdkRoutingCommonBindingsmapofIntToDoubleToFfi(value.trafficSpeedTable);
  final _auxiliaryConsumptionInWattHoursPerSecondHandle = (value.auxiliaryConsumptionInWattHoursPerSecond);
  final _result = _sdkRoutingEmpiricalconsumptionmodelCreateHandle(_ascentConsumptionInWattHoursPerMeterHandle, _descentRecoveryInWattHoursPerMeterHandle, _freeFlowSpeedTableHandle, _trafficSpeedTableHandle, _auxiliaryConsumptionInWattHoursPerSecondHandle);
  
  
  heresdkRoutingCommonBindingsmapofIntToDoubleReleaseFfiHandle(_freeFlowSpeedTableHandle);
  heresdkRoutingCommonBindingsmapofIntToDoubleReleaseFfiHandle(_trafficSpeedTableHandle);
  
  return _result;
}

EmpiricalConsumptionModel sdkRoutingEmpiricalconsumptionmodelFromFfi(Pointer<Void> handle) {
  final _ascentConsumptionInWattHoursPerMeterHandle = _sdkRoutingEmpiricalconsumptionmodelGetFieldascentConsumptionInWattHoursPerMeter(handle);
  final _descentRecoveryInWattHoursPerMeterHandle = _sdkRoutingEmpiricalconsumptionmodelGetFielddescentRecoveryInWattHoursPerMeter(handle);
  final _freeFlowSpeedTableHandle = _sdkRoutingEmpiricalconsumptionmodelGetFieldfreeFlowSpeedTable(handle);
  final _trafficSpeedTableHandle = _sdkRoutingEmpiricalconsumptionmodelGetFieldtrafficSpeedTable(handle);
  final _auxiliaryConsumptionInWattHoursPerSecondHandle = _sdkRoutingEmpiricalconsumptionmodelGetFieldauxiliaryConsumptionInWattHoursPerSecond(handle);
  try {
    return EmpiricalConsumptionModel._(
      (_ascentConsumptionInWattHoursPerMeterHandle), 
      (_descentRecoveryInWattHoursPerMeterHandle), 
      heresdkRoutingCommonBindingsmapofIntToDoubleFromFfi(_freeFlowSpeedTableHandle), 
      heresdkRoutingCommonBindingsmapofIntToDoubleFromFfi(_trafficSpeedTableHandle), 
      (_auxiliaryConsumptionInWattHoursPerSecondHandle)
    );
  } finally {
    
    
    heresdkRoutingCommonBindingsmapofIntToDoubleReleaseFfiHandle(_freeFlowSpeedTableHandle);
    heresdkRoutingCommonBindingsmapofIntToDoubleReleaseFfiHandle(_trafficSpeedTableHandle);
    
  }
}

void sdkRoutingEmpiricalconsumptionmodelReleaseFfiHandle(Pointer<Void> handle) => _sdkRoutingEmpiricalconsumptionmodelReleaseHandle(handle);

// Nullable EmpiricalConsumptionModel

final _sdkRoutingEmpiricalconsumptionmodelCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_EmpiricalConsumptionModel_create_handle_nullable'));
final _sdkRoutingEmpiricalconsumptionmodelReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_EmpiricalConsumptionModel_release_handle_nullable'));
final _sdkRoutingEmpiricalconsumptionmodelGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_EmpiricalConsumptionModel_get_value_nullable'));

Pointer<Void> sdkRoutingEmpiricalconsumptionmodelToFfiNullable(EmpiricalConsumptionModel? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkRoutingEmpiricalconsumptionmodelToFfi(value);
  final result = _sdkRoutingEmpiricalconsumptionmodelCreateHandleNullable(_handle);
  sdkRoutingEmpiricalconsumptionmodelReleaseFfiHandle(_handle);
  return result;
}

EmpiricalConsumptionModel? sdkRoutingEmpiricalconsumptionmodelFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkRoutingEmpiricalconsumptionmodelGetValueNullable(handle);
  final result = sdkRoutingEmpiricalconsumptionmodelFromFfi(_handle);
  sdkRoutingEmpiricalconsumptionmodelReleaseFfiHandle(_handle);
  return result;
}

void sdkRoutingEmpiricalconsumptionmodelReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkRoutingEmpiricalconsumptionmodelReleaseHandleNullable(handle);

// End of EmpiricalConsumptionModel "private" section.


