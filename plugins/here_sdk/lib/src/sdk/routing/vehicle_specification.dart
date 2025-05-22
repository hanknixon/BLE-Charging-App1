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
import 'package:here_sdk/src/sdk/transport/truck_type.dart';

/// The specification specifies the used vehicle.
///
/// It is recommended to define the values for truck related restrictions.
///
/// **Note:** This is a beta release of this feature, so there could be a few bugs and unexpected behaviors.
/// Related APIs may change for new releases without a deprecation process.

class VehicleSpecification {
  /// Truck height in centimeters. The provided value must be in the range \[0, 5000\].
  /// By default, it is not set.
  int? heightInCentimeters;

  /// Truck width in centimeters. The provided value must be in the range \[0, 5000\].
  /// By default, it is not set.
  int? widthInCentimeters;

  /// Truck length in centimeters. The provided value must be in the range \[0, 30000\].
  /// By default, it is not set.
  int? lengthInCentimeters;

  /// Defines total number of axles in the vehicle. The provided value must be greater than or
  /// equal to 2. By default, it is not set.
  /// Route calculation: When not set, possible axle count restrictions will not be
  /// taken into consideration.
  /// Rendering `sdk.mapview.TruckProfile`: When set, truck restriction icons for an axle count
  /// greater than [VehicleSpecification.axleCount] will not be displayed.
  /// When specifying [VehicleSpecification.trailerAxleCount], then [VehicleSpecification.axleCount] is required and must be greater than [VehicleSpecification.trailerAxleCount].
  int? axleCount;

  /// Defines number of trailers attached to the vehicle. The provided value must be in the range
  /// \[0, 255\]. By default, it is not set.
  /// When specifying [VehicleSpecification.trailerAxleCount], then [VehicleSpecification.trailerCount] is required and must be greater than 0.
  int? trailerCount;

  /// Defines the type of truck. By default, it is [TruckType.straight].
  /// Rendering `sdk.mapview.TruckProfile`: [VehicleSpecification.truckType] is ignored and has no effect.
  TruckType truckType;

  /// A flag indicating whether the truck is light enough to be classified more as a car than a truck in Japan.
  /// The flag should not be set to true in other countries than Japan. The flag defaults to false.
  ///
  /// A light truck exempts from many legal restrictions for normal trucks in Japan, for example, which streets
  /// the vehicle can access, which access restrictions apply, and which speed limits are applicable.
  /// Restrictions related to the dimensions of the truck, or its cargo may still apply and setting this flag will
  /// not always overwrite these settings: Make sure to not exceed the specifications that classify a truck as light.
  ///
  /// In Japan, for light trucks the same restrictions apply as for cars. Therefore, when the flag is set to true,
  /// you will get, for example, the same speed limits as for cars. Make sure to set the flag only to true, when
  /// a vehicle matches the classification for light trucks according to the vehicle regulations in Japan.
  ///
  /// When `TruckSpecifications` are set as part of `MapContentSettings`, then this flag will be ignored and
  /// has no effect.
  ///
  /// **Note:**
  /// This flag and the concept of light trucks are supported only in Japan as beta and are considered to be
  /// experimental in other regions. Therefore, for now, it is recommended to use this flag only in Japan.
  /// Note that this is a beta release of this feature, so there could be a few bugs and unexpected behaviors.
  /// Related APIs may change for new releases with a deprecation process.
  bool isTruckLight;

  /// Specifies whether the vehicle is a commercial or a non-commercial vehicle.
  ///
  /// **Note**
  /// Only supported for online routing.
  /// **Note**
  /// This parameter is currently used only for the calculation of tolls in regions where it is applicable.
  /// Supported for `car`, `truck`, `bus`, `privateBus` and `taxi`.
  /// **Note**
  /// Not used for offline calculations.
  bool isCommercial;

  /// Allowed payload capacity, including trailers, specified in kilograms. The provided value
  /// must be greater then or equal to 0. By default, it is not set.
  int? payloadCapacityInKilograms;

  /// Defines total number of axles across all the trailers attached to the vehicle.
  /// This number is included in [VehicleSpecification.axleCount], hence [VehicleSpecification.trailerAxleCount] must be less than [VehicleSpecification.axleCount]
  /// and greater than or equal to 1. [VehicleSpecification.axleCount] and [VehicleSpecification.trailerCount] are required to specify [VehicleSpecification.trailerAxleCount].
  /// By default, it is not set.
  /// Note: This parameter is currently used only for the calculation of tolls in regions where it is applicable.
  /// **Note**
  /// Not used for offline calculations.
  int? trailerAxleCount;

