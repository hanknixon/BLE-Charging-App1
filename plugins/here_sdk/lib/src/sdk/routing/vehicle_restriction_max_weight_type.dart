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

/// `VehicleRestrictionMaxWeightType` represents the specific type of the maximum permitted weight restriction.
///
/// **NOTES:**
/// A restriction of type `UNKNOWN` may change to `GROSS` or `CURRENT` when
/// data becomes available in future.
/// A restriction of type `GROSS` or `CURRENT` may also change to a different type if actual regulation changes.
enum VehicleRestrictionMaxWeightType {
    /// Restriction may apply to gross or current weight.
    unknown,
    /// Restriction is for gross weight.
    gross,
    /// Restriction is for current weight.
    current
}

// VehicleRestrictionMaxWeightType "private" section, not exported.

int sdkRoutingVehiclerestrictionmaxweighttypeToFfi(VehicleRestrictionMaxWeightType value) {
  switch (value) {
  case VehicleRestrictionMaxWeightType.unknown:
    return 0;
  case VehicleRestrictionMaxWeightType.gross:
    return 1;
  case VehicleRestrictionMaxWeightType.current:
    return 2;
  }
}

VehicleRestrictionMaxWeightType sdkRoutingVehiclerestrictionmaxweighttypeFromFfi(int handle) {
  switch (handle) {
  case 0:
    return VehicleRestrictionMaxWeightType.unknown;
  case 1:
    return VehicleRestrictionMaxWeightType.gross;
  case 2:
    return VehicleRestrictionMaxWeightType.current;
  default:
    throw StateError("Invalid numeric value $handle for VehicleRestrictionMaxWeightType enum.");
  }
}

void sdkRoutingVehiclerestrictionmaxweighttypeReleaseFfiHandle(int handle) {}

final _sdkRoutingVehiclerestrictionmaxweighttypeCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Uint32),
    Pointer<Void> Function(int)
  >('here_sdk_sdk_routing_VehicleRestrictionMaxWeightType_create_handle_nullable'));
final _sdkRoutingVehiclerestrictionmaxweighttypeReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleRestrictionMaxWeightType_release_handle_nullable'));
final _sdkRoutingVehiclerestrictionmaxweighttypeGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleRestrictionMaxWeightType_get_value_nullable'));

Pointer<Void> sdkRoutingVehiclerestrictionmaxweighttypeToFfiNullable(VehicleRestrictionMaxWeightType? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkRoutingVehiclerestrictionmaxweighttypeToFfi(value);
  final result = _sdkRoutingVehiclerestrictionmaxweighttypeCreateHandleNullable(_handle);
  sdkRoutingVehiclerestrictionmaxweighttypeReleaseFfiHandle(_handle);
  return result;
}

VehicleRestrictionMaxWeightType? sdkRoutingVehiclerestrictionmaxweighttypeFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkRoutingVehiclerestrictionmaxweighttypeGetValueNullable(handle);
  final result = sdkRoutingVehiclerestrictionmaxweighttypeFromFfi(_handle);
  sdkRoutingVehiclerestrictionmaxweighttypeReleaseFfiHandle(_handle);
  return result;
}

void sdkRoutingVehiclerestrictionmaxweighttypeReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkRoutingVehiclerestrictionmaxweighttypeReleaseHandleNullable(handle);

// End of VehicleRestrictionMaxWeightType "private" section.


