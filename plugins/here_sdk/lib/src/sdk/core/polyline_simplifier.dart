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
import 'package:here_sdk/src/generic_types__conversion.dart';
import 'package:here_sdk/src/sdk/core/errors/instantiation_error_code.dart';
import 'package:here_sdk/src/sdk/core/errors/instantiation_exception.dart';
import 'package:here_sdk/src/sdk/core/geo_coordinates.dart';
import 'package:here_sdk/src/sdk/core/polyline_simplification_callback.dart';
import 'package:here_sdk/src/sdk/core/threading/task_handle.dart';
import 'package:meta/meta.dart';

/// PolylineSimplifier helps to reduce the number of points
/// in the polyline by removing redundant elements using
/// Douglas–Peucker algorithm, so that result stays
/// within [PolylineSimplifierOptions].
///
/// Typical use case is to perform input preparation step
/// before invoking computationally heavy API. Such API
/// have an upper limit on the input collection size
/// and is subject to reduced performance when collection
/// is huge. Examples of such API are:
/// - `TrafficEngine` methods which accept a `GeoCorridor`;
/// - `RoutePrefetcher.prefetchGeoCorridor`.
abstract class PolylineSimplifier implements Finalizable {
  /// Creates a new instance of [PolylineSimplifier].
  ///
  /// Throws [InstantiationException]. Indicates what went wrong when the instantiation was attempted.
  ///
  factory PolylineSimplifier() => $prototype.$init();

  /// Reduces the number of points in the input polyline.
  ///
  /// Does this by removing points which are not significant
  /// according to the passed [PolylineSimplifierOptions].
  /// Simplification process is performed on the device without
  /// connecting to the network and is computationally intensive.
  ///
  /// [polyline] Input polyline that should be reduced in size.
  ///
  /// [simplificationParameters] Strategy, that controls the behavior of the underlying algorithm.
  ///
  /// [callback] Callback, which will be invoked on the main thread,
  /// when operation is finished.
  ///
  /// Returns [TaskHandle]. Controls an asynchronous operation.
  ///
  TaskHandle simplify(List<GeoCoordinates> polyline, PolylineSimplifierOptions simplificationParameters, PolylineSimplificationCallback callback);

  /// @nodoc
  @visibleForTesting
  static dynamic $prototype = PolylineSimplifier$Impl(Pointer<Void>.fromAddress(0));
}

/// Controls the strategy of [PolylineSimplifier.simplify]
/// when reducing a size of polyline.

class PolylineSimplifierOptions {
  /// Sets the upper limit on the resulting collection for
  /// the [PolylineSimplifier.simplify]. Lower
  /// value results in the lower accuracy of the resulting
  /// polyline. If `maxPoints` is less than `2`
  /// then resulting polyline will not have an upper limit
  /// on the size and only [PolylineSimplifierOptions.simplificationToleranceInMeters]
  /// will be considered. When `maxPoints` is greater than
  /// size of the passed polyline then simplification algorithm
  /// will take into account only [PolylineSimplifierOptions.simplificationToleranceInMeters].
  int maxPoints;

  /// Sets the accuracy limit for the [PolylineSimplifier.simplify]:
  /// - higher tolerance results in more simplification (fewer points);
  /// - lower tolerance keeps the line closer to its original shape.
  ///
  /// If removing a point produces polyline, which deviates from the
  /// original one more than `simplificationToleranceInMeters`, then
  /// this point is left in the collection.
  ///
  /// If specified tolerance will not allow to create a polyline
  /// conforming to [PolylineSimplifierOptions.maxPoints], then `simplificationToleranceInMeters`
  /// is ignored.
  ///
  /// Default value is equal to [PolylineSimplifierOptions.simplificationInMeters14ZoomLevel].
  int simplificationToleranceInMeters;

  /// Creates default options with [PolylineSimplifierOptions.maxPoints] equal to 0 and
  /// [PolylineSimplifierOptions.simplificationToleranceInMeters] equal to [PolylineSimplifierOptions.simplificationInMeters14ZoomLevel].
  PolylineSimplifierOptions()
      : maxPoints = 0, simplificationToleranceInMeters = PolylineSimplifierOptions.simplificationInMeters14ZoomLevel;
  /// Creates options with explicitly specified [PolylineSimplifierOptions.maxPoints] and [PolylineSimplifierOptions.simplificationToleranceInMeters].
  /// [maxPoints] Sets the upper limit on the resulting collection for
  /// the [PolylineSimplifier.simplify]. Lower
  /// value results in the lower accuracy of the resulting
  /// polyline. If `maxPoints` is less than `2`
  /// then resulting polyline will not have an upper limit
  /// on the size and only [PolylineSimplifierOptions.simplificationToleranceInMeters]
  /// will be considered. When `maxPoints` is greater than
  /// size of the passed polyline then simplification algorithm
  /// will take into account only [PolylineSimplifierOptions.simplificationToleranceInMeters].
  /// [simplificationToleranceInMeters] Sets the accuracy limit for the [PolylineSimplifier.simplify]:
  /// - higher tolerance results in more simplification (fewer points);
  /// - lower tolerance keeps the line closer to its original shape.
  ///
  /// If removing a point produces polyline, which deviates from the
  /// original one more than `simplificationToleranceInMeters`, then
  /// this point is left in the collection.
  ///
  /// If specified tolerance will not allow to create a polyline
  /// conforming to [PolylineSimplifierOptions.maxPoints], then `simplificationToleranceInMeters`
  /// is ignored.
  ///
  /// Default value is equal to [PolylineSimplifierOptions.simplificationInMeters14ZoomLevel].
  PolylineSimplifierOptions.withMaxPointsAndTolerance(this.maxPoints, this.simplificationToleranceInMeters);
  /// Value for simplification tolerance for 14 zoom level without significant artifacts.
  static final int simplificationInMeters14ZoomLevel = 10;

}


