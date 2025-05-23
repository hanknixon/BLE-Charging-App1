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
import 'package:here_sdk/src/builtin_types__conversion.dart';
import 'package:here_sdk/src/generic_types__conversion.dart';
import 'package:here_sdk/src/sdk/core/geo_coordinates.dart';
import 'package:here_sdk/src/sdk/core/metadata.dart';
import 'package:here_sdk/src/sdk/mapview/map_image.dart';
import 'package:here_sdk/src/sdk/mapview/map_marker3_d_model.dart';
import 'package:here_sdk/src/sdk/mapview/map_measure_range.dart';
import 'package:here_sdk/src/sdk/mapview/render_size.dart';
import 'package:meta/meta.dart';

/// Represents a 3D shape drawn on the map at specified geodetic coordinates.
///
/// It can have a solid color or be textured, depending on the data from
/// [MapMarker3DModel].
///
/// By default, a 3D marker is drawn on top of all map content, including
/// 3D map elements like extruded buildings or 3D landmarks. This can be
/// changed by enabling depth check using [MapMarker3D.isDepthCheckEnabled].
///
/// The display of a 3D marker is only guaranteed in case its origin is within
/// the viewport. At the moment, this is a known limitation that mostly affects
/// a 3D marker that is visually large and covers a sizeable part of the viewport.
///
/// # Sizing and scaling
///
/// Two aspects determine how big the `MapMarker3D` will be on the screen
/// and how will it behave when the map is zoomed in and out.
///
/// The first, and most impactful is [RenderSizeUnit], which specifies
/// how the vertex coordinates of the 3D model are interpreted.
/// Most importantly, it specifies whether the 3D model is placed
/// in world or screen coordinate space.
///
/// [RenderSizeUnit.meters] will make the 3D model use world
/// coordinate space, meaning that it will change size together with the map
/// when it is zoomed in and out.
///
/// [RenderSizeUnit.pixels] makes the 3D model use screen coordinate space,
/// meaning that it will have constant size on the screen regardless
/// of how the map zoom changes. So a simple 10 by 10 (in model space) rectangle
/// will have a size of 10 by 10 pixels on the screen.
///
/// [RenderSizeUnit.densityIndependentPixels] is similar to pixels,
/// but the resulting size will take into account the pixel density of the
/// display, meaning that physical size on the screen will be approximately
/// the same regardless of the size or resolution of the display.
///
/// The second aspect that determines size of `MapMarker3D` is scale.
/// It can be specified at construction time and can be changed later
/// at any time using [MapMarker3D.scale].
///
/// # Modifying at runtime
///
/// A 3D marker can be moved around a map by updating its coordinates using
/// [MapMarker3D.coordinates].
///
/// Altitude component of the coordinates, if set, controls 3D marker's elevation
/// above ground. If not set, the 3D marker is placed at ground level.
///
/// Its orientation is specified by bearing, pitch and roll and can be changed
/// by using [MapMarker3D.bearing], [MapMarker3D.pitch]
/// and [MapMarker3D.roll].
///
/// # Flat marker
///
/// A flat marker is a special case of a 3D marker, where the 3D shape being drawn
/// is a simple textured rectangle. In essence it's an image drawn "on the ground".
/// Such 3D marker can be conveniently created using
/// [MapMarker3D.fromImage]
/// constructor. Of course, once created, it can be rotated to face any direction.
abstract class MapMarker3D implements Finalizable {
  /// Creates an instance of a 3D marker.
  ///
  /// The origin of the 3D model's local coordinate system is placed at the specified
  /// geographical coordinates.
  ///
  /// Altitude component of the coordinates, if set, controls 3D marker's elevation
  /// above ground. If not set, the 3D marker is placed at ground level.
  ///
  /// [at] The geographical coordinates where the 3D marker is placed corresponding to origin of the
  /// 3D model's local coordinate system.
  ///
  /// [model] The 3D model used to draw 3D marker.
  ///
  factory MapMarker3D(GeoCoordinates at, MapMarker3DModel model) => $prototype.$init(at, model);
  /// Creates a flat marker from provided map image.
  ///
  /// Such map marker is a flat 3D marker of rectangular shape textured with given image.
  /// Aspect ratio of the flat marker is determined by aspect ratio of the image.
  ///
  /// Only bitmap images are supported, using a [MapImage] created from SVG data
  /// will result in distorted rendering of the flat marker.
  ///
  /// Altitude component of the coordinates, if set, controls 3D marker's elevation
  /// above ground. If not set, the 3D marker is placed at ground level.
  ///
  /// Size of the rendered flat marker can be specified in either world or screen coordinate space.
  ///
  /// For [RenderSizeUnit.pixels], the flat marker will cover [MapMarker3D.fromImage.scale] * image's width pixels
  /// horizontally and [MapMarker3D.fromImage.scale] * image's height pixels vertically. The size of the flat marker
  /// remains constant on the screen.
  ///
  /// For [RenderSizeUnit.densityIndependentPixels] the flat marker will cover [MapMarker3D.fromImage.scale] *
  /// image's width density independent pixels horizontally and [MapMarker3D.fromImage.scale] * image's height
  /// density independent pixels vertically. The size of the flat marker remains constant on
  /// the screen.
  ///
  /// For [RenderSizeUnit.meters] the flat marker will cover [MapMarker3D.fromImage.scale] * image's width meters
  /// horizontally and [MapMarker3D.fromImage.scale] * image's height meters vertically. Unlike with pixels or
  /// density independent pixels the size of the flat marker will grow and shrink together
  /// with regular map content like streets or buildings.
  ///
  /// [at] The geographical coordinates where the flat marker is placed corresponding to center of the
  /// provided map image.
  ///
  /// [image] The MapImage containing the texture data of the flat marker. SVG images are not supported.
  ///
  /// [scale] Scale factor applied to the dimensions of the image.
  ///
  /// [unit] Determines whether the size of the flat marker is represented in world or in screen space.
  ///
  factory MapMarker3D.fromImage(GeoCoordinates at, MapImage image, double scale, RenderSizeUnit unit) => $prototype.fromImage(at, image, scale, unit);
  /// Creates an instance of a 3D marker with scale factor.
  ///
  /// One unit of the 3D marker model will cover [MapMarker3D.withScale.scale] pixels.
  /// The size of the 3D marker remains constant on the screen.
  ///
  /// The origin of the 3D model's local coordinate system is placed at the specified
  /// geographical coordinates.
  ///
  /// Altitude component of the coordinates, if set, controls 3D marker's elevation
  /// above ground. If not set, the 3D marker is placed at ground level.
  ///
  /// [at] The geographical coordinates where the 3D marker is placed corresponding to origin of the
  /// 3D model's local coordinate system.
  ///
  /// [model] The 3D model used to render the 3D marker.
  ///
  /// [scale] Scale factor to apply to the 3D model.
  ///
  factory MapMarker3D.withScale(GeoCoordinates at, MapMarker3DModel model, double scale) => $prototype.withScale(at, model, scale);
  /// Creates a new 3D marker at given world coordinates, using the supplied 3D model.
  ///
  /// The unit specifies how the 3D geometry of the model is interpreted (meters for world space,
  /// pixels or density independent pixels for screen space), while scale determines its relative size.
  ///
  /// For [RenderSizeUnit.pixels] one unit of the 3D marker model will cover [MapMarker3D.withUnit.scale] pixels.
  /// The size of the 3D marker remains constant on the screen.
  ///
  /// For [RenderSizeUnit.densityIndependentPixels] one unit of the 3D marker model will
  /// cover [MapMarker3D.withUnit.scale] density independent pixels. The size of the 3D marker remains constant on
  /// the screen.
  ///
  /// For [RenderSizeUnit.meters] one unit of the 3D marker model will cover [MapMarker3D.withUnit.scale] meters
  /// in the real world. Unlike with pixels or density-independent pixels the size of the
  /// 3D marker will grow and shrink together with regular map content like streets or buildings.
  ///
  /// The origin of the 3D model's local coordinate system is placed at the specified
  /// geographical coordinates.
  ///
  /// Altitude component of the coordinates, if set, controls 3D marker's elevation
  /// above ground. If not set, the 3D marker is placed at ground level.
  ///
  /// [at] The geographical coordinates where the 3D marker is placed corresponding to origin of the
  /// 3D model's local coordinate system.
  ///
  /// [model] The 3D model used to render the 3D marker.
  ///
  /// [scale] Scale factor to apply to the 3D model.
  ///
  /// [unit] Determines the unit of the model vertices and whether the size of the 3D marker
  /// is expressed in world or screen space.
  ///
  factory MapMarker3D.withUnit(GeoCoordinates at, MapMarker3DModel model, double scale, RenderSizeUnit unit) => $prototype.withUnit(at, model, scale, unit);

