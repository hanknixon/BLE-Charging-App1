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
import 'package:here_sdk/src/sdk/animation/animation_listener.dart';
import 'package:here_sdk/src/sdk/core/geo_box.dart';
import 'package:here_sdk/src/sdk/core/geo_coordinates.dart';
import 'package:here_sdk/src/sdk/core/geo_orientation.dart';
import 'package:here_sdk/src/sdk/core/geo_orientation_update.dart';
import 'package:here_sdk/src/sdk/core/point2_d.dart';
import 'package:here_sdk/src/sdk/core/rectangle2_d.dart';
import 'package:here_sdk/src/sdk/mapview/map_camera_animation.dart';
import 'package:here_sdk/src/sdk/mapview/map_camera_limits.dart';
import 'package:here_sdk/src/sdk/mapview/map_camera_listener.dart';
import 'package:here_sdk/src/sdk/mapview/map_camera_update.dart';
import 'package:here_sdk/src/sdk/mapview/map_measure.dart';

/// Represents the camera looking onto the map view.
///
/// Each map instance has exactly one camera that is used to manipulate
/// the way the map is displayed.
///
/// Any updates to the state of the camera will be applied while drawing the next map view frame
/// and the current state of the camera reflects what is currently drawn inside the map view.
///
/// <b>Camera Model</b>
///
/// <i>Camera Concepts and Units</i>
///
/// By default, HERE SDK uses an idealized Earth globe with a 3D-capable camera model. Being a 3D camera model means that the
/// world position can be freely specified in geodetic 3D space (i.e. Earth centric) and the orientation can be freely changed around
/// two axes - bearing (also known as head) and tilt (also known as pitch).
///
/// The camera supports the look-at target with orientation on the ground way of setting up the camera in space. The camera is placed
/// so that it looks at a specific geo-coordinates (placed at the `principal point`) from a given orientation and distance.
///
/// - the look-at target in geo-coordinates (latitude, longitude) in degrees and an `altitude` in meters above MSL (mean sea level) at the `principal point`
/// - the `orientation` at the look-at target
/// - the distance of the camera from the look-at target, given as `distance` in meters or as `zoom-level`
///
/// <i>Getting the current camera state</i>
///
/// The current camera state can be obtained by the [MapCamera.state] call. It contains information about the camera look-at target (geo-coordinates and orientation) in geodetic space.
/// The values are returned for the current `principal point`. This can lead to surprising or unexpected values in cases where the camera position/orientation was specified for another screen point,
/// e.g. when using [MapCameraUpdateFactory.lookAtArea] with a view rectangle, whose center does not coincide with the `principal point`.  In this case, the geo-coordinates of the
/// look-at target will differ from the center of the geo-box used in the `lookAt` call.
///
/// <i>Geo coordinates</i>
///
/// Geo-coordinates are given in degrees and follow the common nomenclature of positive northern latitudes and positive eastern longitudes.
///
/// <i>Altitude</i>
///
/// When `altitude` is specified, it is always in meters above mean sea level (MSL).
/// If this value is invalid (not-a-number) or not specified, then the terrain height at the given geo-coordinates will be looked up from the map.
/// This is especially interesting in cases where terrain elevation is used within the map display.
///
/// <i>Distance vs zoom-level vs scale</i>
///
/// Map camera `distance`, `zoom-level` and `scale` determine how much of the world is visible on the HERE map. `Distance`, `zoom-level` and `scale` are
/// directly connected and changing one will automatically change the others as well (except for `distance`/`scale` changes that map to `zoom-level` values < 0 or > 23).
///
/// - `distance`: the distance from the camera to the look-at target on the surface of the Earth, in meters
/// - `zoom-level`: the map zoom level, in the range \[0, 3]. The relation between the width of the equator in logical pixels `w` and the zoom level `z` is: `w = 256 * 2^(z)`
/// - `scale`: the scale of the map at the look-at target in meters on screen per meters on Earth. So a scale of 0.001 shows 10 meters on Earth within 1 cm on screen.
///
/// The following mapping represents the `zoom-level` values:
///
/// | zoom-level | ~ scale on screen (130dpi) | width of the equator in logical pixels | what can be seen |
/// |---|:-----------:|:------------:|:------------:|
/// | 0 | 1:800 million | 256 | Earth |
/// | 1 | 1:400 million | 512 | |
/// | 2 | 1:200 million | 1024 | |
/// | 3 | 1:100 million | 2048 | |
/// | 4 | 1:50 million | 4096 | A continent |
/// | 5 | 1:25 million | 8192 | Large roads |
/// | 6 | 1:12 million | 16384 | Large rivers |
/// | 7 | 1:6 million | 32768 | A country |
/// | 8 | 1:3 million | 65536 | |
/// | 9 | 1:1 million | 131072 | |
/// | 10 | 1:780 thousand | 262144 | |
/// | 11 | 1:390 thousand | 524288 | |
/// | 12 | 1:195 thousand | 1048576 | |
/// | 13 | 1:100 thousand | 2097152 | |
/// | 14 | 1:50 thousand | 4194304 | A city |
/// | 15 | 1:25 thousand | 8388608 | |
/// | 16 | 1:12 thousand | 16777216 | Buildings |
/// | 17 | 1:6 thousand | 33554432 | Landmarks |
/// | 18 | 1:3 thousand | 67108864 | |
/// | 19 | 1:1 thousand | 134217728 | |
/// | 20 | 1:7 hundred | 268435456 | Streets |
/// | 21 | 1:3 hundred | 536870912 | |
/// | 22 | 1:1 hundred | 1073741824 | |
/// | 23 | 1:95 | 2147483648 | |
///
/// <i>Orientation</i>
///
/// The camera `orientation` is composed of two parts:
///
/// - `bearing`: also known as azimuth, the view direction in clockwise degrees; 0&deg; = north, 90&deg; = east, 180&deg; = south, 270&deg; = west
/// - `tilt`: the angle in degrees from the vertical that the camera is looking down at the Earth; 0&deg; = straight down.
///
/// <i>Changing the Camera</i>
///
/// All changes to the camera are encapsulated in camera updates that are created using the methods in the [MapCameraUpdateFactory] class.
///
/// These updates can then be applied to the [HereMapControllerCore] using [MapCamera.applyUpdate].
///
/// Camera updates are queued and executed when the next frame is rendered. They are executed in the order in which they were applied.
///
/// <i>Animating the Camera</i>
///
/// Camera updates can be animated by first creating a camera animation using the methods in the [MapCameraAnimationFactory] class and then applying this
/// animation to the [HereMapControllerCore] using [MapCamera.startAnimationWithListener].
///
/// Only one camera animation for one camera component at a time is supported. Applying a new animation will cancel the active animation before the new one is started.
/// The start position in this case is where ever the active animation happened to be at the time. Different components are camera state (`target pose` and `distance/zoom level/scale`)
/// and camera projection (`field of view`, `focal length` and `principal point`).
///
/// The running animations can also be canceled using [MapCamera.cancelAnimations] or individual ones using [MapCamera.cancelAnimation].
abstract class MapCamera implements Finalizable {