  /// Last character of license plate in String format. This value can be used to
  /// evaluate restrictions in environmental zones.
  /// By default, it is not set.
  String? lastCharacterOfLicensePlate;

  /// Specifies if a vehicle is allowed to drive through the taxi-only roads and lanes.
  /// When set to `false`, it is still allowed on taxi roads after the route start and
  /// before the route destination.
  bool allowDriveThroughTaxiRoads;

  /// Specifies whether scooter is allowed on highway or not. True means scooter is
  /// allowed to use highways and false means otherwise. By default it is set to false.
  /// Note that there is a similar parameter in [AvoidanceOptions], to
  /// disallow highway usage, see [RoadFeatures.controlledAccessHighway].
  /// As the avoidance options takes precedence, if this parameter is also used, then
  /// scooters are not allowed to use highways even if `allowHighway` is set to true.
  /// However, if no alternative route is possible, the calculated route may use highways.
  /// In such a case, a [SectionNotice] will be provided in the related [Section]
  /// to indicate that the highway usage restriction is violated on this route.
  /// A few examples:
  ///
  /// 1 - If no avoidance option is set, and `allowHighway = false`, when no route is found without
  /// highway usage, a notice is received.
  ///
  /// 2 - If no avoidance option is set, and `allowHighway = true`, when no route is found without
  /// highway usage, no notice is received.
  ///
  /// 3 - If only `avoid[features] = controlledAccessHighway` is set, when no route is found without
  /// highway usage, a notice is received.
  ///
  /// 4 - If both `avoid[features] = controlledAccessHighway` and `allowHighway = true` are set,
  /// when no route is found without highway usage, a notice is received.
  bool allowScooterOnHighway;

  /// Engine size of the scooter in cubic centimeters. Shouldn't be less than 1 or greater than 65535. Default value
  /// is `null`, which means the scooter route calculation ignores all engine size limits on the road.
  ///
  /// **Note:** For now, this option is only relevant in Japan and will be ignored
  /// for other countries. Currently, map data for this option is only available
  /// for Japan.
  int? engineSizeInCubicCentimeters;

  /// Creates a new instance.

  /// [heightInCentimeters] Truck height in centimeters. The provided value must be in the range \[0, 5000\].
  /// By default, it is not set.

  /// [widthInCentimeters] Truck width in centimeters. The provided value must be in the range \[0, 5000\].
  /// By default, it is not set.

  /// [lengthInCentimeters] Truck length in centimeters. The provided value must be in the range \[0, 30000\].
  /// By default, it is not set.

  /// [axleCount] Defines total number of axles in the vehicle. The provided value must be greater than or
  /// equal to 2. By default, it is not set.
  /// Route calculation: When not set, possible axle count restrictions will not be
  /// taken into consideration.
  /// Rendering `sdk.mapview.TruckProfile`: When set, truck restriction icons for an axle count
  /// greater than [VehicleSpecification.axleCount] will not be displayed.
  /// When specifying [VehicleSpecification.trailerAxleCount], then [VehicleSpecification.axleCount] is required and must be greater than [VehicleSpecification.trailerAxleCount].

  /// [trailerCount] Defines number of trailers attached to the vehicle. The provided value must be in the range
  /// \[0, 255\]. By default, it is not set.
  /// When specifying [VehicleSpecification.trailerAxleCount], then [VehicleSpecification.trailerCount] is required and must be greater than 0.

  /// [truckType] Defines the type of truck. By default, it is [TruckType.straight].
  /// Rendering `sdk.mapview.TruckProfile`: [VehicleSpecification.truckType] is ignored and has no effect.

