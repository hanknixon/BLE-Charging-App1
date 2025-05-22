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
import 'package:here_sdk/src/sdk/routing/vehicle_restriction_max_weight_type.dart';

/// `VehicleRestrictionMaxWeight` contains max permitted weight during the trip, in kilograms,
/// along with the specific type of maximum permitted weight restriction.

class VehicleRestrictionMaxWeight {
  /// Max permitted weight during the trip, in kilograms.
  int valueInKilograms;

  /// Represents the specific type of the maximum permitted weight restriction.
  VehicleRestrictionMaxWeightType type;

  /// Created a new instance.

  /// [valueInKilograms] Max permitted weight during the trip, in kilograms.

  /// [type] Represents the specific type of the maximum permitted weight restriction.

  VehicleRestrictionMaxWeight(this.valueInKilograms, this.type);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VehicleRestrictionMaxWeight) return false;
    VehicleRestrictionMaxWeight _other = other;
    return valueInKilograms == _other.valueInKilograms &&
        type == _other.type;
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + valueInKilograms.hashCode;
    result = 31 * result + type.hashCode;
    return result;
  }
}


// VehicleRestrictionMaxWeight "private" section, not exported.

final _sdkRoutingVehiclerestrictionmaxweightCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Int32, Uint32),
    Pointer<Void> Function(int, int)
  >('here_sdk_sdk_routing_VehicleRestrictionMaxWeight_create_handle'));
final _sdkRoutingVehiclerestrictionmaxweightReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleRestrictionMaxWeight_release_handle'));
final _sdkRoutingVehiclerestrictionmaxweightGetFieldvalueInKilograms = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Int32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleRestrictionMaxWeight_get_field_valueInKilograms'));
final _sdkRoutingVehiclerestrictionmaxweightGetFieldtype = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleRestrictionMaxWeight_get_field_type'));



Pointer<Void> sdkRoutingVehiclerestrictionmaxweightToFfi(VehicleRestrictionMaxWeight value) {
  final _valueInKilogramsHandle = (value.valueInKilograms);
  final _typeHandle = sdkRoutingVehiclerestrictionmaxweighttypeToFfi(value.type);
  final _result = _sdkRoutingVehiclerestrictionmaxweightCreateHandle(_valueInKilogramsHandle, _typeHandle);
  
  sdkRoutingVehiclerestrictionmaxweighttypeReleaseFfiHandle(_typeHandle);
  return _result;
}

VehicleRestrictionMaxWeight sdkRoutingVehiclerestrictionmaxweightFromFfi(Pointer<Void> handle) {
  final _valueInKilogramsHandle = _sdkRoutingVehiclerestrictionmaxweightGetFieldvalueInKilograms(handle);
  final _typeHandle = _sdkRoutingVehiclerestrictionmaxweightGetFieldtype(handle);
  try {
    return VehicleRestrictionMaxWeight(
      (_valueInKilogramsHandle), 
      sdkRoutingVehiclerestrictionmaxweighttypeFromFfi(_typeHandle)
    );
  } finally {
    
    sdkRoutingVehiclerestrictionmaxweighttypeReleaseFfiHandle(_typeHandle);
  }
}

void sdkRoutingVehiclerestrictionmaxweightReleaseFfiHandle(Pointer<Void> handle) => _sdkRoutingVehiclerestrictionmaxweightReleaseHandle(handle);

// Nullable VehicleRestrictionMaxWeight

final _sdkRoutingVehiclerestrictionmaxweightCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleRestrictionMaxWeight_create_handle_nullable'));
final _sdkRoutingVehiclerestrictionmaxweightReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleRestrictionMaxWeight_release_handle_nullable'));
final _sdkRoutingVehiclerestrictionmaxweightGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_VehicleRestrictionMaxWeight_get_value_nullable'));

Pointer<Void> sdkRoutingVehiclerestrictionmaxweightToFfiNullable(VehicleRestrictionMaxWeight? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkRoutingVehiclerestrictionmaxweightToFfi(value);
  final result = _sdkRoutingVehiclerestrictionmaxweightCreateHandleNullable(_handle);
  sdkRoutingVehiclerestrictionmaxweightReleaseFfiHandle(_handle);
  return result;
}

VehicleRestrictionMaxWeight? sdkRoutingVehiclerestrictionmaxweightFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkRoutingVehiclerestrictionmaxweightGetValueNullable(handle);
  final result = sdkRoutingVehiclerestrictionmaxweightFromFfi(_handle);
  sdkRoutingVehiclerestrictionmaxweightReleaseFfiHandle(_handle);
  return result;
}

void sdkRoutingVehiclerestrictionmaxweightReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkRoutingVehiclerestrictionmaxweightReleaseHandleNullable(handle);

// End of VehicleRestrictionMaxWeight "private" section.