  /// Adds a listener to this camera that will be notified
  /// every time the map is redrawn with new camera parameters.
  ///
  /// Adding the same listener multiple times has no effect.
  ///
  /// [listener] The listener to add.
  ///
  void addListener(MapCameraListener listener);
  /// Removes the listener from the camera.
  ///
  /// Trying to remove a listener that is not
  /// currently registered has no effect.
  ///
  /// [observer] The listener to remove.
  ///
  void removeListener(MapCameraListener observer);
  /// Removes all registered listeners.
  ///
  void removeListeners();
  /// Applies camera update to the map camera.
  ///
  /// Any ongoing camera animations will be cancelled and the corresponding camera animation listener will be notified.
  ///
  /// [cameraUpdate] The update that gets applied to camera.
  ///
  void applyUpdate(MapCameraUpdate cameraUpdate);
  /// Computes result of applying camera update without changing state of the map camera.
  ///
  /// Note that this is a beta release of this feature, so there could be a few bugs and unexpected behaviors.
  /// Related APIs may change for new releases without a deprecation process.
  ///
  /// [cameraUpdate] The update that gets dryly applied to camera.
  ///
  /// [callback] Called upon completion with computed map state.
  /// The callback is called from an arbitrary thread.
  ///
  void dryApplyUpdate(MapCameraUpdate cameraUpdate, MapCameraDryCameraUpdateCallback callback);
  /// Starts a given camera animation.
  ///
  /// Starting an animation can cause the cancelling of an ongoing animation when they both affect the same category of camera properties,
  /// like for example any of the look-at properties (target, orientation, map measure) or any of the projection properties (field of view, principal point, focal length).
  /// The corresponding listener of an ongoing animation will be notified about the cancellation in these cases.
  ///
  /// [cameraAnimation] The animation to be started.
  ///
  void startAnimation(MapCameraAnimation cameraAnimation);
  /// Starts a given camera animation.
  ///
  /// The state of the animation can be tracked with the provided listener.
  ///
  /// Starting an animation can cause the cancelling of an ongoing animation when they both affect the same category of camera properties,
  /// like for example any of the look-at properties (target, orientation, map measure) or any of the projection properties (field of view, principal point, focal length).
  /// The corresponding listener of an ongoing animation will be notified about the cancellation in these cases.
  ///
  /// [cameraAnimation] The animation to be started.
  ///
  /// [animationListener] Animation listener. A strong reference is kept internally up until the animation gets cancelled or completed.
  ///
  void startAnimationWithListener(MapCameraAnimation cameraAnimation, AnimationListener animationListener);
  /// Cancels an ongoing camera animation.
  ///
  /// Upon cancellation, the corresponding listener will be notified.
  ///
  /// [cameraAnimation] The animation to be cancelled.
  ///
  void cancelAnimation(MapCameraAnimation cameraAnimation);
  /// Cancels any ongoing camera animation.
  ///
  /// Upon cancellation, the corresponding listener of any cancelled animation will be notified.
  ///
  void cancelAnimations();
  /// Orbits the camera around a specified view point by increasing tilt and bearing by specified
  /// delta values.
  ///
  /// [delta] Camera orientation change, containing tilt and bearing angle deltas.
  ///
  /// [origin] Pixel point in view coordinates around which orbiting occurs.
  ///
  void orbitByWithGeoOrientation(GeoOrientationUpdate delta, Point2D origin);
  /// Zooms in or out by a specified factor.
  ///
  /// This effectively changes the distance from the camera to the [MapCameraState.targetCoordinates]
  /// by the specified factor, which changes [MapCameraState.zoomLevel] as well.
  ///
  /// Values above 1.0 will zoom in and values below will zoom out.
  ///
  /// The relation with [MapCameraState.distanceToTargetInMeters] is inversely linear,
  /// meaning that zooming by 4 will decrease distance to target by 4 while zooming by 0.5
  /// will increase distance to target by 2.
  ///
  /// The relation with zoom level is logarithmic. Meaning that zooming by a factor of 4 will
  /// increase zoom level by 2 (because log2(4) == 2). So to zoom in by X zoom levels, the zoom
  /// factor needs to be 2^X. To zoom out by X zoom levels, zoom factor needs to be 1/(2^X).
  ///
  /// The zooming occurs around the specified origin inside the view.
  ///
  /// [factor] The zoom factor. Values above 1.0 will zoom in and values below will zoom out.
  ///
  /// [origin] Pixel point in view coordinates around which zooming occurs.
  ///
  void zoomBy(double factor, Point2D origin);
  /// Zooms to the specified zoom level.
  ///
  /// The supplied value will be clamped to the range
  /// of \[0, 22\], where 0 is a view of whole globe and 22 is street level.
  ///
  /// This effectively changes the distance from the camera to the target.
  /// The zooming occurs around the current target point.
  ///
  /// [zoomLevel] The zoom level to set, clamped to the range of \[0, 22\].
  ///
  void zoomTo(double zoomLevel);
  /// Makes the camera look at a new geodetic target, while
  /// preserving the current orientation and distance to the target.
  ///
  /// The altitude of the target point is ignored. Any subsequent camera updates and animations
  /// will consider the target point as being located on the ground.
  ///
  /// [target] Geodetic coordinates at which the camera will point.
  ///
  void lookAtPoint(GeoCoordinates target);
  /// Makes the camera look at the geodetic target with the given zoom.
  ///
  /// The altitude of the target point is ignored. Any subsequent camera updates and animations
  /// will consider the target point as being located on the ground.
  ///
  /// [target] Geodetic coordinates at which the camera will point.
  ///
  /// [zoom] The zoom level which can be provided as distance to the target point, scale or
  /// zoom level.
  ///
  void lookAtPointWithMeasure(GeoCoordinates target, MapMeasure zoom);
  /// Makes the camera look at the geodetic target with the given zoom and orientation.
  ///
  /// The supplied orientation is the orientation of the camera looking
  /// at the target, so the resulting camera state will have the
  /// same orientation as the one supplied to this method.
  ///
  /// The altitude of the target point is ignored. Any subsequent camera updates and animations
  /// will consider the target point as being located on the ground.
  ///
  /// [target] Geodetic coordinates at which the camera will point.
  ///
  /// [orientation] Desired orientation of the camera.
  ///
  /// [zoom] The zoom level which can be provided as distance to the target point, scale or
  /// zoom level.
  ///
  void lookAtPointWithGeoOrientationAndMeasure(GeoCoordinates target, GeoOrientationUpdate orientation, MapMeasure zoom);
  /// Makes the camera look at the specified geodetic area.
  ///
  /// The supplied orientation is the orientation of the camera looking
  /// at the target, so the resulting camera state will have the
  /// same orientation as the one supplied to this method.
  ///
  /// The altitude of the target points is ignored.
  ///
  /// [target] Geodetic area at which the camera will point
  ///
  /// [orientation] Desired orientation of the camera
  ///
  void lookAtAreaWithGeoOrientation(GeoBox target, GeoOrientationUpdate orientation);
  /// Makes the camera look at the specified geodetic area and pass a rectangle which specifies
  /// where the area should appear inside of the map view.
  ///
  /// The supplied orientation is the orientation of the camera looking
  /// at the target, so the resulting camera state will have the
  /// same orientation as the one supplied to this method. Please note that
  /// the resulting orientation might deviate from the provided orientation.
  /// This is particularly the case if a large geobox on world level and a
  /// view rectangle which is relatively small was passed to the method.
  ///
  /// The altitude of the target points is ignored.
  ///
  /// [target] Geodetic area which will be shown in the viewRectangle.
  ///
  /// [orientation] Desired orientation of the camera.
  ///
  /// [viewRectangle] The view rectangle in viewport pixel coordinates inside which the geographical target
  /// area is displayed.
  ///
  void lookAtAreaWithGeoOrientationAndViewRectangle(GeoBox target, GeoOrientationUpdate orientation, Rectangle2D viewRectangle);
  /// Makes the camera look at current target from certain distance
  ///
  /// This function neither modifies target coordinates nor target orientation.
  ///
  /// [distanceInMeters] Distance in meters to the target point.
  /// Minimal distance value is clamped to 100 meters.
  ///
  void setDistanceToTarget(double distanceInMeters);
  /// Changes camera orientation in relation to target location.
  ///
  /// [orientation] Desired orientation of the camera.
  ///
  void setOrientationAtTarget(GeoOrientationUpdate orientation);
  /// Current state of the camera that reflects what is currently drawn by the map view.
  /// Gets state of the camera that reflects what is currently drawn inside the map view.
  MapCameraState get state;

