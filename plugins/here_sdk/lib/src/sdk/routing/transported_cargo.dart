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
import 'package:here_sdk/src/builtin_types__conversion.dart';
import 'package:here_sdk/src/generic_types__conversion.dart';
import 'package:here_sdk/src/sdk/transport/hazardous_material.dart';
import 'package:here_sdk/src/sdk/transport/truck_road_type.dart';
import 'package:here_sdk/src/sdk/transport/tunnel_category.dart';
import 'package:here_sdk/src/sdk/transport/weight_per_axle_group.dart';

/// This struct defines the transported cargo and weight of the vehicle.
///
/// **Note:** This is a beta release of this feature, so there could be a few bugs and unexpected behaviors.
/// Related APIs may change for new releases without a deprecation process.

class TransportedCargo {
  /// The current weight in kilograms.
  ///
  /// This parameter is used to provide a more accurate consumption prediction for electric vehicles.
  /// `grossWeightInKilograms` is used for vehicle restrictions on the road.
  ///
  /// The value is used to define the electrical vehicle consumption along the route.
  int? currentWeightInKilograms;

  /// Truck weight including trailers and shipped goods in kilograms. The provided value
  /// must be greater than or equal to 0. By default, it is not set.
  int? grossWeightInKilograms;

  /// Heaviest weight per axle, regardless of axle type or axle group.
  /// It is evaluated against all axle weight restrictions, including single axle and tandem axle weight restrictions.
  /// The provided value must be greater or equal to 0.
  /// By default, it is not set.
  /// **Note:** `weight_per_axle_in_kilograms` and `weight_per_axle_group` are incompatible.
  /// When available for your edition, if both attributes are set, during online RoutingEngine an [sdk.routing.RoutingError.INVALID_PARAMETER] error is generated.
  /// Otherwise, when offline RoutingEngine is in place, both parameters are evaluated and the maximum value between them will be used.
  int? weightPerAxleInKilograms;

  /// Allows specification of axle weights in a more fine-grained way than `weight_per_axle_in_kilograms`.
  /// This is relevant in countries with signs and regulations that specify different limits for different axle groups, like the USA and Sweden.
  /// By default is not set.
  /// **Note:** `weight_per_axle_in_kilograms` and `weight_per_axle_group` are incompatible.
  /// When available for your edition, if both attributes are set, during online RoutingEngine an [sdk.routing.RoutingError.INVALID_PARAMETER] error is generated.
  /// Otherwise, when offline RoutingEngine is in place, both parameters are evaluated and the maximum value between them will be used.
  WeightPerAxleGroup? weightPerAxleGroup;

  /// Specifies the tunnel categories to restrict certain route links.
  /// The route will pass only through tunnels of a less strict category.
  /// Refer to [TunnelCategory] for the available options.
  TunnelCategory? linkTunnelCategory;

  /// Specifies a list of hazardous materials shipped in the vehicle.
  /// Refer to [HazardousMaterial] for the available options.
  List<HazardousMaterial> hazardousMaterials;

  /// Specifies a list of avoided truck road types for vehicle.
  /// Refer to [TruckRoadType] for the available options.
  List<TruckRoadType> avoidedTruckRoadTypes;

  /// Creates a new instance.

  /// [currentWeightInKilograms] The current weight in kilograms.
  ///
  /// This parameter is used to provide a more accurate consumption prediction for electric vehicles.
  /// `grossWeightInKilograms` is used for vehicle restrictions on the road.
  ///
  /// The value is used to define the electrical vehicle consumption along the route.

  /// [grossWeightInKilograms] Truck weight including trailers and shipped goods in kilograms. The provided value
  /// must be greater than or equal to 0. By default, it is not set.

  /// [weightPerAxleInKilograms] Heaviest weight per axle, regardless of axle type or axle group.
  /// It is evaluated against all axle weight restrictions, including single axle and tandem axle weight restrictions.
  /// The provided value must be greater or equal to 0.
  /// By default, it is not set.
  /// **Note:** `weight_per_axle_in_kilograms` and `weight_per_axle_group` are incompatible.
  /// When available for your edition, if both attributes are set, during online RoutingEngine an [sdk.routing.RoutingError.INVALID_PARAMETER] error is generated.
  /// Otherwise, when offline RoutingEngine is in place, both parameters are evaluated and the maximum value between them will be used.

  /// [weightPerAxleGroup] Allows specification of axle weights in a more fine-grained way than `weight_per_axle_in_kilograms`.
  /// This is relevant in countries with signs and regulations that specify different limits for different axle groups, like the USA and Sweden.
  /// By default is not set.
  /// **Note:** `weight_per_axle_in_kilograms` and `weight_per_axle_group` are incompatible.
  /// When available for your edition, if both attributes are set, during online RoutingEngine an [sdk.routing.RoutingError.INVALID_PARAMETER] error is generated.
  /// Otherwise, when offline RoutingEngine is in place, both parameters are evaluated and the maximum value between them will be used.