// PolylineSimplifierOptions "private" section, not exported.

final _sdkCorePolylinesimplifierOptionsCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Uint64, Uint64),
    Pointer<Void> Function(int, int)
  >('here_sdk_sdk_core_PolylineSimplifier_Options_create_handle'));
final _sdkCorePolylinesimplifierOptionsReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_core_PolylineSimplifier_Options_release_handle'));
final _sdkCorePolylinesimplifierOptionsGetFieldmaxPoints = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint64 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_core_PolylineSimplifier_Options_get_field_maxPoints'));
final _sdkCorePolylinesimplifierOptionsGetFieldsimplificationToleranceInMeters = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint64 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_core_PolylineSimplifier_Options_get_field_simplificationToleranceInMeters'));



Pointer<Void> sdkCorePolylinesimplifierOptionsToFfi(PolylineSimplifierOptions value) {
  final _maxPointsHandle = (value.maxPoints);
  final _simplificationToleranceInMetersHandle = (value.simplificationToleranceInMeters);
  final _result = _sdkCorePolylinesimplifierOptionsCreateHandle(_maxPointsHandle, _simplificationToleranceInMetersHandle);
  
  
  return _result;
}

PolylineSimplifierOptions sdkCorePolylinesimplifierOptionsFromFfi(Pointer<Void> handle) {
  final _maxPointsHandle = _sdkCorePolylinesimplifierOptionsGetFieldmaxPoints(handle);
  final _simplificationToleranceInMetersHandle = _sdkCorePolylinesimplifierOptionsGetFieldsimplificationToleranceInMeters(handle);
  try {
    return PolylineSimplifierOptions.withMaxPointsAndTolerance(
      (_maxPointsHandle), 
      (_simplificationToleranceInMetersHandle)
    );
  } finally {
    
    
  }
}

void sdkCorePolylinesimplifierOptionsReleaseFfiHandle(Pointer<Void> handle) => _sdkCorePolylinesimplifierOptionsReleaseHandle(handle);

// Nullable PolylineSimplifierOptions

final _sdkCorePolylinesimplifierOptionsCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_PolylineSimplifier_Options_create_handle_nullable'));
final _sdkCorePolylinesimplifierOptionsReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_core_PolylineSimplifier_Options_release_handle_nullable'));
final _sdkCorePolylinesimplifierOptionsGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_PolylineSimplifier_Options_get_value_nullable'));

Pointer<Void> sdkCorePolylinesimplifierOptionsToFfiNullable(PolylineSimplifierOptions? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkCorePolylinesimplifierOptionsToFfi(value);
  final result = _sdkCorePolylinesimplifierOptionsCreateHandleNullable(_handle);
  sdkCorePolylinesimplifierOptionsReleaseFfiHandle(_handle);
  return result;
}

PolylineSimplifierOptions? sdkCorePolylinesimplifierOptionsFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkCorePolylinesimplifierOptionsGetValueNullable(handle);
  final result = sdkCorePolylinesimplifierOptionsFromFfi(_handle);
  sdkCorePolylinesimplifierOptionsReleaseFfiHandle(_handle);
  return result;
}

void sdkCorePolylinesimplifierOptionsReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkCorePolylinesimplifierOptionsReleaseHandleNullable(handle);

// End of PolylineSimplifierOptions "private" section.

// PolylineSimplifier "private" section, not exported.

final _sdkCorePolylinesimplifierRegisterFinalizer = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>, Int32, Handle),
    void Function(Pointer<Void>, int, Object)
  >('here_sdk_sdk_core_PolylineSimplifier_register_finalizer'));
final _sdkCorePolylinesimplifierCopyHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_PolylineSimplifier_copy_handle'));
final _sdkCorePolylinesimplifierReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_core_PolylineSimplifier_release_handle'));


final _$initsdkCorePolylinesimplifierMakeReturnReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_core_PolylineSimplifier_make_return_release_handle'));
final _$initsdkCorePolylinesimplifierMakeReturnGetResult = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_PolylineSimplifier_make_return_get_result'));
final _$initsdkCorePolylinesimplifierMakeReturnGetError = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_core_PolylineSimplifier_make_return_get_error'));
final _$initsdkCorePolylinesimplifierMakeReturnHasError = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint8 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_core_PolylineSimplifier_make_return_has_error'));