  /// Determines the pixel point where the target is placed within the map view. Setting a new
  /// principal point instantly moves the map to render the current target coordinates
  /// at the new principal point.
  /// Gets the pixel point that determines where the target is placed within the map view.
  /// By default, the principal point is located at the center of the map view.
  ///
  /// The value of the principal point is adjusted when the dimensions of the
  /// map view change, so that it stays in the same point relative to width
  /// and height. Meaning that when a principal point it set to bottom
  /// middle of the map view, it will stay in the bottom middle regardless
  /// of the changes to dimensions and orientation of the view.
  Point2D get principalPoint;
  /// Determines the pixel point where the target is placed within the map view. Setting a new
  /// principal point instantly moves the map to render the current target coordinates
  /// at the new principal point.
  /// Sets the pixel point that determines where the target appears within the map view.
  /// This instantly moves the map to render the current target coordinates
  /// at the new principal point.
  ///
  /// By default, the principal point is located at the center of the map view.
  /// It is set in pixels relative to the map view's origin top-left (0, 0).
  /// Values outside the map view's dimensions (x < 0 || x > width, y < 0 || y > height)
  /// will be rejected silently and the current principal point is kept.
  ///
  /// The value of the principal point is adjusted when the dimensions of the
  /// map view change, so that it stays in the same point relative to width
  /// and height. Meaning that when a principal point it set to bottom
  /// middle of the map view, it will stay in the bottom middle regardless
  /// of the changes to dimensions and orientation of the view.
  ///
  /// Note: The principal point affects all programmatical map transformations (rotate, orbit, tilt and zoom)
  /// and the two-finger-pan gesture to tilt the map. Other gestures, like pinch-rotate,
  /// are not affected.
  set principalPoint(Point2D value);

