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
import 'package:here_sdk/src/_token_cache.dart' as __lib;
import 'package:here_sdk/src/generic_types__conversion.dart';
import 'package:here_sdk/src/sdk/core/geo_coordinates.dart';
import 'package:here_sdk/src/sdk/core/polyline_simplification_error.dart';

/// The method will be called on the main thread when
/// [PolylineSimplifier.simplify] is finished.
///
/// [p0] The optional error, which occurred during
/// simplification.
///
/// [p1] The simplified polyline with number of
/// points less or equal to the input polyline
/// of [PolylineSimplifier.simplify].
typedef PolylineSimplificationCallback = void Function(PolylineSimplificationError?, List<GeoCoordinates>?);

// PolylineSimplificationCallback "private" section, not exported.

final _sdkCorePolylinesimplificationcallbackRegisterFinalizer = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>, Int32, Handle),
    void Function(Pointer<Void>, int, Object)
  >('here_sdk_sdk_core_PolylineSimplificationCallback_register_finalizer'));
final _sdkCorePolylinesimplificationcallbackCopyHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_PolylineSimplificationCallback_copy_handle'));
final _sdkCorePolylinesimplificationcallbackReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_core_PolylineSimplificationCallback_release_handle'));
final _sdkCorePolylinesimplificationcallbackCreateProxy = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Uint64, Int32, Handle, Pointer),
    Pointer<Void> Function(int, int, Object, Pointer)
  >('here_sdk_sdk_core_PolylineSimplificationCallback_create_proxy'));

class PolylineSimplificationCallback$Impl implements Finalizable {
  final Pointer<Void> handle;
  PolylineSimplificationCallback$Impl(this.handle);

  void call(PolylineSimplificationError? p0, List<GeoCoordinates>? p1) {
    final _callFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>, Pointer<Void>)>('here_sdk_sdk_core_PolylineSimplificationCallback_call__PolylineSimplificationError__ListOf_sdk_core_GeoCoordinates_'));
    final _p0Handle = sdkCorePolylinesimplificationerrorToFfiNullable(p0);
    final _p1Handle = heresdkCoreBindingslistofSdkCoreGeocoordinatesToFfiNullable(p1);
    final _handle = this.handle;
    _callFfi(_handle, __lib.LibraryContext.isolateId, _p0Handle, _p1Handle);
    sdkCorePolylinesimplificationerrorReleaseFfiHandleNullable(_p0Handle);
    heresdkCoreBindingslistofSdkCoreGeocoordinatesReleaseFfiHandleNullable(_p1Handle);

  }

}

int _sdkCorePolylinesimplificationcallbackcallStatic(Object _obj, Pointer<Void> p0, Pointer<Void> p1) {
  
  try {
    (_obj as PolylineSimplificationCallback)(sdkCorePolylinesimplificationerrorFromFfiNullable(p0), heresdkCoreBindingslistofSdkCoreGeocoordinatesFromFfiNullable(p1));
  } finally {
    sdkCorePolylinesimplificationerrorReleaseFfiHandleNullable(p0);
    heresdkCoreBindingslistofSdkCoreGeocoordinatesReleaseFfiHandleNullable(p1);
  }
  return 0;
}

Pointer<Void> sdkCorePolylinesimplificationcallbackToFfi(PolylineSimplificationCallback value) =>
  _sdkCorePolylinesimplificationcallbackCreateProxy(
    __lib.getObjectToken(value),
    __lib.LibraryContext.isolateId,
    value,
    Pointer.fromFunction<Int64 Function(Handle, Pointer<Void>, Pointer<Void>)>(_sdkCorePolylinesimplificationcallbackcallStatic, __lib.unknownError)
  );

PolylineSimplificationCallback sdkCorePolylinesimplificationcallbackFromFfi(Pointer<Void> handle) {
  final _copiedHandle = _sdkCorePolylinesimplificationcallbackCopyHandle(handle);
  final _impl = PolylineSimplificationCallback$Impl(_copiedHandle);
  final result = (PolylineSimplificationError? p0, List<GeoCoordinates>? p1) => _impl.call(p0, p1);
  _sdkCorePolylinesimplificationcallbackRegisterFinalizer(_copiedHandle, __lib.LibraryContext.isolateId, result);
  return result;
}

void sdkCorePolylinesimplificationcallbackReleaseFfiHandle(Pointer<Void> handle) =>
  _sdkCorePolylinesimplificationcallbackReleaseHandle(handle);

// Nullable PolylineSimplificationCallback

final _sdkCorePolylinesimplificationcallbackCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_PolylineSimplificationCallback_create_handle_nullable'));
final _sdkCorePolylinesimplificationcallbackReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_core_PolylineSimplificationCallback_release_handle_nullable'));
final _sdkCorePolylinesimplificationcallbackGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_PolylineSimplificationCallback_get_value_nullable'));

Pointer<Void> sdkCorePolylinesimplificationcallbackToFfiNullable(PolylineSimplificationCallback? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkCorePolylinesimplificationcallbackToFfi(value);
  final result = _sdkCorePolylinesimplificationcallbackCreateHandleNullable(_handle);
  sdkCorePolylinesimplificationcallbackReleaseFfiHandle(_handle);
  return result;
}

PolylineSimplificationCallback? sdkCorePolylinesimplificationcallbackFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkCorePolylinesimplificationcallbackGetValueNullable(handle);
  final result = sdkCorePolylinesimplificationcallbackFromFfi(_handle);
  sdkCorePolylinesimplificationcallbackReleaseFfiHandle(_handle);
  return result;
}

void sdkCorePolylinesimplificationcallbackReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkCorePolylinesimplificationcallbackReleaseHandleNullable(handle);

// End of PolylineSimplificationCallback "private" section.


