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
import 'package:here_sdk/src/builtin_types__conversion.dart';
import 'package:here_sdk/src/sdk/core/geo_coordinates.dart';
import 'package:here_sdk/src/sdk/routing/segment_reference.dart';

/// Describes a map-matched location in the world at a given time.

class MapMatchedLocation {
  /// The geographic coordinates of the map-matched location.
  GeoCoordinates coordinates;

  /// The bearing orientation points to the direction of travel, and has the same angle as the
  /// street where it is matched to. Therefore, it must not necessarily be the same as the
  /// bearing of a location source.
  /// Starts at 0 in the geographic north and rotates in a clockwise direction around the
  /// compass. It means that for going north it's equal to 0, for northeast it's equal to 45,
  /// for east it's equal to 90, and so on.
  /// If it cannot be determined, the value is `null`. Otherwise, it is guaranteed to be in the
  /// range [0, 360).
  double? bearingInDegrees;

  /// Reference to the current segment.
  /// The ratio of [MapMatchedLocation.segmentOffsetInCentimeters] to the segment length is
  /// between [SegmentReference.offsetStart] and [SegmentReference.offsetEnd].
  SegmentReference segmentReference;

  /// Offset from start of segment in centimeters.
  int segmentOffsetInCentimeters;

  /// Confidence level (between 0 and 1) of the matched location.
  /// A low confidence value means that the map-matched vehicle location is not reliable and it may
  /// not be clear which part of the road the vehicle has taken. This can happen when the accuracy
  /// or frequency of the provided location updates is poor. If the confidence level is too small
  /// then, for example, overspeed warnings may be also inaccurate.
  double confidence;

  /// Determines if the travel direction on a one-way street is against the allowed traffic direction.
  /// For two-way streets, this value is always `false`.
  /// This feature is supported in tracking mode and when deviating from a route.
  /// Note that the travel direction is determined based on the map-matched location.
  bool isDrivingInTheWrongWay;

  /// Horizontal accuracy measure of location.
  /// Estimated based on accuracy of input location and confidence of this map-matched location.
  /// Currently this value is not being provided by the Navigator.
  /// **Note:** This is a beta release of this feature, so there could be a few bugs and unexpected
  /// behaviors. Related APIs may change for new releases without a deprecation process.
  double? horizontalAccuracyInMeters;

  /// Creates a new instance.

  /// [coordinates] The geographic coordinates of the map-matched location.

  /// [bearingInDegrees] The bearing orientation points to the direction of travel, and has the same angle as the
  /// street where it is matched to. Therefore, it must not necessarily be the same as the
  /// bearing of a location source.
  /// Starts at 0 in the geographic north and rotates in a clockwise direction around the
  /// compass. It means that for going north it's equal to 0, for northeast it's equal to 45,
  /// for east it's equal to 90, and so on.
  /// If it cannot be determined, the value is `null`. Otherwise, it is guaranteed to be in the
  /// range [0, 360).

  /// [segmentReference] Reference to the current segment.
  /// The ratio of [MapMatchedLocation.segmentOffsetInCentimeters] to the segment length is
  /// between [SegmentReference.offsetStart] and [SegmentReference.offsetEnd].

  /// [segmentOffsetInCentimeters] Offset from start of segment in centimeters.

  /// [confidence] Confidence level (between 0 and 1) of the matched location.
  /// A low confidence value means that the map-matched vehicle location is not reliable and it may
  /// not be clear which part of the road the vehicle has taken. This can happen when the accuracy
  /// or frequency of the provided location updates is poor. If the confidence level is too small
  /// then, for example, overspeed warnings may be also inaccurate.

  /// [isDrivingInTheWrongWay] Determines if the travel direction on a one-way street is against the allowed traffic direction.
  /// For two-way streets, this value is always `false`.
  /// This feature is supported in tracking mode and when deviating from a route.
  /// Note that the travel direction is determined based on the map-matched location.

  /// [horizontalAccuracyInMeters] Horizontal accuracy measure of location.
  /// Estimated based on accuracy of input location and confidence of this map-matched location.
  /// Currently this value is not being provided by the Navigator.
  /// **Note:** This is a beta release of this feature, so there could be a few bugs and unexpected
  /// behaviors. Related APIs may change for new releases without a deprecation process.