  /// [isTruckLight] A flag indicating whether the truck is light enough to be classified more as a car than a truck in Japan.
  /// The flag should not be set to true in other countries than Japan. The flag defaults to false.
  ///
  /// A light truck exempts from many legal restrictions for normal trucks in Japan, for example, which streets
  /// the vehicle can access, which access restrictions apply, and which speed limits are applicable.
  /// Restrictions related to the dimensions of the truck, or its cargo may still apply and setting this flag will
  /// not always overwrite these settings: Make sure to not exceed the specifications that classify a truck as light.
  ///
  /// In Japan, for light trucks the same restrictions apply as for cars. Therefore, when the flag is set to true,
  /// you will get, for example, the same speed limits as for cars. Make sure to set the flag only to true, when
  /// a vehicle matches the classification for light trucks according to the vehicle regulations in Japan.
  ///
  /// When `TruckSpecifications` are set as part of `MapContentSettings`, then this flag will be ignored and
  /// has no effect.
  ///
  /// **Note:**
  /// This flag and the concept of light trucks are supported only in Japan as beta and are considered to be
  /// experimental in other regions. Therefore, for now, it is recommended to use this flag only in Japan.
  /// Note that this is a beta release of this feature, so there could be a few bugs and unexpected behaviors.
  /// Related APIs may change for new releases with a deprecation process.

  /// [isCommercial] Specifies whether the vehicle is a commercial or a non-commercial vehicle.
  ///
  /// **Note**
  /// Only supported for online routing.
  /// **Note**
  /// This parameter is currently used only for the calculation of tolls in regions where it is applicable.
  /// Supported for `car`, `truck`, `bus`, `privateBus` and `taxi`.
  /// **Note**
  /// Not used for offline calculations.

  /// [payloadCapacityInKilograms] Allowed payload capacity, including trailers, specified in kilograms. The provided value
  /// must be greater then or equal to 0. By default, it is not set.

  /// [trailerAxleCount] Defines total number of axles across all the trailers attached to the vehicle.
  /// This number is included in [VehicleSpecification.axleCount], hence [VehicleSpecification.trailerAxleCount] must be less than [VehicleSpecification.axleCount]
  /// and greater than or equal to 1. [VehicleSpecification.axleCount] and [VehicleSpecification.trailerCount] are required to specify [VehicleSpecification.trailerAxleCount].
  /// By default, it is not set.
  /// Note: This parameter is currently used only for the calculation of tolls in regions where it is applicable.
  /// **Note**
  /// Not used for offline calculations.

  /// [lastCharacterOfLicensePlate] Last character of license plate in String format. This value can be used to
  /// evaluate restrictions in environmental zones.
  /// By default, it is not set.

  /// [allowDriveThroughTaxiRoads] Specifies if a vehicle is allowed to drive through the taxi-only roads and lanes.
  /// When set to `false`, it is still allowed on taxi roads after the route start and
  /// before the route destination.

  /// [allowScooterOnHighway] Specifies whether scooter is allowed on highway or not. True means scooter is
  /// allowed to use highways and false means otherwise. By default it is set to false.
  /// Note that there is a similar parameter in [AvoidanceOptions], to
  /// disallow highway usage, see [RoadFeatures.controlledAccessHighway].
  /// As the avoidance options takes precedence, if this parameter is also used, then
  /// scooters are not allowed to use highways even if `allowHighway` is set to true.
  /// However, if no alternative route is possible, the calculated route may use highways.
  /// In such a case, a [SectionNotice] will be provided in the related [Section]
  /// to indicate that the highway usage restriction is violated on this route.
  /// A few examples:
  ///
  /// 1 - If no avoidance option is set, and `allowHighway = false`, when no route is found without
  /// highway usage, a notice is received.
  ///
  /// 2 - If no avoidance option is set, and `allowHighway = true`, when no route is found without
  /// highway usage, no notice is received.
  ///
  /// 3 - If only `avoid[features] = controlledAccessHighway` is set, when no route is found without
  /// highway usage, a notice is received.
  ///
  /// 4 - If both `avoid[features] = controlledAccessHighway` and `allowHighway = true` are set,
  /// when no route is found without highway usage, a notice is received.

  /// [engineSizeInCubicCentimeters] Engine size of the scooter in cubic centimeters. Shouldn't be less than 1 or greater than 65535. Default value
  /// is `null`, which means the scooter route calculation ignores all engine size limits on the road.
  ///
  /// **Note:** For now, this option is only relevant in Japan and will be ignored
  /// for other countries. Currently, map data for this option is only available
  /// for Japan.

