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
import 'package:here_sdk/src/_library_context.dart' as __lib;

/// This model defines the physical consumption mode used in electric vehicles.
///
/// Parameters specific for the electric vehicle, which are then used to calculate
/// energy consumption on a given route.
/// **Note** The [TransportedCargo.currentWeightInKilograms] has to be defined.
/// **Note:** This is a beta release of this feature, so there could be a few bugs and unexpected behaviors.
/// Related APIs may change for new releases without a deprecation process.

class PhysicalConsumptionModel {
  /// The proportion of the energy drawn from the battery that is used to move the vehicle.
  /// (This is to factor in energy losses through heat in the motors, for example.)
  /// Supported range from 0 to 1
  double driveTrainEfficiency;

  /// The proportion of the energy gained when braking or going downhill that can be recuperated and restored as battery charge.
  ///
  /// Supported range from 0 to 1
  double recuperationEfficiency;

  /// Power (in W) consumed by the vehicle's auxiliary systems (for example, air conditioning, lights).
  ///
  /// Supported range from 0 to 1
  double auxiliaryPowerConsumptionInWatts;

  /// Frontal area represents the total cross section area of the vehicle as viewed from the front, specified in square meters.
  /// Physical consumption model is using this value in combination with `airDragCoefficient` to calculate the consumption caused by air resistance.
  /// As fallback [VehicleSpecification.widthInCentimeters] and [VehicleSpecification.heightInCentimeters] are used.
  ///
  /// This parameter is used to provide a more accurate consumption prediction for electric vehicles.
  ///
  /// In the range from 0.5 to 50
  double frontalAreaInSquareMeters;

  /// Rolling resistance refers to the resistance experienced by your vehicle tire as it rolls over a surface.
  /// The main causes of this resistance are tire deformation, wing drag, and friction with the ground.
  /// The coefficient of rolling resistance is a numerical value indicating the severity of this factor.
  ///
  /// This parameter is used to provide a more accurate consumption prediction for electric vehicles.
  ///
  /// Supported range from 0 to 1
  double rollingResistanceCoefficient;

  /// The drag coefficient of an vehicle defines the way the vehicle is expected to pass through the surrounding air.
  /// More streamlined vehicles are more aerodynamic and therefore have smaller drag coefficient.
  ///
  /// This parameter is used to provide a more accurate consumption prediction for electric vehicles.
  ///
  /// Supported range from 0 to 1
  double airDragCoefficient;

  /// Creates a new instance.

  /// [driveTrainEfficiency] The proportion of the energy drawn from the battery that is used to move the vehicle.
  /// (This is to factor in energy losses through heat in the motors, for example.)
  /// Supported range from 0 to 1

  /// [recuperationEfficiency] The proportion of the energy gained when braking or going downhill that can be recuperated and restored as battery charge.
  ///
  /// Supported range from 0 to 1

  /// [auxiliaryPowerConsumptionInWatts] Power (in W) consumed by the vehicle's auxiliary systems (for example, air conditioning, lights).
  ///
  /// Supported range from 0 to 1

  /// [frontalAreaInSquareMeters] Frontal area represents the total cross section area of the vehicle as viewed from the front, specified in square meters.
  /// Physical consumption model is using this value in combination with `airDragCoefficient` to calculate the consumption caused by air resistance.
  /// As fallback [VehicleSpecification.widthInCentimeters] and [VehicleSpecification.heightInCentimeters] are used.
  ///
  /// This parameter is used to provide a more accurate consumption prediction for electric vehicles.
  ///
  /// In the range from 0.5 to 50

  /// [rollingResistanceCoefficient] Rolling resistance refers to the resistance experienced by your vehicle tire as it rolls over a surface.
  /// The main causes of this resistance are tire deformation, wing drag, and friction with the ground.
  /// The coefficient of rolling resistance is a numerical value indicating the severity of this factor.
  ///
  /// This parameter is used to provide a more accurate consumption prediction for electric vehicles.
  ///
  /// Supported range from 0 to 1