  /// The position of the 3D marker on the map corresponding to the origin of the 3D marker model coordinate system.
  /// The altitude component of the coordinates, if set, controls 3D marker's elevation
  /// above ground. If not set, the 3D marker is placed at ground level.
  /// Gets the 3D marker's position on the map corresponding to the origin of the 3D marker model
  /// coordinate system.
  GeoCoordinates get coordinates;
  /// The position of the 3D marker on the map corresponding to the origin of the 3D marker model coordinate system.
  /// The altitude component of the coordinates, if set, controls 3D marker's elevation
  /// above ground. If not set, the 3D marker is placed at ground level.
  /// Sets the 3D marker's position on the map corresponding to the origin of the 3D marker model
  /// coordinate system.
  set coordinates(GeoCoordinates value);

  /// The [Metadata] instance attached to this 3D marker.
  /// Gets the [Metadata] instance attached to this 3D marker.
  /// The default value is `null`.
  Metadata? get metadata;
  /// The [Metadata] instance attached to this 3D marker.
  /// Sets the [Metadata] instance attached to this 3D marker.
  set metadata(Metadata? value);

  /// The bearing of the 3D model in degrees, from the true north in clockwise direction.
  /// The bearing axis is perpendicular to the ground and passes through the 3D marker's location.
  /// The Z-axis of the model is aligned with bearing axis.
  /// Gets the bearing of the 3D model in degrees.
  double get bearing;
  /// The bearing of the 3D model in degrees, from the true north in clockwise direction.
  /// The bearing axis is perpendicular to the ground and passes through the 3D marker's location.
  /// The Z-axis of the model is aligned with bearing axis.
  /// Sets the bearing of the 3D model in degrees.
  set bearing(double value);

