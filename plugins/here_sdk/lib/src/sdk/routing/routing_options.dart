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
import 'package:here_sdk/src/sdk/routing/common_route_options.dart';
import 'package:here_sdk/src/sdk/routing/electric_vehicle_options.dart';
import 'package:here_sdk/src/sdk/routing/transported_cargo.dart';
import 'package:here_sdk/src/sdk/routing/vehicle_specification.dart';
import 'package:here_sdk/src/sdk/transport/transport_mode.dart';

/// The options defines how a route should be calculated.
///
/// The options are used for all transport modes and engines.
///
/// ** Electric vehicle specific requirements **
/// Electric vehicle consumption are estimated when at least one consumption model is defined.
/// Currently two models are supported:
/// - PhysicalConsumptionModel
///   Aside from the values in PhysicalConsumptionModel additionally those values needs to be defined
///
///   - [TransportedCargo.currentWeightInKilograms]
/// - EmpiricalConsumptionModel
///
/// By setting [ElectricVehicleOptions.ensureReachability] the `RoutingEngine` inserts additional charging stations to reach the waypoints.
/// This feature requires setting the [BatterySpecifications].
/// By default a vehicle might not reach the waypoint, when the initial charge is not enough to reach all waypoints.
/// See the parameter description below for more details.
///
/// ** Note **
/// The optional parameters are mainly optional for the pedestrian transport mode.
/// It is highly recommended to set [RoutingOptions.vehicle] and [RoutingOptions.transportedCargo] when the values are known.
/// **Note:** This is a beta release of this feature, so there could be a few bugs and unexpected behaviors.
/// Related APIs may change for new releases without a deprecation process.

class RoutingOptions {
  /// Defines the transport mode
  TransportMode transportMode;

  /// Specifies the number of occupants in the vehicle, including driver,
  /// can affect the vehicle's ability to use HOV/carpool restricted lanes.
  /// Shouldn't be less than 1 or greater than 255. Defaults to 1.
  ///
  /// **Note:** This parameter won't have effect if HOV and/or HOT lane usage is not allowed using [EVTruckOptions.allowOptions]
  int occupantsNumber;

  /// Defines the common route options.
  CommonRouteOptions commonRouteOptions;

  /// Defines the vehicle.
  /// By default a generic vehicle for the transport mode is used.
  /// It highly recommended to define the truck that is used.
  VehicleSpecification? vehicle;

  /// Defines the ev related parameters to calculate the consumption and reachability.
  /// When no ev options are defined a internal combustion engine is assumed.
  ElectricVehicleOptions? evOptions;

  /// Defines the transported cargo.
  /// The weight is used for restrictions and consumption prediction for electronic vehicles.
  TransportedCargo? transportedCargo;

  /// Specifies the speed that will be used by the service as the walking speed
  /// for pedestrian routing in meters per second. It influences the duration of
  /// walking segments along the route. The provided value must be in the range
  /// \[0.5, 2.0\]. When the value is outside this range, an invalid parameter
  /// error is raised. Refer to [RoutingError] for details. The default
  /// speed is 1 meter per second.
  double walkSpeedInMetersPerSecond;

  /// Creates a new instance.

  /// [transportMode] Defines the transport mode

  /// [occupantsNumber] Specifies the number of occupants in the vehicle, including driver,
  /// can affect the vehicle's ability to use HOV/carpool restricted lanes.
  /// Shouldn't be less than 1 or greater than 255. Defaults to 1.
  ///
  /// **Note:** This parameter won't have effect if HOV and/or HOT lane usage is not allowed using [EVTruckOptions.allowOptions]

  /// [commonRouteOptions] Defines the common route options.

  /// [vehicle] Defines the vehicle.
  /// By default a generic vehicle for the transport mode is used.
  /// It highly recommended to define the truck that is used.

  /// [evOptions] Defines the ev related parameters to calculate the consumption and reachability.
  /// When no ev options are defined a internal combustion engine is assumed.

  /// [transportedCargo] Defines the transported cargo.
  /// The weight is used for restrictions and consumption prediction for electronic vehicles.

