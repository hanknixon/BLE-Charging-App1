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
import 'package:here_sdk/src/sdk/core/location_technology.dart';

/// Describes a location in the world at a given time.

class Location {
  /// The geographic coordinates of the location.
  GeoCoordinates coordinates;

  /// Bearing (also known as course) is the device's horizontal direction of travel.
  /// Starts at 0 in the geographical north and rotates around the compass in a clockwise
  /// direction. This means for going north it is equal to 0, for northeast it is 45,
  /// for east it is 90 and so on. Note that this may be different from the orientation of
  /// the device. If it cannot be determined, the value is `null`. Otherwise, it is
  /// guaranteed to be in the range \[0, 360).
  double? bearingInDegrees;

  /// Current speed of the device. If it cannot be determined, the value is `null`.
  double? speedInMetersPerSecond;

  /// The time at which the location was determined.
  DateTime? time;

  /// The estimated horizontal accuracy. The actual location will lie within this radius of uncertainty.
  double? horizontalAccuracyInMeters;

  /// Estimated vertical accuracy.
  /// Given that the received Location contains the altitude, the real value of the altitude
  /// is estimated to lie within the following range:
  /// \[altitude - vertical accuracy, altitude + vertical accuracy\].
  /// For example, when the altitude is equal to 50 and the vertical accuracy
  /// is 8, then the actual value is most likely in the range \[42, 58\].
  double? verticalAccuracyInMeters;

  /// Estimated bearing accuracy for this location, in degrees.
  /// If it cannot be determined, the value is `null`.
  double? bearingAccuracyInDegrees;

  /// Estimated speed accuracy of this location, in meters per second.
  /// If it cannot be determined, the value is `null`.
  double? speedAccuracyInMetersPerSecond;

  /// The time at which the location was determined, relative to device
  /// boot time. This time is monotonic and not affected by leap time or other system
  /// time adjustments, so this is the recommended basis for general purpose interval timing
  /// between location updates.
  /// If it cannot be determined, the value is `null`.
  Duration? timestampSinceBoot;

  /// Optional technology or provider of this location.
  /// If it cannot be determined, the value is `null`.
  LocationTechnology? locationTechnology;

  /// Optional gnss time at which the location was determined.
  /// It is a time interval from the Unix time epoch in milliseconds.
  /// If it cannot be determined, the value is `null`.
  Duration? gnssTime;

  /// Pitch of this location, in degrees.
  /// If it cannot be determined, the value is `null`.
  double? pitchInDegrees;

  /// Creates an instance of the class with specified parameters.

  /// [coordinates] The geographic coordinates of the location.

  /// [bearingInDegrees] Bearing (also known as course) is the device's horizontal direction of travel.
  /// Starts at 0 in the geographical north and rotates around the compass in a clockwise
  /// direction. This means for going north it is equal to 0, for northeast it is 45,
  /// for east it is 90 and so on. Note that this may be different from the orientation of
  /// the device. If it cannot be determined, the value is `null`. Otherwise, it is
  /// guaranteed to be in the range \[0, 360).

  /// [speedInMetersPerSecond] Current speed of the device. If it cannot be determined, the value is `null`.

  /// [time] The time at which the location was determined.

  /// [horizontalAccuracyInMeters] The estimated horizontal accuracy. The actual location will lie within this radius of uncertainty.

  /// [verticalAccuracyInMeters] Estimated vertical accuracy.
  /// Given that the received Location contains the altitude, the real value of the altitude
  /// is estimated to lie within the following range:
  /// \[altitude - vertical accuracy, altitude + vertical accuracy\].
  /// For example, when the altitude is equal to 50 and the vertical accuracy
  /// is 8, then the actual value is most likely in the range \[42, 58\].

  /// [bearingAccuracyInDegrees] Estimated bearing accuracy for this location, in degrees.
  /// If it cannot be determined, the value is `null`.

  /// [speedAccuracyInMetersPerSecond] Estimated speed accuracy of this location, in meters per second.
  /// If it cannot be determined, the value is `null`.