  /// Currently visible map area encompassed in a GeoBox.
  /// Note that this bounding box is always rectangular, and its sides are always
  /// parallel to the latitude and longitude. If the camera is rotated, the returned
  /// bounding box will be a circumscribed rectangle that is larger than the
  /// visible map area. Similarly, when the map is tilted (for example, if
  /// the map is tilted by 45 degrees), the visible map area represents
  /// a trapezoidal area in the world. Resulting value will then be a larger
  /// circumscribed rectangle that contains this trapezoid area.
  /// Because on this, corners of the resulting bounding box may be located
  /// outside of the currently visible area.
  ///
  /// When the map area does not fully fill the viewport, `null` is returned.
  /// Gets the current visible map area encompassed in a GeoBox.
  GeoBox? get boundingBox;

  /// Controls limits for the camera settings.
  /// Gets a MapCameraLimits instance that controls limits for the camera settings.
  MapCameraLimits get limits;

}

/// Encapsulates state of the camera.

class MapCameraState {
  /// Camera's 'LookAt' target position in geodetic space.
  ///
  /// Note: The altitude of the target point is ignored. Any subsequent camera updates and animations
  /// will consider the target point as being located on the ground.
  GeoCoordinates targetCoordinates;

  /// Camera's orientation at target point.
  GeoOrientation orientationAtTarget;

  /// Distance from the camera to the target point in meters.
  double distanceToTargetInMeters;

  /// Zoom level corresponding to the current distance to target.
  double zoomLevel;

  /// Creates a new instance.
  /// [targetCoordinates] Camera's 'LookAt' target position in geodetic space.
  ///
  /// Note: The altitude of the target point is ignored. Any subsequent camera updates and animations
  /// will consider the target point as being located on the ground.
  /// [orientationAtTarget] Camera's orientation at target point.
  /// [distanceToTargetInMeters] Distance from the camera to the target point in meters.
  /// [zoomLevel] Zoom level corresponding to the current distance to target.
  MapCameraState(this.targetCoordinates, this.orientationAtTarget, this.distanceToTargetInMeters, this.zoomLevel);
}


// MapCameraState "private" section, not exported.

final _sdkMapviewMapcameraStateCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Double, Double),
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, double, double)
  >('here_sdk_sdk_mapview_MapCamera_State_create_handle'));
final _sdkMapviewMapcameraStateReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_MapCamera_State_release_handle'));
final _sdkMapviewMapcameraStateGetFieldtargetCoordinates = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_MapCamera_State_get_field_targetCoordinates'));
final _sdkMapviewMapcameraStateGetFieldorientationAtTarget = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_MapCamera_State_get_field_orientationAtTarget'));
final _sdkMapviewMapcameraStateGetFielddistanceToTargetInMeters = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Double Function(Pointer<Void>),
    double Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_MapCamera_State_get_field_distanceToTargetInMeters'));
final _sdkMapviewMapcameraStateGetFieldzoomLevel = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Double Function(Pointer<Void>),
    double Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_MapCamera_State_get_field_zoomLevel'));



Pointer<Void> sdkMapviewMapcameraStateToFfi(MapCameraState value) {
  final _targetCoordinatesHandle = sdkCoreGeocoordinatesToFfi(value.targetCoordinates);
  final _orientationAtTargetHandle = sdkCoreGeoorientationToFfi(value.orientationAtTarget);
  final _distanceToTargetInMetersHandle = (value.distanceToTargetInMeters);
  final _zoomLevelHandle = (value.zoomLevel);
  final _result = _sdkMapviewMapcameraStateCreateHandle(_targetCoordinatesHandle, _orientationAtTargetHandle, _distanceToTargetInMetersHandle, _zoomLevelHandle);
  sdkCoreGeocoordinatesReleaseFfiHandle(_targetCoordinatesHandle);
  sdkCoreGeoorientationReleaseFfiHandle(_orientationAtTargetHandle);
  
  
  return _result;
}

MapCameraState sdkMapviewMapcameraStateFromFfi(Pointer<Void> handle) {
  final _targetCoordinatesHandle = _sdkMapviewMapcameraStateGetFieldtargetCoordinates(handle);
  final _orientationAtTargetHandle = _sdkMapviewMapcameraStateGetFieldorientationAtTarget(handle);
  final _distanceToTargetInMetersHandle = _sdkMapviewMapcameraStateGetFielddistanceToTargetInMeters(handle);
  final _zoomLevelHandle = _sdkMapviewMapcameraStateGetFieldzoomLevel(handle);
  try {
    return MapCameraState(
      sdkCoreGeocoordinatesFromFfi(_targetCoordinatesHandle), 
      sdkCoreGeoorientationFromFfi(_orientationAtTargetHandle), 
      (_distanceToTargetInMetersHandle), 
      (_zoomLevelHandle)
    );
  } finally {
    sdkCoreGeocoordinatesReleaseFfiHandle(_targetCoordinatesHandle);
    sdkCoreGeoorientationReleaseFfiHandle(_orientationAtTargetHandle);
    
    
  }
}