/// @nodoc
@visibleForTesting

class PolylineSimplifier$Impl extends __lib.NativeBase implements PolylineSimplifier {

  PolylineSimplifier$Impl(Pointer<Void> handle) : super(handle);


  PolylineSimplifier $init() {
    final _result_handle = _$init();
    final _result = PolylineSimplifier$Impl(_result_handle);

    __lib.cacheInstance(_result_handle, _result);

    _sdkCorePolylinesimplifierRegisterFinalizer(_result_handle, __lib.LibraryContext.isolateId, _result);

    return _result;
  }

  static Pointer<Void> _$init() {
    final _$initFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Int32), Pointer<Void> Function(int)>('here_sdk_sdk_core_PolylineSimplifier_make'));
    final __callResultHandle = _$initFfi(__lib.LibraryContext.isolateId);
    if (_$initsdkCorePolylinesimplifierMakeReturnHasError(__callResultHandle) != 0) {
        final __errorHandle = _$initsdkCorePolylinesimplifierMakeReturnGetError(__callResultHandle);
        _$initsdkCorePolylinesimplifierMakeReturnReleaseHandle(__callResultHandle);
        try {
          throw InstantiationException(sdkCoreErrorsInstantiationerrorcodeFromFfi(__errorHandle));
        } finally {
          sdkCoreErrorsInstantiationerrorcodeReleaseFfiHandle(__errorHandle);
        }
    }
    final __resultHandle = _$initsdkCorePolylinesimplifierMakeReturnGetResult(__callResultHandle);
    _$initsdkCorePolylinesimplifierMakeReturnReleaseHandle(__callResultHandle);
    return __resultHandle;
  }

  @override
  TaskHandle simplify(List<GeoCoordinates> polyline, PolylineSimplifierOptions simplificationParameters, PolylineSimplificationCallback callback) {
    final _simplifyFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>, Pointer<Void>), Pointer<Void> Function(Pointer<Void>, int, Pointer<Void>, Pointer<Void>, Pointer<Void>)>('here_sdk_sdk_core_PolylineSimplifier_simplify__ListOf_sdk_core_GeoCoordinates_Options_PolylineSimplificationCallback'));
    final _polylineHandle = heresdkCoreBindingslistofSdkCoreGeocoordinatesToFfi(polyline);
    final _simplificationParametersHandle = sdkCorePolylinesimplifierOptionsToFfi(simplificationParameters);
    final _callbackHandle = sdkCorePolylinesimplificationcallbackToFfi(callback);
    final _handle = this.handle;
    final __resultHandle = _simplifyFfi(_handle, __lib.LibraryContext.isolateId, _polylineHandle, _simplificationParametersHandle, _callbackHandle);
    heresdkCoreBindingslistofSdkCoreGeocoordinatesReleaseFfiHandle(_polylineHandle);
    sdkCorePolylinesimplifierOptionsReleaseFfiHandle(_simplificationParametersHandle);
    sdkCorePolylinesimplificationcallbackReleaseFfiHandle(_callbackHandle);
    try {
      return sdkCoreThreadingTaskhandleFromFfi(__resultHandle);
    } finally {
      sdkCoreThreadingTaskhandleReleaseFfiHandle(__resultHandle);

    }

  }


}

Pointer<Void> sdkCorePolylinesimplifierToFfi(PolylineSimplifier value) =>
  _sdkCorePolylinesimplifierCopyHandle((value as __lib.NativeBase).handle);

PolylineSimplifier sdkCorePolylinesimplifierFromFfi(Pointer<Void> handle) {
  if (handle.address == 0) throw StateError("Expected non-null value.");
  final instance = __lib.getCachedInstance(handle);
  if (instance != null && instance is PolylineSimplifier) return instance;

  final _copiedHandle = _sdkCorePolylinesimplifierCopyHandle(handle);
  final result = PolylineSimplifier$Impl(_copiedHandle);
  __lib.cacheInstance(_copiedHandle, result);
  _sdkCorePolylinesimplifierRegisterFinalizer(_copiedHandle, __lib.LibraryContext.isolateId, result);
  return result;
}

void sdkCorePolylinesimplifierReleaseFfiHandle(Pointer<Void> handle) =>
  _sdkCorePolylinesimplifierReleaseHandle(handle);

Pointer<Void> sdkCorePolylinesimplifierToFfiNullable(PolylineSimplifier? value) =>
  value != null ? sdkCorePolylinesimplifierToFfi(value) : Pointer<Void>.fromAddress(0);

PolylineSimplifier? sdkCorePolylinesimplifierFromFfiNullable(Pointer<Void> handle) =>
  handle.address != 0 ? sdkCorePolylinesimplifierFromFfi(handle) : null;

void sdkCorePolylinesimplifierReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkCorePolylinesimplifierReleaseHandle(handle);

// End of PolylineSimplifier "private" section.