  /// The roll angle of the 3D model in degrees.
  /// The roll axis is parallel to the ground, passes through the 3D marker's
  /// location and is aligned initially with the true north. However, when the bearing changes,
  /// it rotates around the bearing axis with the 3D marker.
  /// Positive/negative values cause a clockwise/counterclockwise rotation when viewing along the axis
  /// in the direction of the true north. The Y-axis of the model is aligned with the roll axis.
  /// Gets the roll of the 3D model in degrees.
  double get roll;
  /// The roll angle of the 3D model in degrees.
  /// The roll axis is parallel to the ground, passes through the 3D marker's
  /// location and is aligned initially with the true north. However, when the bearing changes,
  /// it rotates around the bearing axis with the 3D marker.
  /// Positive/negative values cause a clockwise/counterclockwise rotation when viewing along the axis
  /// in the direction of the true north. The Y-axis of the model is aligned with the roll axis.
  /// Sets the roll of the 3D model in degrees.
  set roll(double value);

  /// The pitch of the 3D model in degrees.
  /// The pitch axis is parallel to the ground, passes through the location of the 3D marker
  /// and aligns with the longitude axis if the bearing is 0. However, this axis rotates with
  /// the 3D marker according to the bearing value. Negative values cause the top of the
  /// 3D marker to lean forward. The X-axis of the model is aligned with pitch axis.
  /// Gets the pitch of the 3D model in degrees.
  double get pitch;
  /// The pitch of the 3D model in degrees.
  /// The pitch axis is parallel to the ground, passes through the location of the 3D marker
  /// and aligns with the longitude axis if the bearing is 0. However, this axis rotates with
  /// the 3D marker according to the bearing value. Negative values cause the top of the
  /// 3D marker to lean forward. The X-axis of the model is aligned with pitch axis.
  /// Sets the pitch of the 3D model in degrees.
  set pitch(double value);

  /// Scale factor applied to the 3D model before rendering.
  /// Gets the scale factor applied to the 3D model before rendering.
  double get scale;
  /// Scale factor applied to the 3D model before rendering.
  /// Sets the scale factor, to be applied to the 3D model before rendering.
  set scale(double value);