void sdkMapviewMapcameraStateReleaseFfiHandle(Pointer<Void> handle) => _sdkMapviewMapcameraStateReleaseHandle(handle);

// Nullable MapCameraState

final _sdkMapviewMapcameraStateCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_MapCamera_State_create_handle_nullable'));
final _sdkMapviewMapcameraStateReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_MapCamera_State_release_handle_nullable'));
final _sdkMapviewMapcameraStateGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_MapCamera_State_get_value_nullable'));

Pointer<Void> sdkMapviewMapcameraStateToFfiNullable(MapCameraState? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkMapviewMapcameraStateToFfi(value);
  final result = _sdkMapviewMapcameraStateCreateHandleNullable(_handle);
  sdkMapviewMapcameraStateReleaseFfiHandle(_handle);
  return result;
}

MapCameraState? sdkMapviewMapcameraStateFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkMapviewMapcameraStateGetValueNullable(handle);
  final result = sdkMapviewMapcameraStateFromFfi(_handle);
  sdkMapviewMapcameraStateReleaseFfiHandle(_handle);
  return result;
}

void sdkMapviewMapcameraStateReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkMapviewMapcameraStateReleaseHandleNullable(handle);

// End of MapCameraState "private" section.
/// Used to report back results of dry update application to camera.
///
/// Note that this is a beta release of this feature, so there could be a few bugs and unexpected behaviors.
/// Related APIs may change for new releases without a deprecation process.
///
/// [p0] Map camera state after dry application of update
typedef MapCameraDryCameraUpdateCallback = void Function(MapCameraState?);

// MapCameraDryCameraUpdateCallback "private" section, not exported.

final _sdkMapviewMapcameraDrycameraupdatecallbackRegisterFinalizer = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>, Int32, Handle),
    void Function(Pointer<Void>, int, Object)
  >('here_sdk_sdk_mapview_MapCamera_DryCameraUpdateCallback_register_finalizer'));
final _sdkMapviewMapcameraDrycameraupdatecallbackCopyHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_MapCamera_DryCameraUpdateCallback_copy_handle'));
final _sdkMapviewMapcameraDrycameraupdatecallbackReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_MapCamera_DryCameraUpdateCallback_release_handle'));
final _sdkMapviewMapcameraDrycameraupdatecallbackCreateProxy = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Uint64, Int32, Handle, Pointer),
    Pointer<Void> Function(int, int, Object, Pointer)
  >('here_sdk_sdk_mapview_MapCamera_DryCameraUpdateCallback_create_proxy'));

class MapCameraDryCameraUpdateCallback$Impl implements Finalizable {
  final Pointer<Void> handle;
  MapCameraDryCameraUpdateCallback$Impl(this.handle);

  void call(MapCameraState? p0) {
    final _callFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_mapview_MapCamera_DryCameraUpdateCallback_call__State_'));
    final _p0Handle = sdkMapviewMapcameraStateToFfiNullable(p0);
    final _handle = this.handle;
    _callFfi(_handle, __lib.LibraryContext.isolateId, _p0Handle);
    sdkMapviewMapcameraStateReleaseFfiHandleNullable(_p0Handle);

  }

}

int _sdkMapviewMapcameraDrycameraupdatecallbackcallStatic(Object _obj, Pointer<Void> p0) {
  
  try {
    (_obj as MapCameraDryCameraUpdateCallback)(sdkMapviewMapcameraStateFromFfiNullable(p0));
  } finally {
    sdkMapviewMapcameraStateReleaseFfiHandleNullable(p0);
  }
  return 0;
}

Pointer<Void> sdkMapviewMapcameraDrycameraupdatecallbackToFfi(MapCameraDryCameraUpdateCallback value) =>
  _sdkMapviewMapcameraDrycameraupdatecallbackCreateProxy(
    __lib.getObjectToken(value),
    __lib.LibraryContext.isolateId,
    value,
    Pointer.fromFunction<Int64 Function(Handle, Pointer<Void>)>(_sdkMapviewMapcameraDrycameraupdatecallbackcallStatic, __lib.unknownError)
  );

MapCameraDryCameraUpdateCallback sdkMapviewMapcameraDrycameraupdatecallbackFromFfi(Pointer<Void> handle) {
  final _copiedHandle = _sdkMapviewMapcameraDrycameraupdatecallbackCopyHandle(handle);
  final _impl = MapCameraDryCameraUpdateCallback$Impl(_copiedHandle);
  final result = (MapCameraState? p0) => _impl.call(p0);
  _sdkMapviewMapcameraDrycameraupdatecallbackRegisterFinalizer(_copiedHandle, __lib.LibraryContext.isolateId, result);
  return result;
}

void sdkMapviewMapcameraDrycameraupdatecallbackReleaseFfiHandle(Pointer<Void> handle) =>
  _sdkMapviewMapcameraDrycameraupdatecallbackReleaseHandle(handle);

// Nullable MapCameraDryCameraUpdateCallback

final _sdkMapviewMapcameraDrycameraupdatecallbackCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_MapCamera_DryCameraUpdateCallback_create_handle_nullable'));
final _sdkMapviewMapcameraDrycameraupdatecallbackReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_MapCamera_DryCameraUpdateCallback_release_handle_nullable'));
final _sdkMapviewMapcameraDrycameraupdatecallbackGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_MapCamera_DryCameraUpdateCallback_get_value_nullable'));