  VehicleSpecification._(this.heightInCentimeters, this.widthInCentimeters, this.lengthInCentimeters, this.axleCount, this.trailerCount, this.truckType, this.isTruckLight, this.isCommercial, this.payloadCapacityInKilograms, this.trailerAxleCount, this.lastCharacterOfLicensePlate, this.allowDriveThroughTaxiRoads, this.allowScooterOnHighway, this.engineSizeInCubicCentimeters);
  VehicleSpecification()
    : heightInCentimeters = null, widthInCentimeters = null, lengthInCentimeters = null, axleCount = null, trailerCount = null, truckType = TruckType.straight, isTruckLight = false, isCommercial = false, payloadCapacityInKilograms = null, trailerAxleCount = null, lastCharacterOfLicensePlate = null, allowDriveThroughTaxiRoads = true, allowScooterOnHighway = false, engineSizeInCubicCentimeters = null;
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VehicleSpecification) return false;
    VehicleSpecification _other = other;
    return heightInCentimeters == _other.heightInCentimeters &&
        widthInCentimeters == _other.widthInCentimeters &&
        lengthInCentimeters == _other.lengthInCentimeters &&
        axleCount == _other.axleCount &&
        trailerCount == _other.trailerCount &&
        truckType == _other.truckType &&
        isTruckLight == _other.isTruckLight &&
        isCommercial == _other.isCommercial &&
        payloadCapacityInKilograms == _other.payloadCapacityInKilograms &&
        trailerAxleCount == _other.trailerAxleCount &&
        lastCharacterOfLicensePlate == _other.lastCharacterOfLicensePlate &&
        allowDriveThroughTaxiRoads == _other.allowDriveThroughTaxiRoads &&
        allowScooterOnHighway == _other.allowScooterOnHighway &&
        engineSizeInCubicCentimeters == _other.engineSizeInCubicCentimeters;
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + heightInCentimeters.hashCode;
    result = 31 * result + widthInCentimeters.hashCode;
    result = 31 * result + lengthInCentimeters.hashCode;
    result = 31 * result + axleCount.hashCode;
    result = 31 * result + trailerCount.hashCode;
    result = 31 * result + truckType.hashCode;
    result = 31 * result + isTruckLight.hashCode;
    result = 31 * result + isCommercial.hashCode;
    result = 31 * result + payloadCapacityInKilograms.hashCode;
    result = 31 * result + trailerAxleCount.hashCode;
    result = 31 * result + lastCharacterOfLicensePlate.hashCode;
    result = 31 * result + allowDriveThroughTaxiRoads.hashCode;
    result = 31 * result + allowScooterOnHighway.hashCode;
    result = 31 * result + engineSizeInCubicCentimeters.hashCode;
    return result;
  }
}


// VehicleSpecification "private" section, not exported.

final _sdkRoutingVehiclespecificationCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Uint32, Uint8, Uint8, Pointer<Void>, Pointer<Void>, Pointer<Void>, Uint8, Uint8, Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, int, int, int, Pointer<Void>, Pointer<Void>, Pointer<Void>, int, int, Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleSpecification_create_handle'));
final _sdkRoutingVehiclespecificationReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleSpecification_release_handle'));
final _sdkRoutingVehiclespecificationGetFieldheightInCentimeters = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleSpecification_get_field_heightInCentimeters'));
final _sdkRoutingVehiclespecificationGetFieldwidthInCentimeters = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleSpecification_get_field_widthInCentimeters'));
final _sdkRoutingVehiclespecificationGetFieldlengthInCentimeters = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleSpecification_get_field_lengthInCentimeters'));
final _sdkRoutingVehiclespecificationGetFieldaxleCount = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleSpecification_get_field_axleCount'));
final _sdkRoutingVehiclespecificationGetFieldtrailerCount = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleSpecification_get_field_trailerCount'));
final _sdkRoutingVehiclespecificationGetFieldtruckType = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleSpecification_get_field_truckType'));
final _sdkRoutingVehiclespecificationGetFieldisTruckLight = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint8 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleSpecification_get_field_isTruckLight'));
final _sdkRoutingVehiclespecificationGetFieldisCommercial = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint8 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleSpecification_get_field_isCommercial'));
final _sdkRoutingVehiclespecificationGetFieldpayloadCapacityInKilograms = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleSpecification_get_field_payloadCapacityInKilograms'));
final _sdkRoutingVehiclespecificationGetFieldtrailerAxleCount = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleSpecification_get_field_trailerAxleCount'));
final _sdkRoutingVehiclespecificationGetFieldlastCharacterOfLicensePlate = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleSpecification_get_field_lastCharacterOfLicensePlate'));
final _sdkRoutingVehiclespecificationGetFieldallowDriveThroughTaxiRoads = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint8 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleSpecification_get_field_allowDriveThroughTaxiRoads'));
final _sdkRoutingVehiclespecificationGetFieldallowScooterOnHighway = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint8 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleSpecification_get_field_allowScooterOnHighway'));
final _sdkRoutingVehiclespecificationGetFieldengineSizeInCubicCentimeters = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleSpecification_get_field_engineSizeInCubicCentimeters'));