  /// [airDragCoefficient] The drag coefficient of an vehicle defines the way the vehicle is expected to pass through the surrounding air.
  /// More streamlined vehicles are more aerodynamic and therefore have smaller drag coefficient.
  ///
  /// This parameter is used to provide a more accurate consumption prediction for electric vehicles.
  ///
  /// Supported range from 0 to 1

  PhysicalConsumptionModel._(this.driveTrainEfficiency, this.recuperationEfficiency, this.auxiliaryPowerConsumptionInWatts, this.frontalAreaInSquareMeters, this.rollingResistanceCoefficient, this.airDragCoefficient);
  PhysicalConsumptionModel()
    : driveTrainEfficiency = 0.1, recuperationEfficiency = 0.1, auxiliaryPowerConsumptionInWatts = 0.1, frontalAreaInSquareMeters = 0.5, rollingResistanceCoefficient = 0.1, airDragCoefficient = 0.1;
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PhysicalConsumptionModel) return false;
    PhysicalConsumptionModel _other = other;
    return driveTrainEfficiency == _other.driveTrainEfficiency &&
        recuperationEfficiency == _other.recuperationEfficiency &&
        auxiliaryPowerConsumptionInWatts == _other.auxiliaryPowerConsumptionInWatts &&
        frontalAreaInSquareMeters == _other.frontalAreaInSquareMeters &&
        rollingResistanceCoefficient == _other.rollingResistanceCoefficient &&
        airDragCoefficient == _other.airDragCoefficient;
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + driveTrainEfficiency.hashCode;
    result = 31 * result + recuperationEfficiency.hashCode;
    result = 31 * result + auxiliaryPowerConsumptionInWatts.hashCode;
    result = 31 * result + frontalAreaInSquareMeters.hashCode;
    result = 31 * result + rollingResistanceCoefficient.hashCode;
    result = 31 * result + airDragCoefficient.hashCode;
    return result;
  }
}


// PhysicalConsumptionModel "private" section, not exported.

final _sdkRoutingPhysicalconsumptionmodelCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Double, Double, Double, Double, Double, Double),
    Pointer<Void> Function(double, double, double, double, double, double)
  >('here_sdk_sdk_routing_PhysicalConsumptionModel_create_handle'));
final _sdkRoutingPhysicalconsumptionmodelReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_PhysicalConsumptionModel_release_handle'));
final _sdkRoutingPhysicalconsumptionmodelGetFielddriveTrainEfficiency = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Double Function(Pointer<Void>),
    double Function(Pointer<Void>)
  >('here_sdk_sdk_routing_PhysicalConsumptionModel_get_field_driveTrainEfficiency'));
final _sdkRoutingPhysicalconsumptionmodelGetFieldrecuperationEfficiency = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Double Function(Pointer<Void>),
    double Function(Pointer<Void>)
  >('here_sdk_sdk_routing_PhysicalConsumptionModel_get_field_recuperationEfficiency'));
final _sdkRoutingPhysicalconsumptionmodelGetFieldauxiliaryPowerConsumptionInWatts = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Double Function(Pointer<Void>),
    double Function(Pointer<Void>)
  >('here_sdk_sdk_routing_PhysicalConsumptionModel_get_field_auxiliaryPowerConsumptionInWatts'));
final _sdkRoutingPhysicalconsumptionmodelGetFieldfrontalAreaInSquareMeters = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Double Function(Pointer<Void>),
    double Function(Pointer<Void>)
  >('here_sdk_sdk_routing_PhysicalConsumptionModel_get_field_frontalAreaInSquareMeters'));
final _sdkRoutingPhysicalconsumptionmodelGetFieldrollingResistanceCoefficient = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Double Function(Pointer<Void>),
    double Function(Pointer<Void>)
  >('here_sdk_sdk_routing_PhysicalConsumptionModel_get_field_rollingResistanceCoefficient'));
final _sdkRoutingPhysicalconsumptionmodelGetFieldairDragCoefficient = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Double Function(Pointer<Void>),
    double Function(Pointer<Void>)
  >('here_sdk_sdk_routing_PhysicalConsumptionModel_get_field_airDragCoefficient'));



