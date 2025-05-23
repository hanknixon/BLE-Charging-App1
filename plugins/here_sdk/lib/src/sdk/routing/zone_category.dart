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

/// Identifies categories of zones which routes avoid going through when used in
/// [AvoidanceOptions].
enum ZoneCategory {
    /// A zone defined by environmental criteria. This type of zones
    /// comprises zones like Low Emission Zones (LEZ), German Umweltzones or Italian
    /// (E)ZTLs.
    environmental,
    /// Vignette roads, which are found in some European countries.
    /// This type of zones works based on payment for a fixed time period.
    vignette,
    /// A zone that consists of roads usually in the city centers, airports, bridges,
    /// or busy areas. It's used to mitigate traffic congestion by charging
    /// a higher pricing in rush hours.
    congestionPricing
}

// ZoneCategory "private" section, not exported.

int sdkRoutingZonecategoryToFfi(ZoneCategory value) {
  switch (value) {
  case ZoneCategory.environmental:
    return 0;
  case ZoneCategory.vignette:
    return 1;
  case ZoneCategory.congestionPricing:
    return 2;
  }
}

ZoneCategory sdkRoutingZonecategoryFromFfi(int handle) {
  switch (handle) {
  case 0:
    return ZoneCategory.environmental;
  case 1:
    return ZoneCategory.vignette;
  case 2:
    return ZoneCategory.congestionPricing;
  default:
    throw StateError("Invalid numeric value $handle for ZoneCategory enum.");
  }
}

void sdkRoutingZonecategoryReleaseFfiHandle(int handle) {}

final _sdkRoutingZonecategoryCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Uint32),
    Pointer<Void> Function(int)
  >('here_sdk_sdk_routing_ZoneCategory_create_handle_nullable'));
final _sdkRoutingZonecategoryReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_ZoneCategory_release_handle_nullable'));
final _sdkRoutingZonecategoryGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_routing_ZoneCategory_get_value_nullable'));

Pointer<Void> sdkRoutingZonecategoryToFfiNullable(ZoneCategory? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkRoutingZonecategoryToFfi(value);
  final result = _sdkRoutingZonecategoryCreateHandleNullable(_handle);
  sdkRoutingZonecategoryReleaseFfiHandle(_handle);
  return result;
}

ZoneCategory? sdkRoutingZonecategoryFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkRoutingZonecategoryGetValueNullable(handle);
  final result = sdkRoutingZonecategoryFromFfi(_handle);
  sdkRoutingZonecategoryReleaseFfiHandle(_handle);
  return result;
}

void sdkRoutingZonecategoryReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkRoutingZonecategoryReleaseHandleNullable(handle);

// End of ZoneCategory "private" section.


