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
import 'package:here_sdk/src/builtin_types__conversion.dart';
import 'package:here_sdk/src/sdk/routing/battery_specifications.dart';
import 'package:here_sdk/src/sdk/routing/e_v_mobility_service_provider_preferences.dart';
import 'package:here_sdk/src/sdk/routing/empirical_consumption_model.dart';
import 'package:here_sdk/src/sdk/routing/physical_consumption_model.dart';

/// These options define the parameters of the electric vehicle.
///
/// **Note:** This is a beta release of this feature, so there could be a few bugs and unexpected behaviors.
/// Related APIs may change for new releases without a deprecation process.

class ElectricVehicleOptions {
  /// Ensure that the vehicle does not run out of energy along the way.
  /// Requires valid `battery_specifications`.
  /// It also requires that
  /// [RouteOptions.optimizationMode] = [OptimizationMode.fastest],
  /// [RouteOptions.speedCapInMetersPerSecond] is not set, and
  /// [AvoidanceOptions] is empty. Otherwise, this object is considered invalid.
  /// Setting this flag enables calculation of a route optimized for electric vehicles.
  /// Charging stations may be added along the route to ensure that the vehicle does
  /// not run out of energy along the way.
  /// It is especially useful for longer routes, because after all, charging stations are much
  /// less common than petrol stations.
  ///
  /// **Note** An [RoutingError.invalidParameter] is generated when
  /// this option is set to true in case `sdk.routing.RoutingEngine.import_route` is called.
  /// Defaults to false.
  ///
  /// **Note**
  /// Routes calculated with offline routing might not reach the destination with the provided battery charge.
  /// As no charging station gets added dynamically to reach the next waypoint.
  /// In case the waypoint can not be reached a [SectionNotice] is provided.
  ///
  /// **Note**
  /// Only supported for car routing.
  bool ensureReachability;

  /// Defines the preferred E-Mobility Service Providers.
  /// The The E-Mobility Service Provider Partner Ids can be received from
  /// https://www.here.com/docs/bundle/ev-charge-points-api-developer-guide/page/topics/resource-roamings.html
  /// An alternative way to get `partnerId` is the `eMobilityServiceProviders.partnerId` as part of `HERE SDK Search`.
  /// Maximum number of E-Mobility Service Providers is limited to 10.
  /// By default, all providers are used.
  /// **Note** Not yet supported for offline routing.
  EVMobilityServiceProviderPreferences evMobilityServiceProviderPreferences;

  /// Defines the empirical consumption model.
  /// The model is used to calculate the energy consumption for the vehicle on a given route.
  /// **Note**
  /// Only one consumption model is supported per route.
  EmpiricalConsumptionModel? empiricalConsumptionModel;

  /// Defines the physical consumption model.
  /// The model is used to calculate the energy consumption for the vehicle on a given route.
  /// **Note**
  /// Only one consumption model is supported per route.
  PhysicalConsumptionModel? physicalConsumptionModel;

  /// Parameters that describe the electric vehicle's battery.
  BatterySpecifications batterySpecifications;

  /// Creates a new instance.

  /// [ensureReachability] Ensure that the vehicle does not run out of energy along the way.
  /// Requires valid `battery_specifications`.
  /// It also requires that
  /// [RouteOptions.optimizationMode] = [OptimizationMode.fastest],
  /// [RouteOptions.speedCapInMetersPerSecond] is not set, and
  /// [AvoidanceOptions] is empty. Otherwise, this object is considered invalid.
  /// Setting this flag enables calculation of a route optimized for electric vehicles.
  /// Charging stations may be added along the route to ensure that the vehicle does
  /// not run out of energy along the way.
  /// It is especially useful for longer routes, because after all, charging stations are much
  /// less common than petrol stations.
  ///
  /// **Note** An [RoutingError.invalidParameter] is generated when
  /// this option is set to true in case `sdk.routing.RoutingEngine.import_route` is called.
  /// Defaults to false.
  ///
  /// **Note**
  /// Routes calculated with offline routing might not reach the destination with the provided battery charge.
  /// As no charging station gets added dynamically to reach the next waypoint.
  /// In case the waypoint can not be reached a [SectionNotice] is provided.
  ///
  /// **Note**
  /// Only supported for car routing.