  /// [timestampSinceBoot] The time at which the location was determined, relative to device
  /// boot time. This time is monotonic and not affected by leap time or other system
  /// time adjustments, so this is the recommended basis for general purpose interval timing
  /// between location updates.
  /// If it cannot be determined, the value is `null`.

  /// [locationTechnology] Optional technology or provider of this location.
  /// If it cannot be determined, the value is `null`.

  /// [gnssTime] Optional gnss time at which the location was determined.
  /// It is a time interval from the Unix time epoch in milliseconds.
  /// If it cannot be determined, the value is `null`.

  /// [pitchInDegrees] Pitch of this location, in degrees.
  /// If it cannot be determined, the value is `null`.

  Location._(this.coordinates, this.bearingInDegrees, this.speedInMetersPerSecond, this.time, this.horizontalAccuracyInMeters, this.verticalAccuracyInMeters, this.bearingAccuracyInDegrees, this.speedAccuracyInMetersPerSecond, this.timestampSinceBoot, this.locationTechnology, this.gnssTime, this.pitchInDegrees);
  /// Creates a new Location instance from the provided GeoCoordinates value.
  /// timestamp is initialized with `January 1, 1970, 00:00:00 GMT` value.
  /// The rest of the fields will be initialized to null.
  /// [coordinates] The geographic coordinates of the location.
  Location.withCoordinates(this.coordinates)
      : bearingInDegrees = null, speedInMetersPerSecond = null, time = null, horizontalAccuracyInMeters = null, verticalAccuracyInMeters = null, bearingAccuracyInDegrees = null, speedAccuracyInMetersPerSecond = null, timestampSinceBoot = null, locationTechnology = null, gnssTime = null, pitchInDegrees = null;
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Location) return false;
    Location _other = other;
    return coordinates == _other.coordinates &&
        bearingInDegrees == _other.bearingInDegrees &&
        speedInMetersPerSecond == _other.speedInMetersPerSecond &&
        time == _other.time &&
        horizontalAccuracyInMeters == _other.horizontalAccuracyInMeters &&
        verticalAccuracyInMeters == _other.verticalAccuracyInMeters &&
        bearingAccuracyInDegrees == _other.bearingAccuracyInDegrees &&
        speedAccuracyInMetersPerSecond == _other.speedAccuracyInMetersPerSecond &&
        timestampSinceBoot == _other.timestampSinceBoot &&
        locationTechnology == _other.locationTechnology &&
        gnssTime == _other.gnssTime &&
        pitchInDegrees == _other.pitchInDegrees;
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + coordinates.hashCode;
    result = 31 * result + bearingInDegrees.hashCode;
    result = 31 * result + speedInMetersPerSecond.hashCode;
    result = 31 * result + time.hashCode;
    result = 31 * result + horizontalAccuracyInMeters.hashCode;
    result = 31 * result + verticalAccuracyInMeters.hashCode;
    result = 31 * result + bearingAccuracyInDegrees.hashCode;
    result = 31 * result + speedAccuracyInMetersPerSecond.hashCode;
    result = 31 * result + timestampSinceBoot.hashCode;
    result = 31 * result + locationTechnology.hashCode;
    result = 31 * result + gnssTime.hashCode;
    result = 31 * result + pitchInDegrees.hashCode;
    return result;
  }
}


// Location "private" section, not exported.

final _sdkCoreLocationCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>)
  >('here_sdk_sdk_core_Location_create_handle'));