Pointer<Void> sdkMapviewMapcameraDrycameraupdatecallbackToFfiNullable(MapCameraDryCameraUpdateCallback? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkMapviewMapcameraDrycameraupdatecallbackToFfi(value);
  final result = _sdkMapviewMapcameraDrycameraupdatecallbackCreateHandleNullable(_handle);
  sdkMapviewMapcameraDrycameraupdatecallbackReleaseFfiHandle(_handle);
  return result;
}

MapCameraDryCameraUpdateCallback? sdkMapviewMapcameraDrycameraupdatecallbackFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkMapviewMapcameraDrycameraupdatecallbackGetValueNullable(handle);
  final result = sdkMapviewMapcameraDrycameraupdatecallbackFromFfi(_handle);
  sdkMapviewMapcameraDrycameraupdatecallbackReleaseFfiHandle(_handle);
  return result;
}

void sdkMapviewMapcameraDrycameraupdatecallbackReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkMapviewMapcameraDrycameraupdatecallbackReleaseHandleNullable(handle);

// End of MapCameraDryCameraUpdateCallback "private" section.

// MapCamera "private" section, not exported.

final _sdkMapviewMapcameraRegisterFinalizer = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>, Int32, Handle),
    void Function(Pointer<Void>, int, Object)
  >('here_sdk_sdk_mapview_MapCamera_register_finalizer'));
final _sdkMapviewMapcameraCopyHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_MapCamera_copy_handle'));
final _sdkMapviewMapcameraReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_MapCamera_release_handle'));






















class MapCamera$Impl extends __lib.NativeBase implements MapCamera {

  MapCamera$Impl(Pointer<Void> handle) : super(handle);

  @override
  void addListener(MapCameraListener listener) {
    final _addListenerFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_mapview_MapCamera_addListener__MapCameraListener'));
    final _listenerHandle = sdkMapviewMapcameralistenerToFfi(listener);
    final _handle = this.handle;
    _addListenerFfi(_handle, __lib.LibraryContext.isolateId, _listenerHandle);
    sdkMapviewMapcameralistenerReleaseFfiHandle(_listenerHandle);

  }

  @override
  void removeListener(MapCameraListener observer) {
    final _removeListenerFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_mapview_MapCamera_removeListener__MapCameraListener'));
    final _observerHandle = sdkMapviewMapcameralistenerToFfi(observer);
    final _handle = this.handle;
    _removeListenerFfi(_handle, __lib.LibraryContext.isolateId, _observerHandle);
    sdkMapviewMapcameralistenerReleaseFfiHandle(_observerHandle);

  }