Pointer<Void> sdkRoutingVehiclespecificationToFfi(VehicleSpecification value) {
  final _heightInCentimetersHandle = intToFfiNullable(value.heightInCentimeters);
  final _widthInCentimetersHandle = intToFfiNullable(value.widthInCentimeters);
  final _lengthInCentimetersHandle = intToFfiNullable(value.lengthInCentimeters);
  final _axleCountHandle = intToFfiNullable(value.axleCount);
  final _trailerCountHandle = intToFfiNullable(value.trailerCount);
  final _truckTypeHandle = sdkTransportTrucktypeToFfi(value.truckType);
  final _isTruckLightHandle = booleanToFfi(value.isTruckLight);
  final _isCommercialHandle = booleanToFfi(value.isCommercial);
  final _payloadCapacityInKilogramsHandle = intToFfiNullable(value.payloadCapacityInKilograms);
  final _trailerAxleCountHandle = intToFfiNullable(value.trailerAxleCount);
  final _lastCharacterOfLicensePlateHandle = stringToFfiNullable(value.lastCharacterOfLicensePlate);
  final _allowDriveThroughTaxiRoadsHandle = booleanToFfi(value.allowDriveThroughTaxiRoads);
  final _allowScooterOnHighwayHandle = booleanToFfi(value.allowScooterOnHighway);
  final _engineSizeInCubicCentimetersHandle = intToFfiNullable(value.engineSizeInCubicCentimeters);
  final _result = _sdkRoutingVehiclespecificationCreateHandle(_heightInCentimetersHandle, _widthInCentimetersHandle, _lengthInCentimetersHandle, _axleCountHandle, _trailerCountHandle, _truckTypeHandle, _isTruckLightHandle, _isCommercialHandle, _payloadCapacityInKilogramsHandle, _trailerAxleCountHandle, _lastCharacterOfLicensePlateHandle, _allowDriveThroughTaxiRoadsHandle, _allowScooterOnHighwayHandle, _engineSizeInCubicCentimetersHandle);
  intReleaseFfiHandleNullable(_heightInCentimetersHandle);
  intReleaseFfiHandleNullable(_widthInCentimetersHandle);
  intReleaseFfiHandleNullable(_lengthInCentimetersHandle);
  intReleaseFfiHandleNullable(_axleCountHandle);
  intReleaseFfiHandleNullable(_trailerCountHandle);
  sdkTransportTrucktypeReleaseFfiHandle(_truckTypeHandle);
  booleanReleaseFfiHandle(_isTruckLightHandle);
  booleanReleaseFfiHandle(_isCommercialHandle);
  intReleaseFfiHandleNullable(_payloadCapacityInKilogramsHandle);
  intReleaseFfiHandleNullable(_trailerAxleCountHandle);
  stringReleaseFfiHandleNullable(_lastCharacterOfLicensePlateHandle);
  booleanReleaseFfiHandle(_allowDriveThroughTaxiRoadsHandle);
  booleanReleaseFfiHandle(_allowScooterOnHighwayHandle);
  intReleaseFfiHandleNullable(_engineSizeInCubicCentimetersHandle);
  return _result;
}

