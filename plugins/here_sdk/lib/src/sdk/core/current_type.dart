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

/// This enum represents the type of electric current
enum CurrentType {
    /// Alternating Current (AC)
    ac,
    /// Direct Current (DC)
    dc
}

// CurrentType "private" section, not exported.

int sdkCoreCurrenttypeToFfi(CurrentType value) {
  switch (value) {
  case CurrentType.ac:
    return 0;
  case CurrentType.dc:
    return 1;
  }
}

CurrentType sdkCoreCurrenttypeFromFfi(int handle) {
  switch (handle) {
  case 0:
    return CurrentType.ac;
  case 1:
    return CurrentType.dc;
  default:
    throw StateError("Invalid numeric value $handle for CurrentType enum.");
  }
}

void sdkCoreCurrenttypeReleaseFfiHandle(int handle) {}

final _sdkCoreCurrenttypeCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Uint32),
    Pointer<Void> Function(int)
  >('here_sdk_sdk_core_CurrentType_create_handle_nullable'));
final _sdkCoreCurrenttypeReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_core_CurrentType_release_handle_nullable'));
final _sdkCoreCurrenttypeGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_core_CurrentType_get_value_nullable'));

Pointer<Void> sdkCoreCurrenttypeToFfiNullable(CurrentType? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkCoreCurrenttypeToFfi(value);
  final result = _sdkCoreCurrenttypeCreateHandleNullable(_handle);
  sdkCoreCurrenttypeReleaseFfiHandle(_handle);
  return result;
}

CurrentType? sdkCoreCurrenttypeFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkCoreCurrenttypeGetValueNullable(handle);
  final result = sdkCoreCurrenttypeFromFfi(_handle);
  sdkCoreCurrenttypeReleaseFfiHandle(_handle);
  return result;
}

void sdkCoreCurrenttypeReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkCoreCurrenttypeReleaseHandleNullable(handle);

// End of CurrentType "private" section.