  @override
  void removeListeners() {
    final _removeListenersFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32), void Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapCamera_removeListeners'));
    final _handle = this.handle;
    _removeListenersFfi(_handle, __lib.LibraryContext.isolateId);

  }

  @override
  void applyUpdate(MapCameraUpdate cameraUpdate) {
    final _applyUpdateFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_mapview_MapCamera_applyUpdate__MapCameraUpdate'));
    final _cameraUpdateHandle = sdkMapviewMapcameraupdateToFfi(cameraUpdate);
    final _handle = this.handle;
    _applyUpdateFfi(_handle, __lib.LibraryContext.isolateId, _cameraUpdateHandle);
    sdkMapviewMapcameraupdateReleaseFfiHandle(_cameraUpdateHandle);

  }

  @override
  void dryApplyUpdate(MapCameraUpdate cameraUpdate, MapCameraDryCameraUpdateCallback callback) {
    final _dryApplyUpdateFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>, Pointer<Void>)>('here_sdk_sdk_mapview_MapCamera_dryApplyUpdate__MapCameraUpdate_DryCameraUpdateCallback'));
    final _cameraUpdateHandle = sdkMapviewMapcameraupdateToFfi(cameraUpdate);
    final _callbackHandle = sdkMapviewMapcameraDrycameraupdatecallbackToFfi(callback);
    final _handle = this.handle;
    _dryApplyUpdateFfi(_handle, __lib.LibraryContext.isolateId, _cameraUpdateHandle, _callbackHandle);
    sdkMapviewMapcameraupdateReleaseFfiHandle(_cameraUpdateHandle);
    sdkMapviewMapcameraDrycameraupdatecallbackReleaseFfiHandle(_callbackHandle);

  }

  @override
  void startAnimation(MapCameraAnimation cameraAnimation) {
    final _startAnimationFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_mapview_MapCamera_startAnimation__MapCameraAnimation'));
    final _cameraAnimationHandle = sdkMapviewMapcameraanimationToFfi(cameraAnimation);
    final _handle = this.handle;
    _startAnimationFfi(_handle, __lib.LibraryContext.isolateId, _cameraAnimationHandle);
    sdkMapviewMapcameraanimationReleaseFfiHandle(_cameraAnimationHandle);

  }

  @override
  void startAnimationWithListener(MapCameraAnimation cameraAnimation, AnimationListener animationListener) {
    final _startAnimationWithListenerFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>, Pointer<Void>)>('here_sdk_sdk_mapview_MapCamera_startAnimation__MapCameraAnimation_AnimationListener'));
    final _cameraAnimationHandle = sdkMapviewMapcameraanimationToFfi(cameraAnimation);
    final _animationListenerHandle = sdkAnimationAnimationlistenerToFfi(animationListener);
    final _handle = this.handle;
    _startAnimationWithListenerFfi(_handle, __lib.LibraryContext.isolateId, _cameraAnimationHandle, _animationListenerHandle);
    sdkMapviewMapcameraanimationReleaseFfiHandle(_cameraAnimationHandle);
    sdkAnimationAnimationlistenerReleaseFfiHandle(_animationListenerHandle);

  }

  @override
  void cancelAnimation(MapCameraAnimation cameraAnimation) {
    final _cancelAnimationFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_mapview_MapCamera_cancelAnimation__MapCameraAnimation'));
    final _cameraAnimationHandle = sdkMapviewMapcameraanimationToFfi(cameraAnimation);
    final _handle = this.handle;
    _cancelAnimationFfi(_handle, __lib.LibraryContext.isolateId, _cameraAnimationHandle);
    sdkMapviewMapcameraanimationReleaseFfiHandle(_cameraAnimationHandle);

  }

  @override
  void cancelAnimations() {
    final _cancelAnimationsFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32), void Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapCamera_cancelAnimations'));
    final _handle = this.handle;
    _cancelAnimationsFfi(_handle, __lib.LibraryContext.isolateId);

  }

  @override
  void orbitByWithGeoOrientation(GeoOrientationUpdate delta, Point2D origin) {
    final _orbitByWithGeoOrientationFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>, Pointer<Void>)>('here_sdk_sdk_mapview_MapCamera_orbitBy__GeoOrientationUpdate_Point2D'));
    final _deltaHandle = sdkCoreGeoorientationupdateToFfi(delta);
    final _originHandle = sdkCorePoint2dToFfi(origin);
    final _handle = this.handle;
    _orbitByWithGeoOrientationFfi(_handle, __lib.LibraryContext.isolateId, _deltaHandle, _originHandle);
    sdkCoreGeoorientationupdateReleaseFfiHandle(_deltaHandle);
    sdkCorePoint2dReleaseFfiHandle(_originHandle);

  }

  @override
  void zoomBy(double factor, Point2D origin) {
    final _zoomByFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Double, Pointer<Void>), void Function(Pointer<Void>, int, double, Pointer<Void>)>('here_sdk_sdk_mapview_MapCamera_zoomBy__Double_Point2D'));
    final _factorHandle = (factor);
    final _originHandle = sdkCorePoint2dToFfi(origin);
    final _handle = this.handle;
    _zoomByFfi(_handle, __lib.LibraryContext.isolateId, _factorHandle, _originHandle);

    sdkCorePoint2dReleaseFfiHandle(_originHandle);

  }

  @override
  void zoomTo(double zoomLevel) {
    final _zoomToFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Double), void Function(Pointer<Void>, int, double)>('here_sdk_sdk_mapview_MapCamera_zoomTo__Double'));
    final _zoomLevelHandle = (zoomLevel);
    final _handle = this.handle;
    _zoomToFfi(_handle, __lib.LibraryContext.isolateId, _zoomLevelHandle);


  }

  @override
  void lookAtPoint(GeoCoordinates target) {
    final _lookAtPointFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_mapview_MapCamera_lookAt__GeoCoordinates'));
    final _targetHandle = sdkCoreGeocoordinatesToFfi(target);
    final _handle = this.handle;
    _lookAtPointFfi(_handle, __lib.LibraryContext.isolateId, _targetHandle);
    sdkCoreGeocoordinatesReleaseFfiHandle(_targetHandle);

  }

  @override
  void lookAtPointWithMeasure(GeoCoordinates target, MapMeasure zoom) {
    final _lookAtPointWithMeasureFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>, Pointer<Void>)>('here_sdk_sdk_mapview_MapCamera_lookAt__GeoCoordinates_MapMeasure'));
    final _targetHandle = sdkCoreGeocoordinatesToFfi(target);
    final _zoomHandle = sdkMapviewMapmeasureToFfi(zoom);
    final _handle = this.handle;
    _lookAtPointWithMeasureFfi(_handle, __lib.LibraryContext.isolateId, _targetHandle, _zoomHandle);
    sdkCoreGeocoordinatesReleaseFfiHandle(_targetHandle);
    sdkMapviewMapmeasureReleaseFfiHandle(_zoomHandle);

  }

  @override
  void lookAtPointWithGeoOrientationAndMeasure(GeoCoordinates target, GeoOrientationUpdate orientation, MapMeasure zoom) {
    final _lookAtPointWithGeoOrientationAndMeasureFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>, Pointer<Void>, Pointer<Void>)>('here_sdk_sdk_mapview_MapCamera_lookAt__GeoCoordinates_GeoOrientationUpdate_MapMeasure'));
    final _targetHandle = sdkCoreGeocoordinatesToFfi(target);
    final _orientationHandle = sdkCoreGeoorientationupdateToFfi(orientation);
    final _zoomHandle = sdkMapviewMapmeasureToFfi(zoom);
    final _handle = this.handle;
    _lookAtPointWithGeoOrientationAndMeasureFfi(_handle, __lib.LibraryContext.isolateId, _targetHandle, _orientationHandle, _zoomHandle);
    sdkCoreGeocoordinatesReleaseFfiHandle(_targetHandle);
    sdkCoreGeoorientationupdateReleaseFfiHandle(_orientationHandle);
    sdkMapviewMapmeasureReleaseFfiHandle(_zoomHandle);

  }

  @override
  void lookAtAreaWithGeoOrientation(GeoBox target, GeoOrientationUpdate orientation) {
    final _lookAtAreaWithGeoOrientationFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>, Pointer<Void>)>('here_sdk_sdk_mapview_MapCamera_lookAt__GeoBox_GeoOrientationUpdate'));
    final _targetHandle = sdkCoreGeoboxToFfi(target);
    final _orientationHandle = sdkCoreGeoorientationupdateToFfi(orientation);
    final _handle = this.handle;
    _lookAtAreaWithGeoOrientationFfi(_handle, __lib.LibraryContext.isolateId, _targetHandle, _orientationHandle);
    sdkCoreGeoboxReleaseFfiHandle(_targetHandle);
    sdkCoreGeoorientationupdateReleaseFfiHandle(_orientationHandle);

  }

  @override
  void lookAtAreaWithGeoOrientationAndViewRectangle(GeoBox target, GeoOrientationUpdate orientation, Rectangle2D viewRectangle) {
    final _lookAtAreaWithGeoOrientationAndViewRectangleFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>, Pointer<Void>, Pointer<Void>)>('here_sdk_sdk_mapview_MapCamera_lookAt__GeoBox_GeoOrientationUpdate_Rectangle2D'));
    final _targetHandle = sdkCoreGeoboxToFfi(target);
    final _orientationHandle = sdkCoreGeoorientationupdateToFfi(orientation);
    final _viewRectangleHandle = sdkCoreRectangle2dToFfi(viewRectangle);
    final _handle = this.handle;
    _lookAtAreaWithGeoOrientationAndViewRectangleFfi(_handle, __lib.LibraryContext.isolateId, _targetHandle, _orientationHandle, _viewRectangleHandle);
    sdkCoreGeoboxReleaseFfiHandle(_targetHandle);
    sdkCoreGeoorientationupdateReleaseFfiHandle(_orientationHandle);
    sdkCoreRectangle2dReleaseFfiHandle(_viewRectangleHandle);

  }

  @override
  void setDistanceToTarget(double distanceInMeters) {
    final _setDistanceToTargetFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Double), void Function(Pointer<Void>, int, double)>('here_sdk_sdk_mapview_MapCamera_setDistanceToTarget__Double'));
    final _distanceInMetersHandle = (distanceInMeters);
    final _handle = this.handle;
    _setDistanceToTargetFfi(_handle, __lib.LibraryContext.isolateId, _distanceInMetersHandle);


  }

  @override
  void setOrientationAtTarget(GeoOrientationUpdate orientation) {
    final _setOrientationAtTargetFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_mapview_MapCamera_setOrientationAtTarget__GeoOrientationUpdate'));
    final _orientationHandle = sdkCoreGeoorientationupdateToFfi(orientation);
    final _handle = this.handle;
    _setOrientationAtTargetFfi(_handle, __lib.LibraryContext.isolateId, _orientationHandle);
    sdkCoreGeoorientationupdateReleaseFfiHandle(_orientationHandle);

  }

  @override
  MapCameraState get state {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Pointer<Void>, Int32), Pointer<Void> Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapCamera_state_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return sdkMapviewMapcameraStateFromFfi(__resultHandle);
    } finally {
      sdkMapviewMapcameraStateReleaseFfiHandle(__resultHandle);

    }

  }


  @override
  Point2D get principalPoint {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Pointer<Void>, Int32), Pointer<Void> Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapCamera_principalPoint_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return sdkCorePoint2dFromFfi(__resultHandle);
    } finally {
      sdkCorePoint2dReleaseFfiHandle(__resultHandle);

    }

  }

  @override
  set principalPoint(Point2D value) {
    final _setFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>)>('here_sdk_sdk_mapview_MapCamera_principalPoint_set__Point2D'));
    final _valueHandle = sdkCorePoint2dToFfi(value);
    final _handle = this.handle;
    _setFfi(_handle, __lib.LibraryContext.isolateId, _valueHandle);
    sdkCorePoint2dReleaseFfiHandle(_valueHandle);

  }


  @override
  GeoBox? get boundingBox {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Pointer<Void>, Int32), Pointer<Void> Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapCamera_boundingBox_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return sdkCoreGeoboxFromFfiNullable(__resultHandle);
    } finally {
      sdkCoreGeoboxReleaseFfiHandleNullable(__resultHandle);

    }

  }


  @override
  MapCameraLimits get limits {
    final _getFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Pointer<Void>, Int32), Pointer<Void> Function(Pointer<Void>, int)>('here_sdk_sdk_mapview_MapCamera_limits_get'));
    final _handle = this.handle;
    final __resultHandle = _getFfi(_handle, __lib.LibraryContext.isolateId);
    try {
      return sdkMapviewMapcameralimitsFromFfi(__resultHandle);
    } finally {
      sdkMapviewMapcameralimitsReleaseFfiHandle(__resultHandle);

    }

  }



}

