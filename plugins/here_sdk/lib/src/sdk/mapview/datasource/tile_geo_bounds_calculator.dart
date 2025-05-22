// Copyright (c) 2019-2024 HERE Global B.V. and its affiliate(s).
// All rights reserved.
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
import 'package:here_sdk/src/sdk/core/geo_box.dart';
import 'package:here_sdk/src/sdk/mapview/datasource/tile_key.dart';
import 'package:here_sdk/src/sdk/mapview/datasource/tiling_scheme.dart';
import 'package:meta/meta.dart';

/// A calculator of geodetic bounds for tiles identified by keys generated
/// in a particular tiling scheme ([TilingScheme]).
///
/// Note: This is a beta release of this feature, so there could be a few bugs and unexpected
/// behavior. Related APIs may change for new releases without a deprecation process.
abstract class TileGeoBoundsCalculator implements Finalizable {
  /// Creates an instance of [TileGeoBoundsCalculator].
  ///
  /// [tilingScheme] The tiling scheme used for generating the tile keys that are to be supported by this instance.
  ///
  factory TileGeoBoundsCalculator(TilingScheme tilingScheme) => $prototype.create(tilingScheme);

  /// Computes the geodetic bounds (as [GeoBox]) for a tile identified by [TileKey].
  ///
  /// [tileKey] [TileKey] to compute geodetic bounds for.
  /// The geodetic bounds would be calculated relative to the tiling scheme
  /// provided at this [TileGeoBoundsCalculator] instance creation.
  ///
  /// Returns [GeoBox]. The geodetic bounds of tile identified by given [TileKey].
  ///
  GeoBox boundsOf(TileKey tileKey);

  /// @nodoc
  @visibleForTesting
  static dynamic $prototype = TileGeoBoundsCalculator$Impl(Pointer<Void>.fromAddress(0));
}


// TileGeoBoundsCalculator "private" section, not exported.

final _sdkMapviewDatasourceTilegeoboundscalculatorRegisterFinalizer = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>, Int32, Handle),
    void Function(Pointer<Void>, int, Object)
  >('here_sdk_sdk_mapview_datasource_TileGeoBoundsCalculator_register_finalizer'));
final _sdkMapviewDatasourceTilegeoboundscalculatorCopyHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_datasource_TileGeoBoundsCalculator_copy_handle'));
final _sdkMapviewDatasourceTilegeoboundscalculatorReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_datasource_TileGeoBoundsCalculator_release_handle'));




/// @nodoc
@visibleForTesting

class TileGeoBoundsCalculator$Impl extends __lib.NativeBase implements TileGeoBoundsCalculator {

  TileGeoBoundsCalculator$Impl(Pointer<Void> handle) : super(handle);


  TileGeoBoundsCalculator create(TilingScheme tilingScheme) {
    final _result_handle = _create(tilingScheme);
    final _result = TileGeoBoundsCalculator$Impl(_result_handle);

    __lib.cacheInstance(_result_handle, _result);

    _sdkMapviewDatasourceTilegeoboundscalculatorRegisterFinalizer(_result_handle, __lib.LibraryContext.isolateId, _result);

    return _result;
  }

  static Pointer<Void> _create(TilingScheme tilingScheme) {
    final _createFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Int32, Uint32), Pointer<Void> Function(int, int)>('here_sdk_sdk_mapview_datasource_TileGeoBoundsCalculator_create__TilingScheme'));
    final _tilingSchemeHandle = sdkMapviewDatasourceTilingschemeToFfi(tilingScheme);
    final __resultHandle = _createFfi(__lib.LibraryContext.isolateId, _tilingSchemeHandle);
    sdkMapviewDatasourceTilingschemeReleaseFfiHandle(_tilingSchemeHandle);
    return __resultHandle;
  }

  @override
  GeoBox boundsOf(TileKey tileKey) {
    final _boundsOfFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Pointer<Void>, Int32, Pointer<Void>), Pointer<Void> Function(Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_mapview_datasource_TileGeoBoundsCalculator_boundsOf__TileKey'));
    final _tileKeyHandle = sdkMapviewDatasourceTilekeyToFfi(tileKey);
    final _handle = this.handle;
    final __resultHandle = _boundsOfFfi(_handle, __lib.LibraryContext.isolateId, _tileKeyHandle);
    sdkMapviewDatasourceTilekeyReleaseFfiHandle(_tileKeyHandle);
    try {
      return sdkCoreGeoboxFromFfi(__resultHandle);
    } finally {
      sdkCoreGeoboxReleaseFfiHandle(__resultHandle);

    }

  }


}

Pointer<Void> sdkMapviewDatasourceTilegeoboundscalculatorToFfi(TileGeoBoundsCalculator value) =>
  _sdkMapviewDatasourceTilegeoboundscalculatorCopyHandle((value as __lib.NativeBase).handle);

TileGeoBoundsCalculator sdkMapviewDatasourceTilegeoboundscalculatorFromFfi(Pointer<Void> handle) {
  if (handle.address == 0) throw StateError("Expected non-null value.");
  final instance = __lib.getCachedInstance(handle);
  if (instance != null && instance is TileGeoBoundsCalculator) return instance;

  final _copiedHandle = _sdkMapviewDatasourceTilegeoboundscalculatorCopyHandle(handle);
  final result = TileGeoBoundsCalculator$Impl(_copiedHandle);
  __lib.cacheInstance(_copiedHandle, result);
  _sdkMapviewDatasourceTilegeoboundscalculatorRegisterFinalizer(_copiedHandle, __lib.LibraryContext.isolateId, result);
  return result;
}

void sdkMapviewDatasourceTilegeoboundscalculatorReleaseFfiHandle(Pointer<Void> handle) =>
  _sdkMapviewDatasourceTilegeoboundscalculatorReleaseHandle(handle);

Pointer<Void> sdkMapviewDatasourceTilegeoboundscalculatorToFfiNullable(TileGeoBoundsCalculator? value) =>
  value != null ? sdkMapviewDatasourceTilegeoboundscalculatorToFfi(value) : Pointer<Void>.fromAddress(0);

TileGeoBoundsCalculator? sdkMapviewDatasourceTilegeoboundscalculatorFromFfiNullable(Pointer<Void> handle) =>
  handle.address != 0 ? sdkMapviewDatasourceTilegeoboundscalculatorFromFfi(handle) : null;

void sdkMapviewDatasourceTilegeoboundscalculatorReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkMapviewDatasourceTilegeoboundscalculatorReleaseHandle(handle);

// End of TileGeoBoundsCalculator "private" section.


