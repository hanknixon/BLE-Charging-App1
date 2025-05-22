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
import 'package:here_sdk/src/_native_base.dart' as __lib;
import 'package:here_sdk/src/_token_cache.dart' as __lib;
import 'package:here_sdk/src/builtin_types__conversion.dart';
import 'package:here_sdk/src/sdk/core/engine/log_level.dart';
import 'package:meta/meta.dart';

/// Logging interface for Android/iOS platforms.
///
/// These logs are under management of [LogControl] and should be used instead of platform-specific logging functions.
abstract class SDKLogger implements Finalizable {


  /// [level] The severity of the log message.
  ///
  /// [tag] The log tag.
  ///
  /// [message] The log message.
  ///
  static void log(LogLevel level, String tag, String message) => $prototype.log(level, tag, message);
  /// convenient function to print a message with log level INFO and tag.
  ///
  /// [tag] The log tag.
  ///
  /// [message] The log message.
  ///
  static void info(String tag, String message) => $prototype.info(tag, message);
  /// convenient function to print a message with log level WARNING and tag.
  ///
  /// [tag] The log tag.
  ///
  /// [message] The log message.
  ///
  static void warn(String tag, String message) => $prototype.warn(tag, message);
  /// convenient function to print a message with log level ERROR and tag.
  ///
  /// [tag] The log tag.
  ///
  /// [message] The log message.
  ///
  static void error(String tag, String message) => $prototype.error(tag, message);
  /// convenient function to print a message with log level FATAL and tag.
  ///
  /// [tag] The log tag.
  ///
  /// [message] The log message.
  ///
  static void fatal(String tag, String message) => $prototype.fatal(tag, message);

  /// @nodoc
  @visibleForTesting
  static dynamic $prototype = SDKLogger$Impl(Pointer<Void>.fromAddress(0));
}


// SDKLogger "private" section, not exported.

final _sdkCoreEngineSdkloggerRegisterFinalizer = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>, Int32, Handle),
    void Function(Pointer<Void>, int, Object)
  >('here_sdk_sdk_core_engine_SDKLogger_register_finalizer'));
final _sdkCoreEngineSdkloggerCopyHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_engine_SDKLogger_copy_handle'));
final _sdkCoreEngineSdkloggerReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_core_engine_SDKLogger_release_handle'));







/// @nodoc
@visibleForTesting

class SDKLogger$Impl extends __lib.NativeBase implements SDKLogger {

  SDKLogger$Impl(Pointer<Void> handle) : super(handle);

  void log(LogLevel level, String tag, String message) {
    final _logFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Int32, Uint32, Pointer<Void>, Pointer<Void>), void Function(int, int, Pointer<Void>, Pointer<Void>)>('here_sdk_sdk_core_engine_SDKLogger_log__LogLevel_String_String'));
    final _levelHandle = sdkCoreEngineLoglevelToFfi(level);
    final _tagHandle = stringToFfi(tag);
    final _messageHandle = stringToFfi(message);
    _logFfi(__lib.LibraryContext.isolateId, _levelHandle, _tagHandle, _messageHandle);
    sdkCoreEngineLoglevelReleaseFfiHandle(_levelHandle);
    stringReleaseFfiHandle(_tagHandle);
    stringReleaseFfiHandle(_messageHandle);

  }

  void info(String tag, String message) {
    final _infoFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Int32, Pointer<Void>, Pointer<Void>), void Function(int, Pointer<Void>, Pointer<Void>)>('here_sdk_sdk_core_engine_SDKLogger_info__String_String'));
    final _tagHandle = stringToFfi(tag);
    final _messageHandle = stringToFfi(message);
    _infoFfi(__lib.LibraryContext.isolateId, _tagHandle, _messageHandle);
    stringReleaseFfiHandle(_tagHandle);
    stringReleaseFfiHandle(_messageHandle);

  }

  void warn(String tag, String message) {
    final _warnFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Int32, Pointer<Void>, Pointer<Void>), void Function(int, Pointer<Void>, Pointer<Void>)>('here_sdk_sdk_core_engine_SDKLogger_warn__String_String'));
    final _tagHandle = stringToFfi(tag);
    final _messageHandle = stringToFfi(message);
    _warnFfi(__lib.LibraryContext.isolateId, _tagHandle, _messageHandle);
    stringReleaseFfiHandle(_tagHandle);
    stringReleaseFfiHandle(_messageHandle);

  }

  void error(String tag, String message) {
    final _errorFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Int32, Pointer<Void>, Pointer<Void>), void Function(int, Pointer<Void>, Pointer<Void>)>('here_sdk_sdk_core_engine_SDKLogger_error__String_String'));
    final _tagHandle = stringToFfi(tag);
    final _messageHandle = stringToFfi(message);
    _errorFfi(__lib.LibraryContext.isolateId, _tagHandle, _messageHandle);
    stringReleaseFfiHandle(_tagHandle);
    stringReleaseFfiHandle(_messageHandle);

  }

  void fatal(String tag, String message) {
    final _fatalFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Int32, Pointer<Void>, Pointer<Void>), void Function(int, Pointer<Void>, Pointer<Void>)>('here_sdk_sdk_core_engine_SDKLogger_fatal__String_String'));
    final _tagHandle = stringToFfi(tag);
    final _messageHandle = stringToFfi(message);
    _fatalFfi(__lib.LibraryContext.isolateId, _tagHandle, _messageHandle);
    stringReleaseFfiHandle(_tagHandle);
    stringReleaseFfiHandle(_messageHandle);

  }


}

Pointer<Void> sdkCoreEngineSdkloggerToFfi(SDKLogger value) =>
  _sdkCoreEngineSdkloggerCopyHandle((value as __lib.NativeBase).handle);

SDKLogger sdkCoreEngineSdkloggerFromFfi(Pointer<Void> handle) {
  if (handle.address == 0) throw StateError("Expected non-null value.");
  final instance = __lib.getCachedInstance(handle);
  if (instance != null && instance is SDKLogger) return instance;

  final _copiedHandle = _sdkCoreEngineSdkloggerCopyHandle(handle);
  final result = SDKLogger$Impl(_copiedHandle);
  __lib.cacheInstance(_copiedHandle, result);
  _sdkCoreEngineSdkloggerRegisterFinalizer(_copiedHandle, __lib.LibraryContext.isolateId, result);
  return result;
}

void sdkCoreEngineSdkloggerReleaseFfiHandle(Pointer<Void> handle) =>
  _sdkCoreEngineSdkloggerReleaseHandle(handle);

Pointer<Void> sdkCoreEngineSdkloggerToFfiNullable(SDKLogger? value) =>
  value != null ? sdkCoreEngineSdkloggerToFfi(value) : Pointer<Void>.fromAddress(0);

SDKLogger? sdkCoreEngineSdkloggerFromFfiNullable(Pointer<Void> handle) =>
  handle.address != 0 ? sdkCoreEngineSdkloggerFromFfi(handle) : null;

void sdkCoreEngineSdkloggerReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkCoreEngineSdkloggerReleaseHandle(handle);

// End of SDKLogger "private" section.


