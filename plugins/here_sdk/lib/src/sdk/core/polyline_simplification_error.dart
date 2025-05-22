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

/// Error code which specifies, what went wrong during
/// [PolylineSimplifier.simplify] operation.
enum PolylineSimplificationError {
    /// The task has been cancelled. For example, when an
    /// ongoing task has been cancelled by the user
    /// invoking [TaskHandle.cancel].
    cancelled
}

// PolylineSimplificationError "private" section, not exported.

int sdkCorePolylinesimplificationerrorToFfi(PolylineSimplificationError value) {
  switch (value) {
  case PolylineSimplificationError.cancelled:
    return 0;
  }
}

PolylineSimplificationError sdkCorePolylinesimplificationerrorFromFfi(int handle) {
  switch (handle) {
  case 0:
    return PolylineSimplificationError.cancelled;
  default:
    throw StateError("Invalid numeric value $handle for PolylineSimplificationError enum.");
  }
}

void sdkCorePolylinesimplificationerrorReleaseFfiHandle(int handle) {}

final _sdkCorePolylinesimplificationerrorCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Uint32),
    Pointer<Void> Function(int)
  >('here_sdk_sdk_core_PolylineSimplificationError_create_handle_nullable'));
final _sdkCorePolylinesimplificationerrorReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_core_PolylineSimplificationError_release_handle_nullable'));
final _sdkCorePolylinesimplificationerrorGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_core_PolylineSimplificationError_get_value_nullable'));

Pointer<Void> sdkCorePolylinesimplificationerrorToFfiNullable(PolylineSimplificationError? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkCorePolylinesimplificationerrorToFfi(value);
  final result = _sdkCorePolylinesimplificationerrorCreateHandleNullable(_handle);
  sdkCorePolylinesimplificationerrorReleaseFfiHandle(_handle);
  return result;
}

PolylineSimplificationError? sdkCorePolylinesimplificationerrorFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkCorePolylinesimplificationerrorGetValueNullable(handle);
  final result = sdkCorePolylinesimplificationerrorFromFfi(_handle);
  sdkCorePolylinesimplificationerrorReleaseFfiHandle(_handle);
  return result;
}

void sdkCorePolylinesimplificationerrorReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkCorePolylinesimplificationerrorReleaseHandleNullable(handle);

// End of PolylineSimplificationError "private" section.