  MapMatchedLocation._(this.coordinates, this.bearingInDegrees, this.segmentReference, this.segmentOffsetInCentimeters, this.confidence, this.isDrivingInTheWrongWay, this.horizontalAccuracyInMeters);
  /// Creates a new instance.
  /// [coordinates] The geographic coordinates of the map-matched location.
  /// [bearingInDegrees] The bearing orientation points to the direction of travel, and has the same angle as the
  /// street where it is matched to. Therefore, it must not necessarily be the same as the
  /// bearing of a location source.
  /// Starts at 0 in the geographic north and rotates in a clockwise direction around the
  /// compass. It means that for going north it's equal to 0, for northeast it's equal to 45,
  /// for east it's equal to 90, and so on.
  /// If it cannot be determined, the value is `null`. Otherwise, it is guaranteed to be in the
  /// range [0, 360).
  MapMatchedLocation(this.coordinates, this.bearingInDegrees)
      : segmentReference = SegmentReference.withDefaults(), segmentOffsetInCentimeters = 0, confidence = 0.0, isDrivingInTheWrongWay = false, horizontalAccuracyInMeters = null;
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MapMatchedLocation) return false;
    MapMatchedLocation _other = other;
    return coordinates == _other.coordinates &&
        bearingInDegrees == _other.bearingInDegrees &&
        segmentReference == _other.segmentReference &&
        segmentOffsetInCentimeters == _other.segmentOffsetInCentimeters &&
        confidence == _other.confidence &&
        isDrivingInTheWrongWay == _other.isDrivingInTheWrongWay &&
        horizontalAccuracyInMeters == _other.horizontalAccuracyInMeters;
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + coordinates.hashCode;
    result = 31 * result + bearingInDegrees.hashCode;
    result = 31 * result + segmentReference.hashCode;
    result = 31 * result + segmentOffsetInCentimeters.hashCode;
    result = 31 * result + confidence.hashCode;
    result = 31 * result + isDrivingInTheWrongWay.hashCode;
    result = 31 * result + horizontalAccuracyInMeters.hashCode;
    return result;
  }
}


// MapMatchedLocation "private" section, not exported.

final _sdkNavigationMapmatchedlocationCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, Uint32, Double, Uint8, Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, int, double, int, Pointer<Void>)
  >('here_sdk_sdk_navigation_MapMatchedLocation_create_handle'));
final _sdkNavigationMapmatchedlocationReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_navigation_MapMatchedLocation_release_handle'));
final _sdkNavigationMapmatchedlocationGetFieldcoordinates = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_navigation_MapMatchedLocation_get_field_coordinates'));
final _sdkNavigationMapmatchedlocationGetFieldbearingInDegrees = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_navigation_MapMatchedLocation_get_field_bearingInDegrees'));
final _sdkNavigationMapmatchedlocationGetFieldsegmentReference = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_navigation_MapMatchedLocation_get_field_segmentReference'));
final _sdkNavigationMapmatchedlocationGetFieldsegmentOffsetInCentimeters = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_navigation_MapMatchedLocation_get_field_segmentOffsetInCentimeters'));
final _sdkNavigationMapmatchedlocationGetFieldconfidence = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Double Function(Pointer<Void>),
    double Function(Pointer<Void>)
  >('here_sdk_sdk_navigation_MapMatchedLocation_get_field_confidence'));
final _sdkNavigationMapmatchedlocationGetFieldisDrivingInTheWrongWay = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint8 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_navigation_MapMatchedLocation_get_field_isDrivingInTheWrongWay'));
final _sdkNavigationMapmatchedlocationGetFieldhorizontalAccuracyInMeters = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_navigation_MapMatchedLocation_get_field_horizontalAccuracyInMeters'));



