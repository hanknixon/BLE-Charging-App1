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
import 'package:here_sdk/src/sdk/routing/allow_options.dart';
import 'package:here_sdk/src/sdk/routing/avoidance_options.dart';
import 'package:here_sdk/src/sdk/routing/max_speed_on_segment.dart';
import 'package:here_sdk/src/sdk/routing/route_options.dart';
import 'package:here_sdk/src/sdk/routing/route_text_options.dart';
import 'package:here_sdk/src/sdk/routing/toll_options.dart';

/// The options defines the common routing options.
///
/// **Note:** This is a beta release of this feature, so there could be a few bugs and unexpected behaviors.
/// Related APIs may change for new releases without a deprecation process.

class CommonRouteOptions {
  /// Specifies the common route calculation options.
  RouteOptions routeOptions;

  /// Customize textual content returned from the route calculation, such
  /// as localization, format, and unit system.
  RouteTextOptions textOptions;

  /// Options to specify restrictions for route calculations. By default
  /// no restrictions are applied.
  AvoidanceOptions avoidanceOptions;

  /// The options explicitly allowed by user for route calculations. By default
  /// no options are opt in.
  AllowOptions allowOptions;

  /// Options to specify how the tolls should be calculated,
  /// such as transponders, vehicle category, and emission type.
  /// **Note**
  /// Not used for offline calculations.
  TollOptions tollOptions;

  /// Segments with restriction on maximum [DynamicSpeedInfo.baseSpeedInMetersPerSecond].
  /// **Note**
  /// Not used for offline calculations.
  List<MaxSpeedOnSegment> maxSpeedOnSegments;

  /// Creates a new instance.

  /// [routeOptions] Specifies the common route calculation options.

  /// [textOptions] Customize textual content returned from the route calculation, such
  /// as localization, format, and unit system.

  /// [avoidanceOptions] Options to specify restrictions for route calculations. By default
  /// no restrictions are applied.

  /// [allowOptions] The options explicitly allowed by user for route calculations. By default
  /// no options are opt in.

  /// [tollOptions] Options to specify how the tolls should be calculated,
  /// such as transponders, vehicle category, and emission type.
  /// **Note**
  /// Not used for offline calculations.

  /// [maxSpeedOnSegments] Segments with restriction on maximum [DynamicSpeedInfo.baseSpeedInMetersPerSecond].
  /// **Note**
  /// Not used for offline calculations.

  CommonRouteOptions._(this.routeOptions, this.textOptions, this.avoidanceOptions, this.allowOptions, this.tollOptions, this.maxSpeedOnSegments);
  CommonRouteOptions()
    : routeOptions = RouteOptions.withDefaults(), textOptions = RouteTextOptions(), avoidanceOptions = AvoidanceOptions(), allowOptions = AllowOptions(), tollOptions = TollOptions(), maxSpeedOnSegments = [];
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CommonRouteOptions) return false;
    CommonRouteOptions _other = other;
    return routeOptions == _other.routeOptions &&
        textOptions == _other.textOptions &&
        avoidanceOptions == _other.avoidanceOptions &&
        allowOptions == _other.allowOptions &&
        tollOptions == _other.tollOptions &&
        DeepCollectionEquality().equals(maxSpeedOnSegments, _other.maxSpeedOnSegments);
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + routeOptions.hashCode;
    result = 31 * result + textOptions.hashCode;
    result = 31 * result + avoidanceOptions.hashCode;
    result = 31 * result + allowOptions.hashCode;
    result = 31 * result + tollOptions.hashCode;
    result = 31 * result + DeepCollectionEquality().hash(maxSpeedOnSegments);
    return result;
  }
}


// CommonRouteOptions "private" section, not exported.

final _sdkRoutingCommonrouteoptionsCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>)
  >('here_sdk_sdk_routing_CommonRouteOptions_create_handle'));
final _sdkRoutingCommonrouteoptionsReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_CommonRouteOptions_release_handle'));
final _sdkRoutingCommonrouteoptionsGetFieldrouteOptions = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_CommonRouteOptions_get_field_routeOptions'));
final _sdkRoutingCommonrouteoptionsGetFieldtextOptions = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_CommonRouteOptions_get_field_textOptions'));
final _sdkRoutingCommonrouteoptionsGetFieldavoidanceOptions = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_CommonRouteOptions_get_field_avoidanceOptions'));
final _sdkRoutingCommonrouteoptionsGetFieldallowOptions = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_CommonRouteOptions_get_field_allowOptions'));
final _sdkRoutingCommonrouteoptionsGetFieldtollOptions = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_CommonRouteOptions_get_field_tollOptions'));
final _sdkRoutingCommonrouteoptionsGetFieldmaxSpeedOnSegments = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_CommonRouteOptions_get_field_maxSpeedOnSegments'));