VehicleSpecification sdkRoutingVehiclespecificationFromFfi(Pointer<Void> handle) {
  final _heightInCentimetersHandle = _sdkRoutingVehiclespecificationGetFieldheightInCentimeters(handle);
  final _widthInCentimetersHandle = _sdkRoutingVehiclespecificationGetFieldwidthInCentimeters(handle);
  final _lengthInCentimetersHandle = _sdkRoutingVehiclespecificationGetFieldlengthInCentimeters(handle);
  final _axleCountHandle = _sdkRoutingVehiclespecificationGetFieldaxleCount(handle);
  final _trailerCountHandle = _sdkRoutingVehiclespecificationGetFieldtrailerCount(handle);
  final _truckTypeHandle = _sdkRoutingVehiclespecificationGetFieldtruckType(handle);
  final _isTruckLightHandle = _sdkRoutingVehiclespecificationGetFieldisTruckLight(handle);
  final _isCommercialHandle = _sdkRoutingVehiclespecificationGetFieldisCommercial(handle);
  final _payloadCapacityInKilogramsHandle = _sdkRoutingVehiclespecificationGetFieldpayloadCapacityInKilograms(handle);
  final _trailerAxleCountHandle = _sdkRoutingVehiclespecificationGetFieldtrailerAxleCount(handle);
  final _lastCharacterOfLicensePlateHandle = _sdkRoutingVehiclespecificationGetFieldlastCharacterOfLicensePlate(handle);
  final _allowDriveThroughTaxiRoadsHandle = _sdkRoutingVehiclespecificationGetFieldallowDriveThroughTaxiRoads(handle);
  final _allowScooterOnHighwayHandle = _sdkRoutingVehiclespecificationGetFieldallowScooterOnHighway(handle);
  final _engineSizeInCubicCentimetersHandle = _sdkRoutingVehiclespecificationGetFieldengineSizeInCubicCentimeters(handle);
  try {
    return VehicleSpecification._(
      intFromFfiNullable(_heightInCentimetersHandle), 
      intFromFfiNullable(_widthInCentimetersHandle), 
      intFromFfiNullable(_lengthInCentimetersHandle), 
      intFromFfiNullable(_axleCountHandle), 
      intFromFfiNullable(_trailerCountHandle), 
      sdkTransportTrucktypeFromFfi(_truckTypeHandle), 
      booleanFromFfi(_isTruckLightHandle), 
      booleanFromFfi(_isCommercialHandle), 
      intFromFfiNullable(_payloadCapacityInKilogramsHandle), 
      intFromFfiNullable(_trailerAxleCountHandle), 
      stringFromFfiNullable(_lastCharacterOfLicensePlateHandle), 
      booleanFromFfi(_allowDriveThroughTaxiRoadsHandle), 
      booleanFromFfi(_allowScooterOnHighwayHandle), 
      intFromFfiNullable(_engineSizeInCubicCentimetersHandle)
    );
  } finally {
    intReleaseFfiHandleNullable(_heightInCentimetersHandle);
    intReleaseFfiHandleNullable(_widthInCentimetersHandle);
    intReleaseFfiHandleNullable(_lengthInCentimetersHandle);
    intReleaseFfiHandleNullable(_axleCountHandle);
    intReleaseFfiHandleNullable(_trailerCountHandle);
    sdkTransportTrucktypeReleaseFfiHandle(_truckTypeHandle);
    booleanReleaseFfiHandle(_isTruckLightHandle);
    booleanReleaseFfiHandle(_isCommercialHandle);
    intReleaseFfiHandleNullable(_payloadCapacityInKilogramsHandle);
    intReleaseFfiHandleNullable(_trailerAxleCountHandle);
    stringReleaseFfiHandleNullable(_lastCharacterOfLicensePlateHandle);
    booleanReleaseFfiHandle(_allowDriveThroughTaxiRoadsHandle);
    booleanReleaseFfiHandle(_allowScooterOnHighwayHandle);
    intReleaseFfiHandleNullable(_engineSizeInCubicCentimetersHandle);
  }
}

void sdkRoutingVehiclespecificationReleaseFfiHandle(Pointer<Void> handle) => _sdkRoutingVehiclespecificationReleaseHandle(handle);

// Nullable VehicleSpecification

final _sdkRoutingVehiclespecificationCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleSpecification_create_handle_nullable'));
final _sdkRoutingVehiclespecificationReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleSpecification_release_handle_nullable'));
final _sdkRoutingVehiclespecificationGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleSpecification_get_value_nullable'));

Pointer<Void> sdkRoutingVehiclespecificationToFfiNullable(VehicleSpecification? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkRoutingVehiclespecificationToFfi(value);
  final result = _sdkRoutingVehiclespecificationCreateHandleNullable(_handle);
  sdkRoutingVehiclespecificationReleaseFfiHandle(_handle);
  return result;
}

VehicleSpecification? sdkRoutingVehiclespecificationFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkRoutingVehiclespecificationGetValueNullable(handle);
  final result = sdkRoutingVehiclespecificationFromFfi(_handle);
  sdkRoutingVehiclespecificationReleaseFfiHandle(_handle);
  return result;
}

void sdkRoutingVehiclespecificationReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkRoutingVehiclespecificationReleaseHandleNullable(handle);

// End of VehicleSpecification "private" section.