  /// [walkSpeedInMetersPerSecond] Specifies the speed that will be used by the service as the walking speed
  /// for pedestrian routing in meters per second. It influences the duration of
  /// walking segments along the route. The provided value must be in the range
  /// \[0.5, 2.0\]. When the value is outside this range, an invalid parameter
  /// error is raised. Refer to [RoutingError] for details. The default
  /// speed is 1 meter per second.

  RoutingOptions._(this.transportMode, this.occupantsNumber, this.commonRouteOptions, this.vehicle, this.evOptions, this.transportedCargo, this.walkSpeedInMetersPerSecond);
  RoutingOptions()
    : transportMode = TransportMode.car, occupantsNumber = 1, commonRouteOptions = CommonRouteOptions(), vehicle = null, evOptions = null, transportedCargo = null, walkSpeedInMetersPerSecond = 1.0;
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RoutingOptions) return false;
    RoutingOptions _other = other;
    return transportMode == _other.transportMode &&
        occupantsNumber == _other.occupantsNumber &&
        commonRouteOptions == _other.commonRouteOptions &&
        vehicle == _other.vehicle &&
        evOptions == _other.evOptions &&
        transportedCargo == _other.transportedCargo &&
        walkSpeedInMetersPerSecond == _other.walkSpeedInMetersPerSecond;
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + transportMode.hashCode;
    result = 31 * result + occupantsNumber.hashCode;
    result = 31 * result + commonRouteOptions.hashCode;
    result = 31 * result + vehicle.hashCode;
    result = 31 * result + evOptions.hashCode;
    result = 31 * result + transportedCargo.hashCode;
    result = 31 * result + walkSpeedInMetersPerSecond.hashCode;
    return result;
  }
}


// RoutingOptions "private" section, not exported.

final _sdkRoutingRoutingoptionsCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Uint32, Int32, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Double),
    Pointer<Void> Function(int, int, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, double)
  >('here_sdk_sdk_routing_RoutingOptions_create_handle'));
final _sdkRoutingRoutingoptionsReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_RoutingOptions_release_handle'));
final _sdkRoutingRoutingoptionsGetFieldtransportMode = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_routing_RoutingOptions_get_field_transportMode'));
final _sdkRoutingRoutingoptionsGetFieldoccupantsNumber = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Int32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_routing_RoutingOptions_get_field_occupantsNumber'));
final _sdkRoutingRoutingoptionsGetFieldcommonRouteOptions = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_RoutingOptions_get_field_commonRouteOptions'));
final _sdkRoutingRoutingoptionsGetFieldvehicle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_RoutingOptions_get_field_vehicle'));
final _sdkRoutingRoutingoptionsGetFieldevOptions = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_RoutingOptions_get_field_evOptions'));
final _sdkRoutingRoutingoptionsGetFieldtransportedCargo = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_RoutingOptions_get_field_transportedCargo'));
final _sdkRoutingRoutingoptionsGetFieldwalkSpeedInMetersPerSecond = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Double Function(Pointer<Void>),
    double Function(Pointer<Void>)
  >('here_sdk_sdk_routing_RoutingOptions_get_field_walkSpeedInMetersPerSecond'));



Pointer<Void> sdkRoutingRoutingoptionsToFfi(RoutingOptions value) {
  final _transportModeHandle = sdkTransportTransportmodeToFfi(value.transportMode);
  final _occupantsNumberHandle = (value.occupantsNumber);
  final _commonRouteOptionsHandle = sdkRoutingCommonrouteoptionsToFfi(value.commonRouteOptions);
  final _vehicleHandle = sdkRoutingVehiclespecificationToFfiNullable(value.vehicle);
  final _evOptionsHandle = sdkRoutingElectricvehicleoptionsToFfiNullable(value.evOptions);
  final _transportedCargoHandle = sdkRoutingTransportedcargoToFfiNullable(value.transportedCargo);
  final _walkSpeedInMetersPerSecondHandle = (value.walkSpeedInMetersPerSecond);
  final _result = _sdkRoutingRoutingoptionsCreateHandle(_transportModeHandle, _occupantsNumberHandle, _commonRouteOptionsHandle, _vehicleHandle, _evOptionsHandle, _transportedCargoHandle, _walkSpeedInMetersPerSecondHandle);
  sdkTransportTransportmodeReleaseFfiHandle(_transportModeHandle);
  
  sdkRoutingCommonrouteoptionsReleaseFfiHandle(_commonRouteOptionsHandle);
  sdkRoutingVehiclespecificationReleaseFfiHandleNullable(_vehicleHandle);
  sdkRoutingElectricvehicleoptionsReleaseFfiHandleNullable(_evOptionsHandle);
  sdkRoutingTransportedcargoReleaseFfiHandleNullable(_transportedCargoHandle);
  
  return _result;
}