  /// Determines whether the depth of the 3D marker's vertices is considered during rendering.
  /// If set to `false`, the 3D marker will always appear in front of any other map objects.
  /// If set to `true` the 3D marker might be occluded by other map objects like extruded buildings.
  ///
  /// By default depth check is set to `false`.
  ///
  /// Use the altitude of the [MapMarker3D.coordinates] to position the 3D marker sufficiently high above the
  /// surface. Setting depth check to `true` will fix visual glitches where components of the marker
  /// 3D model unexpectedly shine through.
  /// Returns `true` if depth check is enabled.
  bool get isDepthCheckEnabled;
  /// Determines whether the depth of the 3D marker's vertices is considered during rendering.
  /// If set to `false`, the 3D marker will always appear in front of any other map objects.
  /// If set to `true` the 3D marker might be occluded by other map objects like extruded buildings.
  ///
  /// By default depth check is set to `false`.
  ///
  /// Use the altitude of the [MapMarker3D.coordinates] to position the 3D marker sufficiently high above the
  /// surface. Setting depth check to `true` will fix visual glitches where components of the marker
  /// 3D model unexpectedly shine through.
  /// Set whether the depth of the 3D marker's vertices is considered during rendering.
  set isDepthCheckEnabled(bool value);

  /// Indicates whether to render internal geometry of a 3D marker occluded by its front facing polygons.
  /// Default value is `false`. Can be used with translucent 3D marker.
  ///
  /// Note: with this flag enabled for 3D marker with depth check enabled, rendering is performed in two
  /// passes: first pass with front-face, second pass with back-face culling enabled.
  /// With this flag enabled for 3D marker with depth check disabled rendering is performed in a
  /// single pass with back-face culling disabled.
  /// Returns a flag indicating whether to render internal geometry of a 3D marker occluded by its front
  /// facing polygons. Default value is `false`.
  bool get isRenderInternalsEnabled;
  /// Indicates whether to render internal geometry of a 3D marker occluded by its front facing polygons.
  /// Default value is `false`. Can be used with translucent 3D marker.
  ///
  /// Note: with this flag enabled for 3D marker with depth check enabled, rendering is performed in two
  /// passes: first pass with front-face, second pass with back-face culling enabled.
  /// With this flag enabled for 3D marker with depth check disabled rendering is performed in a
  /// single pass with back-face culling disabled.
  /// Sets a flag indicating whether to render internal geometry of a 3D marker occluded by its front
  /// facing polygons.
  set isRenderInternalsEnabled(bool value);

  /// The opacity factor adjusting the opacity of a 3D marker.
  /// The factor is applied to the alpha channel of the resulting texture of the marker.
  /// Default value is 1.0 meaning marker is displayed with the default opacity of the texture image or the
  /// specified fill color specified
  /// in [MapMarker3DModel].
  /// Returns an opacity factor which specifies the translucency of a 3D map marker.
  double get opacity;
  /// The opacity factor adjusting the opacity of a 3D marker.
  /// The factor is applied to the alpha channel of the resulting texture of the marker.
  /// Default value is 1.0 meaning marker is displayed with the default opacity of the texture image or the
  /// specified fill color specified
  /// in [MapMarker3DModel].
  /// Sets an opacity factor which specifies the translucency of a 3D map marker.
  ///
  /// Provided value is clamped to the \[0.0, 1.0\] range.
  set opacity(double value);

  /// The list of visibility ranges. The 3D marker is visible only inside these map measure ranges.
  /// A range is half open - \[minimumZoomLevel, maximumZoomLevel), the given maximum value
  /// is not contained in the range.
  ///
  /// When empty (the default), the 3D marker is visible without map measure restrictions.
  /// Only [MapMeasureRange](s) of [MapMeasureKind.zoomLevel] type are supported.
  /// [MapMeasureRange](s) of other unsupported types will be ignored.
  /// Gets the list of visibility ranges.
  List<MapMeasureRange> get visibilityRanges;
  /// The list of visibility ranges. The 3D marker is visible only inside these map measure ranges.
  /// A range is half open - \[minimumZoomLevel, maximumZoomLevel), the given maximum value
  /// is not contained in the range.
  ///
  /// When empty (the default), the 3D marker is visible without map measure restrictions.
  /// Only [MapMeasureRange](s) of [MapMeasureKind.zoomLevel] type are supported.
  /// [MapMeasureRange](s) of other unsupported types will be ignored.
  /// Sets visibility ranges for this 3D marker.
  set visibilityRanges(List<MapMeasureRange> value);


  /// @nodoc
  @visibleForTesting
  static dynamic $prototype = MapMarker3D$Impl(Pointer<Void>.fromAddress(0));
}


// MapMarker3D "private" section, not exported.

