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
import 'package:here_sdk/src/generic_types__conversion.dart';
import 'package:here_sdk/src/sdk/core/errors/instantiation_error_code.dart';
import 'package:here_sdk/src/sdk/core/errors/instantiation_exception.dart';
import 'package:here_sdk/src/sdk/core/geo_box.dart';
import 'package:here_sdk/src/sdk/core/geo_coordinates.dart';
import 'package:meta/meta.dart';

final _$initsdkCoreGeopolylineMakeListofSdkCoreGeocoordinatesReturnReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_core_GeoPolyline_make__ListOf_sdk_core_GeoCoordinates_return_release_handle'));
final _$initsdkCoreGeopolylineMakeListofSdkCoreGeocoordinatesReturnGetResult = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_GeoPolyline_make__ListOf_sdk_core_GeoCoordinates_return_get_result'));
final _$initsdkCoreGeopolylineMakeListofSdkCoreGeocoordinatesReturnGetError = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_core_GeoPolyline_make__ListOf_sdk_core_GeoCoordinates_return_get_error'));
final _$initsdkCoreGeopolylineMakeListofSdkCoreGeocoordinatesReturnHasError = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint8 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_core_GeoPolyline_make__ListOf_sdk_core_GeoCoordinates_return_has_error'));




/// A list of geographic coordinates representing the vertices of a polyline.
///
/// An instance of this class, initialized with appropriate vertices.
/// Represents a GeoPolyline as a series of geographic coordinates.
@immutable
class GeoPolyline {
  /// The list of vertices representing the polyline.
  final List<GeoCoordinates> vertices;

  /// Creates a new instance.

  /// [vertices] The list of vertices representing the polyline.

  const GeoPolyline._(this.vertices);
  /// Constructs a GeoPolyline from the provided vertices.
  ///
  /// Throws an InstantiationError if the number of vertices is less than two.
  ///
  /// [vertices] List of vertices representing the polyline.
  ///
  /// Throws [InstantiationException]. Instantiation error.
  ///
  factory GeoPolyline(List<GeoCoordinates> vertices) => $prototype.$init(vertices);
  /// Constructs an instance of this class from GeoBox.
  ///
  /// [geoBox] A [GeoBox] to be converted into [GeoPolyline].
  ///
  factory GeoPolyline.withGeoBox(GeoBox geoBox) => $prototype.withGeoBox(geoBox);
  /// Returns the index of the nearest vertex to the given point.
  ///
  /// [point] Coordinates of the point.
  ///
  /// Returns [int]. Index of the closest vertex of the polyline.
  ///
  int getNearestIndexTo(GeoCoordinates point) => $prototype.getNearestIndexTo(this, point);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GeoPolyline) return false;
    GeoPolyline _other = other;
    return DeepCollectionEquality().equals(vertices, _other.vertices);
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + DeepCollectionEquality().hash(vertices);
    return result;
  }

  /// @nodoc
  @visibleForTesting
  static dynamic $prototype = GeoPolyline$Impl();
}


// GeoPolyline "private" section, not exported.

final _sdkCoreGeopolylineCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_GeoPolyline_create_handle'));
final _sdkCoreGeopolylineReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_core_GeoPolyline_release_handle'));
final _sdkCoreGeopolylineGetFieldvertices = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_GeoPolyline_get_field_vertices'));