RoutingOptions sdkRoutingRoutingoptionsFromFfi(Pointer<Void> handle) {
  final _transportModeHandle = _sdkRoutingRoutingoptionsGetFieldtransportMode(handle);
  final _occupantsNumberHandle = _sdkRoutingRoutingoptionsGetFieldoccupantsNumber(handle);
  final _commonRouteOptionsHandle = _sdkRoutingRoutingoptionsGetFieldcommonRouteOptions(handle);
  final _vehicleHandle = _sdkRoutingRoutingoptionsGetFieldvehicle(handle);
  final _evOptionsHandle = _sdkRoutingRoutingoptionsGetFieldevOptions(handle);
  final _transportedCargoHandle = _sdkRoutingRoutingoptionsGetFieldtransportedCargo(handle);
  final _walkSpeedInMetersPerSecondHandle = _sdkRoutingRoutingoptionsGetFieldwalkSpeedInMetersPerSecond(handle);
  try {
    return RoutingOptions._(
      sdkTransportTransportmodeFromFfi(_transportModeHandle), 
      (_occupantsNumberHandle), 
      sdkRoutingCommonrouteoptionsFromFfi(_commonRouteOptionsHandle), 
      sdkRoutingVehiclespecificationFromFfiNullable(_vehicleHandle), 
      sdkRoutingElectricvehicleoptionsFromFfiNullable(_evOptionsHandle), 
      sdkRoutingTransportedcargoFromFfiNullable(_transportedCargoHandle), 
      (_walkSpeedInMetersPerSecondHandle)
    );
  } finally {
    sdkTransportTransportmodeReleaseFfiHandle(_transportModeHandle);
    
    sdkRoutingCommonrouteoptionsReleaseFfiHandle(_commonRouteOptionsHandle);
    sdkRoutingVehiclespecificationReleaseFfiHandleNullable(_vehicleHandle);
    sdkRoutingElectricvehicleoptionsReleaseFfiHandleNullable(_evOptionsHandle);
    sdkRoutingTransportedcargoReleaseFfiHandleNullable(_transportedCargoHandle);
    
  }
}

void sdkRoutingRoutingoptionsReleaseFfiHandle(Pointer<Void> handle) => _sdkRoutingRoutingoptionsReleaseHandle(handle);

// Nullable RoutingOptions

final _sdkRoutingRoutingoptionsCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_RoutingOptions_create_handle_nullable'));
final _sdkRoutingRoutingoptionsReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_RoutingOptions_release_handle_nullable'));
final _sdkRoutingRoutingoptionsGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_RoutingOptions_get_value_nullable'));

Pointer<Void> sdkRoutingRoutingoptionsToFfiNullable(RoutingOptions? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkRoutingRoutingoptionsToFfi(value);
  final result = _sdkRoutingRoutingoptionsCreateHandleNullable(_handle);
  sdkRoutingRoutingoptionsReleaseFfiHandle(_handle);
  return result;
}

RoutingOptions? sdkRoutingRoutingoptionsFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkRoutingRoutingoptionsGetValueNullable(handle);
  final result = sdkRoutingRoutingoptionsFromFfi(_handle);
  sdkRoutingRoutingoptionsReleaseFfiHandle(_handle);
  return result;
}

void sdkRoutingRoutingoptionsReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkRoutingRoutingoptionsReleaseHandleNullable(handle);

// End of RoutingOptions "private" section.