final _sdkCoreLocationReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_core_Location_release_handle'));
final _sdkCoreLocationGetFieldcoordinates = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_Location_get_field_coordinates'));
final _sdkCoreLocationGetFieldbearingInDegrees = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_Location_get_field_bearingInDegrees'));
final _sdkCoreLocationGetFieldspeedInMetersPerSecond = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_Location_get_field_speedInMetersPerSecond'));
final _sdkCoreLocationGetFieldtime = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_Location_get_field_time'));
final _sdkCoreLocationGetFieldhorizontalAccuracyInMeters = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_Location_get_field_horizontalAccuracyInMeters'));
final _sdkCoreLocationGetFieldverticalAccuracyInMeters = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_Location_get_field_verticalAccuracyInMeters'));
final _sdkCoreLocationGetFieldbearingAccuracyInDegrees = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_Location_get_field_bearingAccuracyInDegrees'));
final _sdkCoreLocationGetFieldspeedAccuracyInMetersPerSecond = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_Location_get_field_speedAccuracyInMetersPerSecond'));
final _sdkCoreLocationGetFieldtimestampSinceBoot = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_Location_get_field_timestampSinceBoot'));
final _sdkCoreLocationGetFieldlocationTechnology = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_Location_get_field_locationTechnology'));
final _sdkCoreLocationGetFieldgnssTime = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_Location_get_field_gnssTime'));
final _sdkCoreLocationGetFieldpitchInDegrees = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_Location_get_field_pitchInDegrees'));



Pointer<Void> sdkCoreLocationToFfi(Location value) {
  final _coordinatesHandle = sdkCoreGeocoordinatesToFfi(value.coordinates);
  final _bearingInDegreesHandle = doubleToFfiNullable(value.bearingInDegrees);
  final _speedInMetersPerSecondHandle = doubleToFfiNullable(value.speedInMetersPerSecond);
  final _timeHandle = dateToFfiNullable(value.time);
  final _horizontalAccuracyInMetersHandle = doubleToFfiNullable(value.horizontalAccuracyInMeters);
  final _verticalAccuracyInMetersHandle = doubleToFfiNullable(value.verticalAccuracyInMeters);
  final _bearingAccuracyInDegreesHandle = doubleToFfiNullable(value.bearingAccuracyInDegrees);
  final _speedAccuracyInMetersPerSecondHandle = doubleToFfiNullable(value.speedAccuracyInMetersPerSecond);
  final _timestampSinceBootHandle = durationToFfiNullable(value.timestampSinceBoot);
  final _locationTechnologyHandle = sdkCoreLocationtechnologyToFfiNullable(value.locationTechnology);
  final _gnssTimeHandle = durationToFfiNullable(value.gnssTime);
  final _pitchInDegreesHandle = doubleToFfiNullable(value.pitchInDegrees);
  final _result = _sdkCoreLocationCreateHandle(_coordinatesHandle, _bearingInDegreesHandle, _speedInMetersPerSecondHandle, _timeHandle, _horizontalAccuracyInMetersHandle, _verticalAccuracyInMetersHandle, _bearingAccuracyInDegreesHandle, _speedAccuracyInMetersPerSecondHandle, _timestampSinceBootHandle, _locationTechnologyHandle, _gnssTimeHandle, _pitchInDegreesHandle);
  sdkCoreGeocoordinatesReleaseFfiHandle(_coordinatesHandle);
  doubleReleaseFfiHandleNullable(_bearingInDegreesHandle);
  doubleReleaseFfiHandleNullable(_speedInMetersPerSecondHandle);
  dateReleaseFfiHandleNullable(_timeHandle);
  doubleReleaseFfiHandleNullable(_horizontalAccuracyInMetersHandle);
  doubleReleaseFfiHandleNullable(_verticalAccuracyInMetersHandle);
  doubleReleaseFfiHandleNullable(_bearingAccuracyInDegreesHandle);
  doubleReleaseFfiHandleNullable(_speedAccuracyInMetersPerSecondHandle);
  durationReleaseFfiHandleNullable(_timestampSinceBootHandle);
  sdkCoreLocationtechnologyReleaseFfiHandleNullable(_locationTechnologyHandle);
  durationReleaseFfiHandleNullable(_gnssTimeHandle);
  doubleReleaseFfiHandleNullable(_pitchInDegreesHandle);
  return _result;
}