Pointer<Void> sdkNavigationMapmatchedlocationToFfi(MapMatchedLocation value) {
  final _coordinatesHandle = sdkCoreGeocoordinatesToFfi(value.coordinates);
  final _bearingInDegreesHandle = doubleToFfiNullable(value.bearingInDegrees);
  final _segmentReferenceHandle = sdkRoutingSegmentreferenceToFfi(value.segmentReference);
  final _segmentOffsetInCentimetersHandle = (value.segmentOffsetInCentimeters);
  final _confidenceHandle = (value.confidence);
  final _isDrivingInTheWrongWayHandle = booleanToFfi(value.isDrivingInTheWrongWay);
  final _horizontalAccuracyInMetersHandle = doubleToFfiNullable(value.horizontalAccuracyInMeters);
  final _result = _sdkNavigationMapmatchedlocationCreateHandle(_coordinatesHandle, _bearingInDegreesHandle, _segmentReferenceHandle, _segmentOffsetInCentimetersHandle, _confidenceHandle, _isDrivingInTheWrongWayHandle, _horizontalAccuracyInMetersHandle);
  sdkCoreGeocoordinatesReleaseFfiHandle(_coordinatesHandle);
  doubleReleaseFfiHandleNullable(_bearingInDegreesHandle);
  sdkRoutingSegmentreferenceReleaseFfiHandle(_segmentReferenceHandle);
  
  
  booleanReleaseFfiHandle(_isDrivingInTheWrongWayHandle);
  doubleReleaseFfiHandleNullable(_horizontalAccuracyInMetersHandle);
  return _result;
}

MapMatchedLocation sdkNavigationMapmatchedlocationFromFfi(Pointer<Void> handle) {
  final _coordinatesHandle = _sdkNavigationMapmatchedlocationGetFieldcoordinates(handle);
  final _bearingInDegreesHandle = _sdkNavigationMapmatchedlocationGetFieldbearingInDegrees(handle);
  final _segmentReferenceHandle = _sdkNavigationMapmatchedlocationGetFieldsegmentReference(handle);
  final _segmentOffsetInCentimetersHandle = _sdkNavigationMapmatchedlocationGetFieldsegmentOffsetInCentimeters(handle);
  final _confidenceHandle = _sdkNavigationMapmatchedlocationGetFieldconfidence(handle);
  final _isDrivingInTheWrongWayHandle = _sdkNavigationMapmatchedlocationGetFieldisDrivingInTheWrongWay(handle);
  final _horizontalAccuracyInMetersHandle = _sdkNavigationMapmatchedlocationGetFieldhorizontalAccuracyInMeters(handle);
  try {
    return MapMatchedLocation._(
      sdkCoreGeocoordinatesFromFfi(_coordinatesHandle), 
      doubleFromFfiNullable(_bearingInDegreesHandle), 
      sdkRoutingSegmentreferenceFromFfi(_segmentReferenceHandle), 
      (_segmentOffsetInCentimetersHandle), 
      (_confidenceHandle), 
      booleanFromFfi(_isDrivingInTheWrongWayHandle), 
      doubleFromFfiNullable(_horizontalAccuracyInMetersHandle)
    );
  } finally {
    sdkCoreGeocoordinatesReleaseFfiHandle(_coordinatesHandle);
    doubleReleaseFfiHandleNullable(_bearingInDegreesHandle);
    sdkRoutingSegmentreferenceReleaseFfiHandle(_segmentReferenceHandle);
    
    
    booleanReleaseFfiHandle(_isDrivingInTheWrongWayHandle);
    doubleReleaseFfiHandleNullable(_horizontalAccuracyInMetersHandle);
  }
}

void sdkNavigationMapmatchedlocationReleaseFfiHandle(Pointer<Void> handle) => _sdkNavigationMapmatchedlocationReleaseHandle(handle);

// Nullable MapMatchedLocation

final _sdkNavigationMapmatchedlocationCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_navigation_MapMatchedLocation_create_handle_nullable'));
final _sdkNavigationMapmatchedlocationReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_navigation_MapMatchedLocation_release_handle_nullable'));
final _sdkNavigationMapmatchedlocationGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_navigation_MapMatchedLocation_get_value_nullable'));

Pointer<Void> sdkNavigationMapmatchedlocationToFfiNullable(MapMatchedLocation? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkNavigationMapmatchedlocationToFfi(value);
  final result = _sdkNavigationMapmatchedlocationCreateHandleNullable(_handle);
  sdkNavigationMapmatchedlocationReleaseFfiHandle(_handle);
  return result;
}

MapMatchedLocation? sdkNavigationMapmatchedlocationFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkNavigationMapmatchedlocationGetValueNullable(handle);
  final result = sdkNavigationMapmatchedlocationFromFfi(_handle);
  sdkNavigationMapmatchedlocationReleaseFfiHandle(_handle);
  return result;
}

void sdkNavigationMapmatchedlocationReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkNavigationMapmatchedlocationReleaseHandleNullable(handle);

// End of MapMatchedLocation "private" section.


