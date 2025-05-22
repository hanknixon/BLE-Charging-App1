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
import 'package:here_sdk/src/builtin_types__conversion.dart';

/// This method will be called on the main thread when [SDKNativeEngine.getDeviceId] has been completed.
///
/// [p0] Represents a deviceId, a unique identifier assigned to the device for this application.
typedef DeviceIdCallback = void Function(String);

// DeviceIdCallback "private" section, not exported.

final _sdkCoreEngineDeviceidcallbackRegisterFinalizer = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>, Int32, Handle),
    void Function(Pointer<Void>, int, Object)
  >('here_sdk_sdk_core_engine_DeviceIdCallback_register_finalizer'));
final _sdkCoreEngineDeviceidcallbackCopyHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_engine_DeviceIdCallback_copy_handle'));
final _sdkCoreEngineDeviceidcallbackReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_core_engine_DeviceIdCallback_release_handle'));
final _sdkCoreEngineDeviceidcallbackCreateProxy = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Uint64, Int32, Handle, Pointer),
    Pointer<Void> Function(int, int, Object, Pointer)
  >('here_sdk_sdk_core_engine_DeviceIdCallback_create_proxy'));

class DeviceIdCallback$Impl implements Finalizable {
  final Pointer<Void> handle;
  DeviceIdCallback$Impl(this.handle);

  void call(String p0) {
    final _callFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_core_engine_DeviceIdCallback_call__String'));
    final _p0Handle = stringToFfi(p0);
    final _handle = this.handle;
    _callFfi(_handle, __lib.LibraryContext.isolateId, _p0Handle);
    stringReleaseFfiHandle(_p0Handle);

  }

}

int _sdkCoreEngineDeviceidcallbackcallStatic(Object _obj, Pointer<Void> p0) {
  
  try {
    (_obj as DeviceIdCallback)(stringFromFfi(p0));
  } finally {
    stringReleaseFfiHandle(p0);
  }
  return 0;
}

Pointer<Void> sdkCoreEngineDeviceidcallbackToFfi(DeviceIdCallback value) =>
  _sdkCoreEngineDeviceidcallbackCreateProxy(
    __lib.getObjectToken(value),
    __lib.LibraryContext.isolateId,
    value,
    Pointer.fromFunction<Int64 Function(Handle, Pointer<Void>)>(_sdkCoreEngineDeviceidcallbackcallStatic, __lib.unknownError)
  );

DeviceIdCallback sdkCoreEngineDeviceidcallbackFromFfi(Pointer<Void> handle) {
  final _copiedHandle = _sdkCoreEngineDeviceidcallbackCopyHandle(handle);
  final _impl = DeviceIdCallback$Impl(_copiedHandle);
  final result = (String p0) => _impl.call(p0);
  _sdkCoreEngineDeviceidcallbackRegisterFinalizer(_copiedHandle, __lib.LibraryContext.isolateId, result);
  return result;
}

void sdkCoreEngineDeviceidcallbackReleaseFfiHandle(Pointer<Void> handle) =>
  _sdkCoreEngineDeviceidcallbackReleaseHandle(handle);

// Nullable DeviceIdCallback

final _sdkCoreEngineDeviceidcallbackCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_engine_DeviceIdCallback_create_handle_nullable'));
final _sdkCoreEngineDeviceidcallbackReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_core_engine_DeviceIdCallback_release_handle_nullable'));
final _sdkCoreEngineDeviceidcallbackGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_engine_DeviceIdCallback_get_value_nullable'));

Pointer<Void> sdkCoreEngineDeviceidcallbackToFfiNullable(DeviceIdCallback? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkCoreEngineDeviceidcallbackToFfi(value);
  final result = _sdkCoreEngineDeviceidcallbackCreateHandleNullable(_handle);
  sdkCoreEngineDeviceidcallbackReleaseFfiHandle(_handle);
  return result;
}

DeviceIdCallback? sdkCoreEngineDeviceidcallbackFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkCoreEngineDeviceidcallbackGetValueNullable(handle);
  final result = sdkCoreEngineDeviceidcallbackFromFfi(_handle);
  sdkCoreEngineDeviceidcallbackReleaseFfiHandle(_handle);
  return result;
}

void sdkCoreEngineDeviceidcallbackReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkCoreEngineDeviceidcallbackReleaseHandleNullable(handle);

// End of DeviceIdCallback "private" section.