  /// [evMobilityServiceProviderPreferences] Defines the preferred E-Mobility Service Providers.
  /// The The E-Mobility Service Provider Partner Ids can be received from
  /// https://www.here.com/docs/bundle/ev-charge-points-api-developer-guide/page/topics/resource-roamings.html
  /// An alternative way to get `partnerId` is the `eMobilityServiceProviders.partnerId` as part of `HERE SDK Search`.
  /// Maximum number of E-Mobility Service Providers is limited to 10.
  /// By default, all providers are used.
  /// **Note** Not yet supported for offline routing.

  /// [empiricalConsumptionModel] Defines the empirical consumption model.
  /// The model is used to calculate the energy consumption for the vehicle on a given route.
  /// **Note**
  /// Only one consumption model is supported per route.

  /// [physicalConsumptionModel] Defines the physical consumption model.
  /// The model is used to calculate the energy consumption for the vehicle on a given route.
  /// **Note**
  /// Only one consumption model is supported per route.

  /// [batterySpecifications] Parameters that describe the electric vehicle's battery.

  ElectricVehicleOptions._(this.ensureReachability, this.evMobilityServiceProviderPreferences, this.empiricalConsumptionModel, this.physicalConsumptionModel, this.batterySpecifications);
  ElectricVehicleOptions()
    : ensureReachability = false, evMobilityServiceProviderPreferences = EVMobilityServiceProviderPreferences(), empiricalConsumptionModel = null, physicalConsumptionModel = null, batterySpecifications = BatterySpecifications.withDefaults();
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ElectricVehicleOptions) return false;
    ElectricVehicleOptions _other = other;
    return ensureReachability == _other.ensureReachability &&
        evMobilityServiceProviderPreferences == _other.evMobilityServiceProviderPreferences &&
        empiricalConsumptionModel == _other.empiricalConsumptionModel &&
        physicalConsumptionModel == _other.physicalConsumptionModel &&
        batterySpecifications == _other.batterySpecifications;
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + ensureReachability.hashCode;
    result = 31 * result + evMobilityServiceProviderPreferences.hashCode;
    result = 31 * result + empiricalConsumptionModel.hashCode;
    result = 31 * result + physicalConsumptionModel.hashCode;
    result = 31 * result + batterySpecifications.hashCode;
    return result;
  }
}


// ElectricVehicleOptions "private" section, not exported.

final _sdkRoutingElectricvehicleoptionsCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Uint8, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>),
    Pointer<Void> Function(int, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>)
  >('here_sdk_sdk_routing_ElectricVehicleOptions_create_handle'));
final _sdkRoutingElectricvehicleoptionsReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_ElectricVehicleOptions_release_handle'));
final _sdkRoutingElectricvehicleoptionsGetFieldensureReachability = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint8 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_routing_ElectricVehicleOptions_get_field_ensureReachability'));
final _sdkRoutingElectricvehicleoptionsGetFieldevMobilityServiceProviderPreferences = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_ElectricVehicleOptions_get_field_evMobilityServiceProviderPreferences'));
final _sdkRoutingElectricvehicleoptionsGetFieldempiricalConsumptionModel = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_ElectricVehicleOptions_get_field_empiricalConsumptionModel'));
final _sdkRoutingElectricvehicleoptionsGetFieldphysicalConsumptionModel = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_ElectricVehicleOptions_get_field_physicalConsumptionModel'));
final _sdkRoutingElectricvehicleoptionsGetFieldbatterySpecifications = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_ElectricVehicleOptions_get_field_batterySpecifications'));



Pointer<Void> sdkRoutingElectricvehicleoptionsToFfi(ElectricVehicleOptions value) {
  final _ensureReachabilityHandle = booleanToFfi(value.ensureReachability);
  final _evMobilityServiceProviderPreferencesHandle = sdkRoutingEvmobilityserviceproviderpreferencesToFfi(value.evMobilityServiceProviderPreferences);
  final _empiricalConsumptionModelHandle = sdkRoutingEmpiricalconsumptionmodelToFfiNullable(value.empiricalConsumptionModel);
  final _physicalConsumptionModelHandle = sdkRoutingPhysicalconsumptionmodelToFfiNullable(value.physicalConsumptionModel);
  final _batterySpecificationsHandle = sdkRoutingBatteryspecificationsToFfi(value.batterySpecifications);
  final _result = _sdkRoutingElectricvehicleoptionsCreateHandle(_ensureReachabilityHandle, _evMobilityServiceProviderPreferencesHandle, _empiricalConsumptionModelHandle, _physicalConsumptionModelHandle, _batterySpecificationsHandle);
  booleanReleaseFfiHandle(_ensureReachabilityHandle);
  sdkRoutingEvmobilityserviceproviderpreferencesReleaseFfiHandle(_evMobilityServiceProviderPreferencesHandle);
  sdkRoutingEmpiricalconsumptionmodelReleaseFfiHandleNullable(_empiricalConsumptionModelHandle);
  sdkRoutingPhysicalconsumptionmodelReleaseFfiHandleNullable(_physicalConsumptionModelHandle);
  sdkRoutingBatteryspecificationsReleaseFfiHandle(_batterySpecificationsHandle);
  return _result;
}