final _sdkMapviewMapmarker3dRegisterFinalizer = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>, Int32, Handle),
    void Function(Pointer<Void>, int, Object)
  >('here_sdk_sdk_mapview_MapMarker3D_register_finalizer'));
final _sdkMapviewMapmarker3dCopyHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_MapMarker3D_copy_handle'));
final _sdkMapviewMapmarker3dReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_MapMarker3D_release_handle'));






/// @nodoc
@visibleForTesting

class MapMarker3D$Impl extends __lib.NativeBase implements MapMarker3D {

  MapMarker3D$Impl(Pointer<Void> handle) : super(handle);


  MapMarker3D $init(GeoCoordinates at, MapMarker3DModel model) {
    final _result_handle = _$init(at, model);
    final _result = MapMarker3D$Impl(_result_handle);

    __lib.cacheInstance(_result_handle, _result);

    _sdkMapviewMapmarker3dRegisterFinalizer(_result_handle, __lib.LibraryContext.isolateId, _result);

    return _result;
  }


  MapMarker3D fromImage(GeoCoordinates at, MapImage image, double scale, RenderSizeUnit unit) {
    final _result_handle = _fromImage(at, image, scale, unit);
    final _result = MapMarker3D$Impl(_result_handle);

    __lib.cacheInstance(_result_handle, _result);

    _sdkMapviewMapmarker3dRegisterFinalizer(_result_handle, __lib.LibraryContext.isolateId, _result);

    return _result;
  }


  MapMarker3D withScale(GeoCoordinates at, MapMarker3DModel model, double scale) {
    final _result_handle = _withScale(at, model, scale);
    final _result = MapMarker3D$Impl(_result_handle);

    __lib.cacheInstance(_result_handle, _result);

    _sdkMapviewMapmarker3dRegisterFinalizer(_result_handle, __lib.LibraryContext.isolateId, _result);

    return _result;
  }


  MapMarker3D withUnit(GeoCoordinates at, MapMarker3DModel model, double scale, RenderSizeUnit unit) {
    final _result_handle = _withUnit(at, model, scale, unit);
    final _result = MapMarker3D$Impl(_result_handle);

    __lib.cacheInstance(_result_handle, _result);

    _sdkMapviewMapmarker3dRegisterFinalizer(_result_handle, __lib.LibraryContext.isolateId, _result);

    return _result;
  }