  /// [linkTunnelCategory] Specifies the tunnel categories to restrict certain route links.
  /// The route will pass only through tunnels of a less strict category.
  /// Refer to [TunnelCategory] for the available options.

  /// [hazardousMaterials] Specifies a list of hazardous materials shipped in the vehicle.
  /// Refer to [HazardousMaterial] for the available options.

  /// [avoidedTruckRoadTypes] Specifies a list of avoided truck road types for vehicle.
  /// Refer to [TruckRoadType] for the available options.

  TransportedCargo._(this.currentWeightInKilograms, this.grossWeightInKilograms, this.weightPerAxleInKilograms, this.weightPerAxleGroup, this.linkTunnelCategory, this.hazardousMaterials, this.avoidedTruckRoadTypes);
  TransportedCargo()
    : currentWeightInKilograms = null, grossWeightInKilograms = null, weightPerAxleInKilograms = null, weightPerAxleGroup = null, linkTunnelCategory = null, hazardousMaterials = [], avoidedTruckRoadTypes = [];
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TransportedCargo) return false;
    TransportedCargo _other = other;
    return currentWeightInKilograms == _other.currentWeightInKilograms &&
        grossWeightInKilograms == _other.grossWeightInKilograms &&
        weightPerAxleInKilograms == _other.weightPerAxleInKilograms &&
        weightPerAxleGroup == _other.weightPerAxleGroup &&
        linkTunnelCategory == _other.linkTunnelCategory &&
        DeepCollectionEquality().equals(hazardousMaterials, _other.hazardousMaterials) &&
        DeepCollectionEquality().equals(avoidedTruckRoadTypes, _other.avoidedTruckRoadTypes);
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + currentWeightInKilograms.hashCode;
    result = 31 * result + grossWeightInKilograms.hashCode;
    result = 31 * result + weightPerAxleInKilograms.hashCode;
    result = 31 * result + weightPerAxleGroup.hashCode;
    result = 31 * result + linkTunnelCategory.hashCode;
    result = 31 * result + DeepCollectionEquality().hash(hazardousMaterials);
    result = 31 * result + DeepCollectionEquality().hash(avoidedTruckRoadTypes);
    return result;
  }
}


// TransportedCargo "private" section, not exported.

final _sdkRoutingTransportedcargoCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>)
  >('here_sdk_sdk_routing_TransportedCargo_create_handle'));
final _sdkRoutingTransportedcargoReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_TransportedCargo_release_handle'));
final _sdkRoutingTransportedcargoGetFieldcurrentWeightInKilograms = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_TransportedCargo_get_field_currentWeightInKilograms'));
final _sdkRoutingTransportedcargoGetFieldgrossWeightInKilograms = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_TransportedCargo_get_field_grossWeightInKilograms'));
final _sdkRoutingTransportedcargoGetFieldweightPerAxleInKilograms = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_TransportedCargo_get_field_weightPerAxleInKilograms'));
final _sdkRoutingTransportedcargoGetFieldweightPerAxleGroup = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_TransportedCargo_get_field_weightPerAxleGroup'));
final _sdkRoutingTransportedcargoGetFieldlinkTunnelCategory = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_TransportedCargo_get_field_linkTunnelCategory'));
final _sdkRoutingTransportedcargoGetFieldhazardousMaterials = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_TransportedCargo_get_field_hazardousMaterials'));
final _sdkRoutingTransportedcargoGetFieldavoidedTruckRoadTypes = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_TransportedCargo_get_field_avoidedTruckRoadTypes'));



Pointer<Void> sdkRoutingTransportedcargoToFfi(TransportedCargo value) {
  final _currentWeightInKilogramsHandle = intToFfiNullable(value.currentWeightInKilograms);
  final _grossWeightInKilogramsHandle = intToFfiNullable(value.grossWeightInKilograms);
  final _weightPerAxleInKilogramsHandle = intToFfiNullable(value.weightPerAxleInKilograms);
  final _weightPerAxleGroupHandle = sdkTransportWeightperaxlegroupToFfiNullable(value.weightPerAxleGroup);
  final _linkTunnelCategoryHandle = sdkTransportTunnelcategoryToFfiNullable(value.linkTunnelCategory);
  final _hazardousMaterialsHandle = heresdkRoutingCommonBindingslistofSdkTransportHazardousmaterialToFfi(value.hazardousMaterials);
  final _avoidedTruckRoadTypesHandle = heresdkRoutingCommonBindingslistofSdkTransportTruckroadtypeToFfi(value.avoidedTruckRoadTypes);
  final _result = _sdkRoutingTransportedcargoCreateHandle(_currentWeightInKilogramsHandle, _grossWeightInKilogramsHandle, _weightPerAxleInKilogramsHandle, _weightPerAxleGroupHandle, _linkTunnelCategoryHandle, _hazardousMaterialsHandle, _avoidedTruckRoadTypesHandle);
  intReleaseFfiHandleNullable(_currentWeightInKilogramsHandle);
  intReleaseFfiHandleNullable(_grossWeightInKilogramsHandle);
  intReleaseFfiHandleNullable(_weightPerAxleInKilogramsHandle);
  sdkTransportWeightperaxlegroupReleaseFfiHandleNullable(_weightPerAxleGroupHandle);
  sdkTransportTunnelcategoryReleaseFfiHandleNullable(_linkTunnelCategoryHandle);
  heresdkRoutingCommonBindingslistofSdkTransportHazardousmaterialReleaseFfiHandle(_hazardousMaterialsHandle);
  heresdkRoutingCommonBindingslistofSdkTransportTruckroadtypeReleaseFfiHandle(_avoidedTruckRoadTypesHandle);
  return _result;
}

