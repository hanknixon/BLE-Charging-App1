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
import 'package:here_sdk/src/builtin_types__conversion.dart';
import 'package:here_sdk/src/generic_types__conversion.dart';
import 'package:here_sdk/src/sdk/core/geo_polyline.dart';

/// The location reference to the incident.

class TrafficLocation {
  /// The description of the location. In general, the language can't be bound to the description.
  /// Usually, the language is one of the local languages of the incident region (undefined which one exactly).
  /// Note: A localizable description of the incident is part of [TrafficIncidentBase.description].
  /// This description describes only the location where the incident occurred.
  /// Defaults to an empty string.
  String description;

  /// The polyline representing the traffic entity shape.
  /// Note: The current field contains a continuous polyline with no gaps between geo-coordinates.
  /// All others following the gap are present in the `additional_polylines` field.
  GeoPolyline polyline;

  /// List of polylines that were not included in polyline.
  List<GeoPolyline> additionalPolylines;

  /// The affected road length in meters.
  /// The length can be 0 only if the incident supplier has provided incomplete data.
  int lengthInMeters;

  TrafficLocation._(this.description, this.polyline, this.additionalPolylines, this.lengthInMeters);
  /// Creates a new instance.
  /// [polyline] The polyline representing the traffic entity shape.
  /// Note: The current field contains a continuous polyline with no gaps between geo-coordinates.
  /// All others following the gap are present in the `additional_polylines` field.
  /// [additionalPolylines] List of polylines that were not included in polyline.
  /// [lengthInMeters] The affected road length in meters.
  /// The length can be 0 only if the incident supplier has provided incomplete data.
  TrafficLocation(this.polyline, this.additionalPolylines, this.lengthInMeters)
      : description = "";
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TrafficLocation) return false;
    TrafficLocation _other = other;
    return description == _other.description &&
        polyline == _other.polyline &&
        DeepCollectionEquality().equals(additionalPolylines, _other.additionalPolylines) &&
        lengthInMeters == _other.lengthInMeters;
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + description.hashCode;
    result = 31 * result + polyline.hashCode;
    result = 31 * result + DeepCollectionEquality().hash(additionalPolylines);
    result = 31 * result + lengthInMeters.hashCode;
    return result;
  }
}


// TrafficLocation "private" section, not exported.

final _sdkTrafficTrafficlocationCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, Int32),
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, int)
  >('here_sdk_sdk_traffic_TrafficLocation_create_handle'));
final _sdkTrafficTrafficlocationReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_traffic_TrafficLocation_release_handle'));
final _sdkTrafficTrafficlocationGetFielddescription = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_traffic_TrafficLocation_get_field_description'));
final _sdkTrafficTrafficlocationGetFieldpolyline = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_traffic_TrafficLocation_get_field_polyline'));
final _sdkTrafficTrafficlocationGetFieldadditionalPolylines = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_traffic_TrafficLocation_get_field_additionalPolylines'));
final _sdkTrafficTrafficlocationGetFieldlengthInMeters = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Int32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_traffic_TrafficLocation_get_field_lengthInMeters'));



Pointer<Void> sdkTrafficTrafficlocationToFfi(TrafficLocation value) {
  final _descriptionHandle = stringToFfi(value.description);
  final _polylineHandle = sdkCoreGeopolylineToFfi(value.polyline);
  final _additionalPolylinesHandle = heresdkTrafficBindingslistofSdkCoreGeopolylineToFfi(value.additionalPolylines);
  final _lengthInMetersHandle = (value.lengthInMeters);
  final _result = _sdkTrafficTrafficlocationCreateHandle(_descriptionHandle, _polylineHandle, _additionalPolylinesHandle, _lengthInMetersHandle);
  stringReleaseFfiHandle(_descriptionHandle);
  sdkCoreGeopolylineReleaseFfiHandle(_polylineHandle);
  heresdkTrafficBindingslistofSdkCoreGeopolylineReleaseFfiHandle(_additionalPolylinesHandle);
  
  return _result;
}

TrafficLocation sdkTrafficTrafficlocationFromFfi(Pointer<Void> handle) {
  final _descriptionHandle = _sdkTrafficTrafficlocationGetFielddescription(handle);
  final _polylineHandle = _sdkTrafficTrafficlocationGetFieldpolyline(handle);
  final _additionalPolylinesHandle = _sdkTrafficTrafficlocationGetFieldadditionalPolylines(handle);
  final _lengthInMetersHandle = _sdkTrafficTrafficlocationGetFieldlengthInMeters(handle);
  try {
    return TrafficLocation._(
      stringFromFfi(_descriptionHandle), 
      sdkCoreGeopolylineFromFfi(_polylineHandle), 
      heresdkTrafficBindingslistofSdkCoreGeopolylineFromFfi(_additionalPolylinesHandle), 
      (_lengthInMetersHandle)
    );
  } finally {
    stringReleaseFfiHandle(_descriptionHandle);
    sdkCoreGeopolylineReleaseFfiHandle(_polylineHandle);
    heresdkTrafficBindingslistofSdkCoreGeopolylineReleaseFfiHandle(_additionalPolylinesHandle);
    
  }
}

void sdkTrafficTrafficlocationReleaseFfiHandle(Pointer<Void> handle) => _sdkTrafficTrafficlocationReleaseHandle(handle);

// Nullable TrafficLocation

final _sdkTrafficTrafficlocationCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_traffic_TrafficLocation_create_handle_nullable'));
final _sdkTrafficTrafficlocationReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_traffic_TrafficLocation_release_handle_nullable'));
final _sdkTrafficTrafficlocationGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_traffic_TrafficLocation_get_value_nullable'));

Pointer<Void> sdkTrafficTrafficlocationToFfiNullable(TrafficLocation? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkTrafficTrafficlocationToFfi(value);
  final result = _sdkTrafficTrafficlocationCreateHandleNullable(_handle);
  sdkTrafficTrafficlocationReleaseFfiHandle(_handle);
  return result;
}

TrafficLocation? sdkTrafficTrafficlocationFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkTrafficTrafficlocationGetValueNullable(handle);
  final result = sdkTrafficTrafficlocationFromFfi(_handle);
  sdkTrafficTrafficlocationReleaseFfiHandle(_handle);
  return result;
}

void sdkTrafficTrafficlocationReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkTrafficTrafficlocationReleaseHandleNullable(handle);

// End of TrafficLocation "private" section.