Location sdkCoreLocationFromFfi(Pointer<Void> handle) {
  final _coordinatesHandle = _sdkCoreLocationGetFieldcoordinates(handle);
  final _bearingInDegreesHandle = _sdkCoreLocationGetFieldbearingInDegrees(handle);
  final _speedInMetersPerSecondHandle = _sdkCoreLocationGetFieldspeedInMetersPerSecond(handle);
  final _timeHandle = _sdkCoreLocationGetFieldtime(handle);
  final _horizontalAccuracyInMetersHandle = _sdkCoreLocationGetFieldhorizontalAccuracyInMeters(handle);
  final _verticalAccuracyInMetersHandle = _sdkCoreLocationGetFieldverticalAccuracyInMeters(handle);
  final _bearingAccuracyInDegreesHandle = _sdkCoreLocationGetFieldbearingAccuracyInDegrees(handle);
  final _speedAccuracyInMetersPerSecondHandle = _sdkCoreLocationGetFieldspeedAccuracyInMetersPerSecond(handle);
  final _timestampSinceBootHandle = _sdkCoreLocationGetFieldtimestampSinceBoot(handle);
  final _locationTechnologyHandle = _sdkCoreLocationGetFieldlocationTechnology(handle);
  final _gnssTimeHandle = _sdkCoreLocationGetFieldgnssTime(handle);
  final _pitchInDegreesHandle = _sdkCoreLocationGetFieldpitchInDegrees(handle);
  try {
    return Location._(
      sdkCoreGeocoordinatesFromFfi(_coordinatesHandle), 
      doubleFromFfiNullable(_bearingInDegreesHandle), 
      doubleFromFfiNullable(_speedInMetersPerSecondHandle), 
      dateFromFfiNullable(_timeHandle), 
      doubleFromFfiNullable(_horizontalAccuracyInMetersHandle), 
      doubleFromFfiNullable(_verticalAccuracyInMetersHandle), 
      doubleFromFfiNullable(_bearingAccuracyInDegreesHandle), 
      doubleFromFfiNullable(_speedAccuracyInMetersPerSecondHandle), 
      durationFromFfiNullable(_timestampSinceBootHandle), 
      sdkCoreLocationtechnologyFromFfiNullable(_locationTechnologyHandle), 
      durationFromFfiNullable(_gnssTimeHandle), 
      doubleFromFfiNullable(_pitchInDegreesHandle)
    );
  } finally {
    sdkCoreGeocoordinatesReleaseFfiHandle(_coordinatesHandle);
    doubleReleaseFfiHandleNullable(_bearingInDegreesHandle);
    doubleReleaseFfiHandleNullable(_speedInMetersPerSecondHandle);
    dateReleaseFfiHandleNullable(_timeHandle);
    doubleReleaseFfiHandleNullable(_horizontalAccuracyInMetersHandle);
    doubleReleaseFfiHandleNullable(_verticalAccuracyInMetersHandle);
    doubleReleaseFfiHandleNullable(_bearingAccuracyInDegreesHandle);
    doubleReleaseFfiHandleNullable(_speedAccuracyInMetersPerSecondHandle);
    durationReleaseFfiHandleNullable(_timestampSinceBootHandle);
    sdkCoreLocationtechnologyReleaseFfiHandleNullable(_locationTechnologyHandle);
    durationReleaseFfiHandleNullable(_gnssTimeHandle);
    doubleReleaseFfiHandleNullable(_pitchInDegreesHandle);
  }
}

void sdkCoreLocationReleaseFfiHandle(Pointer<Void> handle) => _sdkCoreLocationReleaseHandle(handle);

// Nullable Location

final _sdkCoreLocationCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_Location_create_handle_nullable'));
final _sdkCoreLocationReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_core_Location_release_handle_nullable'));
final _sdkCoreLocationGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_Location_get_value_nullable'));

Pointer<Void> sdkCoreLocationToFfiNullable(Location? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkCoreLocationToFfi(value);
  final result = _sdkCoreLocationCreateHandleNullable(_handle);
  sdkCoreLocationReleaseFfiHandle(_handle);
  return result;
}

Location? sdkCoreLocationFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkCoreLocationGetValueNullable(handle);
  final result = sdkCoreLocationFromFfi(_handle);
  sdkCoreLocationReleaseFfiHandle(_handle);
  return result;
}

void sdkCoreLocationReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkCoreLocationReleaseHandleNullable(handle);

// End of Location "private" section.