TransportedCargo sdkRoutingTransportedcargoFromFfi(Pointer<Void> handle) {
  final _currentWeightInKilogramsHandle = _sdkRoutingTransportedcargoGetFieldcurrentWeightInKilograms(handle);
  final _grossWeightInKilogramsHandle = _sdkRoutingTransportedcargoGetFieldgrossWeightInKilograms(handle);
  final _weightPerAxleInKilogramsHandle = _sdkRoutingTransportedcargoGetFieldweightPerAxleInKilograms(handle);
  final _weightPerAxleGroupHandle = _sdkRoutingTransportedcargoGetFieldweightPerAxleGroup(handle);
  final _linkTunnelCategoryHandle = _sdkRoutingTransportedcargoGetFieldlinkTunnelCategory(handle);
  final _hazardousMaterialsHandle = _sdkRoutingTransportedcargoGetFieldhazardousMaterials(handle);
  final _avoidedTruckRoadTypesHandle = _sdkRoutingTransportedcargoGetFieldavoidedTruckRoadTypes(handle);
  try {
    return TransportedCargo._(
      intFromFfiNullable(_currentWeightInKilogramsHandle), 
      intFromFfiNullable(_grossWeightInKilogramsHandle), 
      intFromFfiNullable(_weightPerAxleInKilogramsHandle), 
      sdkTransportWeightperaxlegroupFromFfiNullable(_weightPerAxleGroupHandle), 
      sdkTransportTunnelcategoryFromFfiNullable(_linkTunnelCategoryHandle), 
      heresdkRoutingCommonBindingslistofSdkTransportHazardousmaterialFromFfi(_hazardousMaterialsHandle), 
      heresdkRoutingCommonBindingslistofSdkTransportTruckroadtypeFromFfi(_avoidedTruckRoadTypesHandle)
    );
  } finally {
    intReleaseFfiHandleNullable(_currentWeightInKilogramsHandle);
    intReleaseFfiHandleNullable(_grossWeightInKilogramsHandle);
    intReleaseFfiHandleNullable(_weightPerAxleInKilogramsHandle);
    sdkTransportWeightperaxlegroupReleaseFfiHandleNullable(_weightPerAxleGroupHandle);
    sdkTransportTunnelcategoryReleaseFfiHandleNullable(_linkTunnelCategoryHandle);
    heresdkRoutingCommonBindingslistofSdkTransportHazardousmaterialReleaseFfiHandle(_hazardousMaterialsHandle);
    heresdkRoutingCommonBindingslistofSdkTransportTruckroadtypeReleaseFfiHandle(_avoidedTruckRoadTypesHandle);
  }
}

void sdkRoutingTransportedcargoReleaseFfiHandle(Pointer<Void> handle) => _sdkRoutingTransportedcargoReleaseHandle(handle);

// Nullable TransportedCargo

final _sdkRoutingTransportedcargoCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_TransportedCargo_create_handle_nullable'));
final _sdkRoutingTransportedcargoReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_TransportedCargo_release_handle_nullable'));
final _sdkRoutingTransportedcargoGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_TransportedCargo_get_value_nullable'));

Pointer<Void> sdkRoutingTransportedcargoToFfiNullable(TransportedCargo? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkRoutingTransportedcargoToFfi(value);
  final result = _sdkRoutingTransportedcargoCreateHandleNullable(_handle);
  sdkRoutingTransportedcargoReleaseFfiHandle(_handle);
  return result;
}

TransportedCargo? sdkRoutingTransportedcargoFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkRoutingTransportedcargoGetValueNullable(handle);
  final result = sdkRoutingTransportedcargoFromFfi(_handle);
  sdkRoutingTransportedcargoReleaseFfiHandle(_handle);
  return result;
}

void sdkRoutingTransportedcargoReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkRoutingTransportedcargoReleaseHandleNullable(handle);

// End of TransportedCargo "private" section.