ElectricVehicleOptions sdkRoutingElectricvehicleoptionsFromFfi(Pointer<Void> handle) {
  final _ensureReachabilityHandle = _sdkRoutingElectricvehicleoptionsGetFieldensureReachability(handle);
  final _evMobilityServiceProviderPreferencesHandle = _sdkRoutingElectricvehicleoptionsGetFieldevMobilityServiceProviderPreferences(handle);
  final _empiricalConsumptionModelHandle = _sdkRoutingElectricvehicleoptionsGetFieldempiricalConsumptionModel(handle);
  final _physicalConsumptionModelHandle = _sdkRoutingElectricvehicleoptionsGetFieldphysicalConsumptionModel(handle);
  final _batterySpecificationsHandle = _sdkRoutingElectricvehicleoptionsGetFieldbatterySpecifications(handle);
  try {
    return ElectricVehicleOptions._(
      booleanFromFfi(_ensureReachabilityHandle), 
      sdkRoutingEvmobilityserviceproviderpreferencesFromFfi(_evMobilityServiceProviderPreferencesHandle), 
      sdkRoutingEmpiricalconsumptionmodelFromFfiNullable(_empiricalConsumptionModelHandle), 
      sdkRoutingPhysicalconsumptionmodelFromFfiNullable(_physicalConsumptionModelHandle), 
      sdkRoutingBatteryspecificationsFromFfi(_batterySpecificationsHandle)
    );
  } finally {
    booleanReleaseFfiHandle(_ensureReachabilityHandle);
    sdkRoutingEvmobilityserviceproviderpreferencesReleaseFfiHandle(_evMobilityServiceProviderPreferencesHandle);
    sdkRoutingEmpiricalconsumptionmodelReleaseFfiHandleNullable(_empiricalConsumptionModelHandle);
    sdkRoutingPhysicalconsumptionmodelReleaseFfiHandleNullable(_physicalConsumptionModelHandle);
    sdkRoutingBatteryspecificationsReleaseFfiHandle(_batterySpecificationsHandle);
  }
}

void sdkRoutingElectricvehicleoptionsReleaseFfiHandle(Pointer<Void> handle) => _sdkRoutingElectricvehicleoptionsReleaseHandle(handle);

// Nullable ElectricVehicleOptions

final _sdkRoutingElectricvehicleoptionsCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_ElectricVehicleOptions_create_handle_nullable'));
final _sdkRoutingElectricvehicleoptionsReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_ElectricVehicleOptions_release_handle_nullable'));
final _sdkRoutingElectricvehicleoptionsGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_ElectricVehicleOptions_get_value_nullable'));

Pointer<Void> sdkRoutingElectricvehicleoptionsToFfiNullable(ElectricVehicleOptions? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkRoutingElectricvehicleoptionsToFfi(value);
  final result = _sdkRoutingElectricvehicleoptionsCreateHandleNullable(_handle);
  sdkRoutingElectricvehicleoptionsReleaseFfiHandle(_handle);
  return result;
}

ElectricVehicleOptions? sdkRoutingElectricvehicleoptionsFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkRoutingElectricvehicleoptionsGetValueNullable(handle);
  final result = sdkRoutingElectricvehicleoptionsFromFfi(_handle);
  sdkRoutingElectricvehicleoptionsReleaseFfiHandle(_handle);
  return result;
}

void sdkRoutingElectricvehicleoptionsReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkRoutingElectricvehicleoptionsReleaseHandleNullable(handle);

// End of ElectricVehicleOptions "private" section.