Pointer<Void> sdkRoutingPhysicalconsumptionmodelToFfi(PhysicalConsumptionModel value) {
  final _driveTrainEfficiencyHandle = (value.driveTrainEfficiency);
  final _recuperationEfficiencyHandle = (value.recuperationEfficiency);
  final _auxiliaryPowerConsumptionInWattsHandle = (value.auxiliaryPowerConsumptionInWatts);
  final _frontalAreaInSquareMetersHandle = (value.frontalAreaInSquareMeters);
  final _rollingResistanceCoefficientHandle = (value.rollingResistanceCoefficient);
  final _airDragCoefficientHandle = (value.airDragCoefficient);
  final _result = _sdkRoutingPhysicalconsumptionmodelCreateHandle(_driveTrainEfficiencyHandle, _recuperationEfficiencyHandle, _auxiliaryPowerConsumptionInWattsHandle, _frontalAreaInSquareMetersHandle, _rollingResistanceCoefficientHandle, _airDragCoefficientHandle);
  
  
  
  
  
  
  return _result;
}

PhysicalConsumptionModel sdkRoutingPhysicalconsumptionmodelFromFfi(Pointer<Void> handle) {
  final _driveTrainEfficiencyHandle = _sdkRoutingPhysicalconsumptionmodelGetFielddriveTrainEfficiency(handle);
  final _recuperationEfficiencyHandle = _sdkRoutingPhysicalconsumptionmodelGetFieldrecuperationEfficiency(handle);
  final _auxiliaryPowerConsumptionInWattsHandle = _sdkRoutingPhysicalconsumptionmodelGetFieldauxiliaryPowerConsumptionInWatts(handle);
  final _frontalAreaInSquareMetersHandle = _sdkRoutingPhysicalconsumptionmodelGetFieldfrontalAreaInSquareMeters(handle);
  final _rollingResistanceCoefficientHandle = _sdkRoutingPhysicalconsumptionmodelGetFieldrollingResistanceCoefficient(handle);
  final _airDragCoefficientHandle = _sdkRoutingPhysicalconsumptionmodelGetFieldairDragCoefficient(handle);
  try {
    return PhysicalConsumptionModel._(
      (_driveTrainEfficiencyHandle), 
      (_recuperationEfficiencyHandle), 
      (_auxiliaryPowerConsumptionInWattsHandle), 
      (_frontalAreaInSquareMetersHandle), 
      (_rollingResistanceCoefficientHandle), 
      (_airDragCoefficientHandle)
    );
  } finally {
    
    
    
    
    
    
  }
}

void sdkRoutingPhysicalconsumptionmodelReleaseFfiHandle(Pointer<Void> handle) => _sdkRoutingPhysicalconsumptionmodelReleaseHandle(handle);

// Nullable PhysicalConsumptionModel

final _sdkRoutingPhysicalconsumptionmodelCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_PhysicalConsumptionModel_create_handle_nullable'));
final _sdkRoutingPhysicalconsumptionmodelReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_PhysicalConsumptionModel_release_handle_nullable'));
final _sdkRoutingPhysicalconsumptionmodelGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_PhysicalConsumptionModel_get_value_nullable'));

Pointer<Void> sdkRoutingPhysicalconsumptionmodelToFfiNullable(PhysicalConsumptionModel? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkRoutingPhysicalconsumptionmodelToFfi(value);
  final result = _sdkRoutingPhysicalconsumptionmodelCreateHandleNullable(_handle);
  sdkRoutingPhysicalconsumptionmodelReleaseFfiHandle(_handle);
  return result;
}

PhysicalConsumptionModel? sdkRoutingPhysicalconsumptionmodelFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkRoutingPhysicalconsumptionmodelGetValueNullable(handle);
  final result = sdkRoutingPhysicalconsumptionmodelFromFfi(_handle);
  sdkRoutingPhysicalconsumptionmodelReleaseFfiHandle(_handle);
  return result;
}

void sdkRoutingPhysicalconsumptionmodelReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkRoutingPhysicalconsumptionmodelReleaseHandleNullable(handle);

// End of PhysicalConsumptionModel "private" section.