Pointer<Void> sdkRoutingCommonrouteoptionsToFfi(CommonRouteOptions value) {
  final _routeOptionsHandle = sdkRoutingRouteoptionsToFfi(value.routeOptions);
  final _textOptionsHandle = sdkRoutingRoutetextoptionsToFfi(value.textOptions);
  final _avoidanceOptionsHandle = sdkRoutingAvoidanceoptionsToFfi(value.avoidanceOptions);
  final _allowOptionsHandle = sdkRoutingAllowoptionsToFfi(value.allowOptions);
  final _tollOptionsHandle = sdkRoutingTolloptionsToFfi(value.tollOptions);
  final _maxSpeedOnSegmentsHandle = heresdkRoutingCommonBindingslistofSdkRoutingMaxspeedonsegmentToFfi(value.maxSpeedOnSegments);
  final _result = _sdkRoutingCommonrouteoptionsCreateHandle(_routeOptionsHandle, _textOptionsHandle, _avoidanceOptionsHandle, _allowOptionsHandle, _tollOptionsHandle, _maxSpeedOnSegmentsHandle);
  sdkRoutingRouteoptionsReleaseFfiHandle(_routeOptionsHandle);
  sdkRoutingRoutetextoptionsReleaseFfiHandle(_textOptionsHandle);
  sdkRoutingAvoidanceoptionsReleaseFfiHandle(_avoidanceOptionsHandle);
  sdkRoutingAllowoptionsReleaseFfiHandle(_allowOptionsHandle);
  sdkRoutingTolloptionsReleaseFfiHandle(_tollOptionsHandle);
  heresdkRoutingCommonBindingslistofSdkRoutingMaxspeedonsegmentReleaseFfiHandle(_maxSpeedOnSegmentsHandle);
  return _result;
}

CommonRouteOptions sdkRoutingCommonrouteoptionsFromFfi(Pointer<Void> handle) {
  final _routeOptionsHandle = _sdkRoutingCommonrouteoptionsGetFieldrouteOptions(handle);
  final _textOptionsHandle = _sdkRoutingCommonrouteoptionsGetFieldtextOptions(handle);
  final _avoidanceOptionsHandle = _sdkRoutingCommonrouteoptionsGetFieldavoidanceOptions(handle);
  final _allowOptionsHandle = _sdkRoutingCommonrouteoptionsGetFieldallowOptions(handle);
  final _tollOptionsHandle = _sdkRoutingCommonrouteoptionsGetFieldtollOptions(handle);
  final _maxSpeedOnSegmentsHandle = _sdkRoutingCommonrouteoptionsGetFieldmaxSpeedOnSegments(handle);
  try {
    return CommonRouteOptions._(
      sdkRoutingRouteoptionsFromFfi(_routeOptionsHandle), 
      sdkRoutingRoutetextoptionsFromFfi(_textOptionsHandle), 
      sdkRoutingAvoidanceoptionsFromFfi(_avoidanceOptionsHandle), 
      sdkRoutingAllowoptionsFromFfi(_allowOptionsHandle), 
      sdkRoutingTolloptionsFromFfi(_tollOptionsHandle), 
      heresdkRoutingCommonBindingslistofSdkRoutingMaxspeedonsegmentFromFfi(_maxSpeedOnSegmentsHandle)
    );
  } finally {
    sdkRoutingRouteoptionsReleaseFfiHandle(_routeOptionsHandle);
    sdkRoutingRoutetextoptionsReleaseFfiHandle(_textOptionsHandle);
    sdkRoutingAvoidanceoptionsReleaseFfiHandle(_avoidanceOptionsHandle);
    sdkRoutingAllowoptionsReleaseFfiHandle(_allowOptionsHandle);
    sdkRoutingTolloptionsReleaseFfiHandle(_tollOptionsHandle);
    heresdkRoutingCommonBindingslistofSdkRoutingMaxspeedonsegmentReleaseFfiHandle(_maxSpeedOnSegmentsHandle);
  }
}

void sdkRoutingCommonrouteoptionsReleaseFfiHandle(Pointer<Void> handle) => _sdkRoutingCommonrouteoptionsReleaseHandle(handle);

// Nullable CommonRouteOptions

final _sdkRoutingCommonrouteoptionsCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_CommonRouteOptions_create_handle_nullable'));
final _sdkRoutingCommonrouteoptionsReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_CommonRouteOptions_release_handle_nullable'));
final _sdkRoutingCommonrouteoptionsGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_CommonRouteOptions_get_value_nullable'));

Pointer<Void> sdkRoutingCommonrouteoptionsToFfiNullable(CommonRouteOptions? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkRoutingCommonrouteoptionsToFfi(value);
  final result = _sdkRoutingCommonrouteoptionsCreateHandleNullable(_handle);
  sdkRoutingCommonrouteoptionsReleaseFfiHandle(_handle);
  return result;
}

CommonRouteOptions? sdkRoutingCommonrouteoptionsFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkRoutingCommonrouteoptionsGetValueNullable(handle);
  final result = sdkRoutingCommonrouteoptionsFromFfi(_handle);
  sdkRoutingCommonrouteoptionsReleaseFfiHandle(_handle);
  return result;
}

void sdkRoutingCommonrouteoptionsReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkRoutingCommonrouteoptionsReleaseHandleNullable(handle);

// End of CommonRouteOptions "private" section.