  static Pointer<Void> _$init(GeoCoordinates at, MapMarker3DModel model) {
    final _$initFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Int32, Pointer<Void>, Pointer<Void>), Pointer<Void> Function(int, Pointer<Void>, Pointer<Void>)>('here_sdk_sdk_mapview_MapMarker3D_make__GeoCoordinates_MapMarker3DModel'));
    final _atHandle = sdkCoreGeocoordinatesToFfi(at);
    final _modelHandle = sdkMapviewMapmarker3dmodelToFfi(model);
    final __resultHandle = _$initFfi(__lib.LibraryContext.isolateId, _atHandle, _modelHandle);
    sdkCoreGeocoordinatesReleaseFfiHandle(_atHandle);
    sdkMapviewMapmarker3dmodelReleaseFfiHandle(_modelHandle);
    return __resultHandle;
  }

  static Pointer<Void> _fromImage(GeoCoordinates at, MapImage image, double scale, RenderSizeUnit unit) {
    final _fromImageFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Int32, Pointer<Void>, Pointer<Void>, Double, Uint32), Pointer<Void> Function(int, Pointer<Void>, Pointer<Void>, double, int)>('here_sdk_sdk_mapview_MapMarker3D_make__GeoCoordinates_MapImage_Double_Unit'));
    final _atHandle = sdkCoreGeocoordinatesToFfi(at);
    final _imageHandle = sdkMapviewMapimageToFfi(image);
    final _scaleHandle = (scale);
    final _unitHandle = sdkMapviewRendersizeUnitToFfi(unit);
    final __resultHandle = _fromImageFfi(__lib.LibraryContext.isolateId, _atHandle, _imageHandle, _scaleHandle, _unitHandle);
    sdkCoreGeocoordinatesReleaseFfiHandle(_atHandle);
    sdkMapviewMapimageReleaseFfiHandle(_imageHandle);

    sdkMapviewRendersizeUnitReleaseFfiHandle(_unitHandle);
    return __resultHandle;
  }

  static Pointer<Void> _withScale(GeoCoordinates at, MapMarker3DModel model, double scale) {
    final _withScaleFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Int32, Pointer<Void>, Pointer<Void>, Double), Pointer<Void> Function(int, Pointer<Void>, Pointer<Void>, double)>('here_sdk_sdk_mapview_MapMarker3D_make__GeoCoordinates_MapMarker3DModel_Double'));
    final _atHandle = sdkCoreGeocoordinatesToFfi(at);
    final _modelHandle = sdkMapviewMapmarker3dmodelToFfi(model);
    final _scaleHandle = (scale);
    final __resultHandle = _withScaleFfi(__lib.LibraryContext.isolateId, _atHandle, _modelHandle, _scaleHandle);
    sdkCoreGeocoordinatesReleaseFfiHandle(_atHandle);
    sdkMapviewMapmarker3dmodelReleaseFfiHandle(_modelHandle);

    return __resultHandle;
  }

  static Pointer<Void> _withUnit(GeoCoordinates at, MapMarker3DModel model, double scale, RenderSizeUnit unit) {
    final _withUnitFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Int32, Pointer<Void>, Pointer<Void>, Double, Uint32), Pointer<Void> Function(int, Pointer<Void>, Pointer<Void>, double, int)>('here_sdk_sdk_mapview_MapMarker3D_make__GeoCoordinates_MapMarker3DModel_Double_Unit'));
    final _atHandle = sdkCoreGeocoordinatesToFfi(at);
    final _modelHandle = sdkMapviewMapmarker3dmodelToFfi(model);
    final _scaleHandle = (scale);
    final _unitHandle = sdkMapviewRendersizeUnitToFfi(unit);
    final __resultHandle = _withUnitFfi(__lib.LibraryContext.isolateId, _atHandle, _modelHandle, _scaleHandle, _unitHandle);
    sdkCoreGeocoordinatesReleaseFfiHandle(_atHandle);
    sdkMapviewMapmarker3dmodelReleaseFfiHandle(_modelHandle);

    sdkMapviewRendersizeUnitReleaseFfiHandle(_unitHandle);
    return __resultHandle;
  }

  @override
  GeoCoordinates get coordinates {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Pointer<Void>, Int32), Pointer<Void> Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapMarker3D_coordinates_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return sdkCoreGeocoordinatesFromFfi(__resultHandle);
    } finally {
      sdkCoreGeocoordinatesReleaseFfiHandle(__resultHandle);

    }

  }

  @override
  set coordinates(GeoCoordinates value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_mapview_MapMarker3D_coordinates_set__GeoCoordinates'));
    final _valueHandle = sdkCoreGeocoordinatesToFfi(value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);
    sdkCoreGeocoordinatesReleaseFfiHandle(_valueHandle);

  }


  @override
  Metadata? get metadata {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Pointer<Void>, Int32), Pointer<Void> Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapMarker3D_metadata_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return sdkCoreMetadataFromFfiNullable(__resultHandle);
    } finally {
      sdkCoreMetadataReleaseFfiHandleNullable(__resultHandle);

    }

  }

  @override
  set metadata(Metadata? value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_mapview_MapMarker3D_metadata_set__Metadata_'));
    final _valueHandle = sdkCoreMetadataToFfiNullable(value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);
    sdkCoreMetadataReleaseFfiHandleNullable(_valueHandle);

  }


  @override
  double get bearing {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Double Function(Pointer<Void>, Int32), double Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapMarker3D_bearing_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return (__resultHandle);
    } finally {


    }

  }

  @override
  set bearing(double value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Double), void Function(Pointer<Void>, int, double)>('here_sdk_sdk_mapview_MapMarker3D_bearing_set__Double'));
    final _valueHandle = (value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);


  }


  @override
  double get roll {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Double Function(Pointer<Void>, Int32), double Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapMarker3D_roll_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return (__resultHandle);
    } finally {


    }

  }

  @override
  set roll(double value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Double), void Function(Pointer<Void>, int, double)>('here_sdk_sdk_mapview_MapMarker3D_roll_set__Double'));
    final _valueHandle = (value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);


  }


  @override
  double get pitch {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Double Function(Pointer<Void>, Int32), double Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapMarker3D_pitch_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return (__resultHandle);
    } finally {


    }

  }

  @override
  set pitch(double value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Double), void Function(Pointer<Void>, int, double)>('here_sdk_sdk_mapview_MapMarker3D_pitch_set__Double'));
    final _valueHandle = (value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);


  }


  @override
  double get scale {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Double Function(Pointer<Void>, Int32), double Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapMarker3D_scale_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return (__resultHandle);
    } finally {


    }

  }

  @override
  set scale(double value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Double), void Function(Pointer<Void>, int, double)>('here_sdk_sdk_mapview_MapMarker3D_scale_set__Double'));
    final _valueHandle = (value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);


  }


  @override
  bool get isDepthCheckEnabled {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Uint8 Function(Pointer<Void>, Int32), int Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapMarker3D_isDepthCheckEnabled_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return booleanFromFfi(__resultHandle);
    } finally {
      booleanReleaseFfiHandle(__resultHandle);

    }

  }

  @override
  set isDepthCheckEnabled(bool value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Uint8), void Function(Pointer<Void>, int, int)>('here_sdk_sdk_mapview_MapMarker3D_isDepthCheckEnabled_set__Boolean'));
    final _valueHandle = booleanToFfi(value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);
    booleanReleaseFfiHandle(_valueHandle);

  }


  @override
  bool get isRenderInternalsEnabled {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Uint8 Function(Pointer<Void>, Int32), int Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapMarker3D_isRenderInternalsEnabled_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return booleanFromFfi(__resultHandle);
    } finally {
      booleanReleaseFfiHandle(__resultHandle);

    }

  }

  @override
  set isRenderInternalsEnabled(bool value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Uint8), void Function(Pointer<Void>, int, int)>('here_sdk_sdk_mapview_MapMarker3D_isRenderInternalsEnabled_set__Boolean'));
    final _valueHandle = booleanToFfi(value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);
    booleanReleaseFfiHandle(_valueHandle);

  }


  @override
  double get opacity {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Double Function(Pointer<Void>, Int32), double Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapMarker3D_opacity_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return (__resultHandle);
    } finally {


    }

  }

  @override
  set opacity(double value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Double), void Function(Pointer<Void>, int, double)>('here_sdk_sdk_mapview_MapMarker3D_opacity_set__Double'));
    final _valueHandle = (value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);


  }


  @override
  List<MapMeasureRange> get visibilityRanges {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Pointer<Void>, Int32), Pointer<Void> Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapMarker3D_visibilityRanges_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return harpSdkBindingslistofSdkMapviewMapmeasurerangeFromFfi(__resultHandle);
    } finally {
      harpSdkBindingslistofSdkMapviewMapmeasurerangeReleaseFfiHandle(__resultHandle);

    }

  }

  @override
  set visibilityRanges(List<MapMeasureRange> value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_mapview_MapMarker3D_visibilityRanges_set__ListOf_sdk_mapview_MapMeasureRange'));
    final _valueHandle = harpSdkBindingslistofSdkMapviewMapmeasurerangeToFfi(value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);
    harpSdkBindingslistofSdkMapviewMapmeasurerangeReleaseFfiHandle(_valueHandle);

  }



}