Pointer<Void> sdkMapviewMapcameraToFfi(MapCamera value) =>
  _sdkMapviewMapcameraCopyHandle((value as __lib.NativeBase).handle);

MapCamera sdkMapviewMapcameraFromFfi(Pointer<Void> handle) {
  if (handle.address == 0) throw StateError("Expected non-null value.");
  final instance = __lib.getCachedInstance(handle);
  if (instance != null && instance is MapCamera) return instance;

  final _copiedHandle = _sdkMapviewMapcameraCopyHandle(handle);
  final result = MapCamera$Impl(_copiedHandle);
  __lib.cacheInstance(_copiedHandle, result);
  _sdkMapviewMapcameraRegisterFinalizer(_copiedHandle, __lib.LibraryContext.isolateId, result);
  return result;
}

void sdkMapviewMapcameraReleaseFfiHandle(Pointer<Void> handle) =>
  _sdkMapviewMapcameraReleaseHandle(handle);

Pointer<Void> sdkMapviewMapcameraToFfiNullable(MapCamera? value) =>
  value != null ? sdkMapviewMapcameraToFfi(value) : Pointer<Void>.fromAddress(0);

MapCamera? sdkMapviewMapcameraFromFfiNullable(Pointer<Void> handle) =>
  handle.address != 0 ? sdkMapviewMapcameraFromFfi(handle) : null;

void sdkMapviewMapcameraReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkMapviewMapcameraReleaseHandle(handle);

// End of MapCamera "private" section.