/// @nodoc
@visibleForTesting
class GeoPolyline$Impl {
  GeoPolyline $init(List<GeoCoordinates> vertices) {
    final _$initFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Int32, Pointer<Void>), Pointer<Void> Function(int, Pointer<Void>)>('here_sdk_sdk_core_GeoPolyline_make__ListOf_sdk_core_GeoCoordinates'));
    final _verticesHandle = coreTypeslistofSdkCoreGeocoordinatesToFfi(vertices);
    final __callResultHandle = _$initFfi(__lib.LibraryContext.isolateId, _verticesHandle);
    coreTypeslistofSdkCoreGeocoordinatesReleaseFfiHandle(_verticesHandle);
    if (_$initsdkCoreGeopolylineMakeListofSdkCoreGeocoordinatesReturnHasError(__callResultHandle) != 0) {
        final __errorHandle = _$initsdkCoreGeopolylineMakeListofSdkCoreGeocoordinatesReturnGetError(__callResultHandle);
        _$initsdkCoreGeopolylineMakeListofSdkCoreGeocoordinatesReturnReleaseHandle(__callResultHandle);
        try {
          throw InstantiationException(sdkCoreErrorsInstantiationerrorcodeFromFfi(__errorHandle));
        } finally {
          sdkCoreErrorsInstantiationerrorcodeReleaseFfiHandle(__errorHandle);
        }
    }
    final __resultHandle = _$initsdkCoreGeopolylineMakeListofSdkCoreGeocoordinatesReturnGetResult(__callResultHandle);
    _$initsdkCoreGeopolylineMakeListofSdkCoreGeocoordinatesReturnReleaseHandle(__callResultHandle);
    try {
      return sdkCoreGeopolylineFromFfi(__resultHandle);
    } finally {
      sdkCoreGeopolylineReleaseFfiHandle(__resultHandle);

    }

  }

  GeoPolyline withGeoBox(GeoBox geoBox) {
    final _withGeoBoxFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Int32, Pointer<Void>), Pointer<Void> Function(int, Pointer<Void>)>('here_sdk_sdk_core_GeoPolyline_make__GeoBox'));
    final _geoBoxHandle = sdkCoreGeoboxToFfi(geoBox);
    final __resultHandle = _withGeoBoxFfi(__lib.LibraryContext.isolateId, _geoBoxHandle);
    sdkCoreGeoboxReleaseFfiHandle(_geoBoxHandle);
    try {
      return sdkCoreGeopolylineFromFfi(__resultHandle);
    } finally {
      sdkCoreGeopolylineReleaseFfiHandle(__resultHandle);

    }

  }

  int getNearestIndexTo(GeoPolyline $that, GeoCoordinates point) {
    final _getNearestIndexToFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Uint32 Function(Pointer<Void>, Int32, Pointer<Void>), int Function(Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_core_GeoPolyline_getNearestIndexTo__GeoCoordinates'));
    final _pointHandle = sdkCoreGeocoordinatesToFfi(point);
    final _handle = sdkCoreGeopolylineToFfi($that);
    final __resultHandle = _getNearestIndexToFfi(_handle, __lib.LibraryContext.isolateId, _pointHandle);
    sdkCoreGeopolylineReleaseFfiHandle(_handle);
    sdkCoreGeocoordinatesReleaseFfiHandle(_pointHandle);
    try {
      return (__resultHandle);
    } finally {


    }

  }

}

Pointer<Void> sdkCoreGeopolylineToFfi(GeoPolyline value) {
  final _verticesHandle = coreTypeslistofSdkCoreGeocoordinatesToFfi(value.vertices);
  final _result = _sdkCoreGeopolylineCreateHandle(_verticesHandle);
  coreTypeslistofSdkCoreGeocoordinatesReleaseFfiHandle(_verticesHandle);
  return _result;
}

GeoPolyline sdkCoreGeopolylineFromFfi(Pointer<Void> handle) {
  final _verticesHandle = _sdkCoreGeopolylineGetFieldvertices(handle);
  try {
    return GeoPolyline._(
      coreTypeslistofSdkCoreGeocoordinatesFromFfi(_verticesHandle)
    );
  } finally {
    coreTypeslistofSdkCoreGeocoordinatesReleaseFfiHandle(_verticesHandle);
  }
}

void sdkCoreGeopolylineReleaseFfiHandle(Pointer<Void> handle) => _sdkCoreGeopolylineReleaseHandle(handle);

// Nullable GeoPolyline

final _sdkCoreGeopolylineCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_GeoPolyline_create_handle_nullable'));
final _sdkCoreGeopolylineReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_core_GeoPolyline_release_handle_nullable'));
final _sdkCoreGeopolylineGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_GeoPolyline_get_value_nullable'));

Pointer<Void> sdkCoreGeopolylineToFfiNullable(GeoPolyline? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkCoreGeopolylineToFfi(value);
  final result = _sdkCoreGeopolylineCreateHandleNullable(_handle);
  sdkCoreGeopolylineReleaseFfiHandle(_handle);
  return result;
}

GeoPolyline? sdkCoreGeopolylineFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkCoreGeopolylineGetValueNullable(handle);
  final result = sdkCoreGeopolylineFromFfi(_handle);
  sdkCoreGeopolylineReleaseFfiHandle(_handle);
  return result;
}

void sdkCoreGeopolylineReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkCoreGeopolylineReleaseHandleNullable(handle);

// End of GeoPolyline "private" section.