Pointer<Void> sdkMapviewMapmarker3dToFfi(MapMarker3D value) =>
  _sdkMapviewMapmarker3dCopyHandle((value as __lib.NativeBase).handle);

MapMarker3D sdkMapviewMapmarker3dFromFfi(Pointer<Void> handle) {
  if (handle.address == 0) throw StateError("Expected non-null value.");
  final instance = __lib.getCachedInstance(handle);
  if (instance != null && instance is MapMarker3D) return instance;

  final _copiedHandle = _sdkMapviewMapmarker3dCopyHandle(handle);
  final result = MapMarker3D$Impl(_copiedHandle);
  __lib.cacheInstance(_copiedHandle, result);
  _sdkMapviewMapmarker3dRegisterFinalizer(_copiedHandle, __lib.LibraryContext.isolateId, result);
  return result;
}

void sdkMapviewMapmarker3dReleaseFfiHandle(Pointer<Void> handle) =>
  _sdkMapviewMapmarker3dReleaseHandle(handle);

Pointer<Void> sdkMapviewMapmarker3dToFfiNullable(MapMarker3D? value) =>
  value != null ? sdkMapviewMapmarker3dToFfi(value) : Pointer<Void>.fromAddress(0);

MapMarker3D? sdkMapviewMapmarker3dFromFfiNullable(Pointer<Void> handle) =>
  handle.address != 0 ? sdkMapviewMapmarker3dFromFfi(handle) : null;

void sdkMapviewMapmarker3dReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkMapviewMapmarker3dReleaseHandle(handle);

// End of MapMarker3D "private" section.


