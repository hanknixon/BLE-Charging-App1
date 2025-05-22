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
import 'package:here_sdk/src/sdk/core/country_code.dart';
import 'package:here_sdk/src/sdk/routing/avoid_bounding_box_area_options.dart';
import 'package:here_sdk/src/sdk/routing/avoid_corridor_area_options.dart';
import 'package:here_sdk/src/sdk/routing/avoid_polygon_area_options.dart';
import 'package:here_sdk/src/sdk/routing/road_features.dart';
import 'package:here_sdk/src/sdk/routing/segment_reference.dart';
import 'package:here_sdk/src/sdk/routing/zone_category.dart';

/// The options to specify restrictions for route calculations.

class AvoidanceOptions {
  /// Features which routes should avoid. Best effort only (not enforced).
  List<RoadFeatures> roadFeatures;

  /// Countries that the route must avoid. Strictly enforced.
  /// Violations are reported as [SectionNoticeCode.violatedBlockedRoad].
  /// **Note:** This avoidance option is not supported in `IsolineOptions` for isoline calculation.
  List<CountryCode> countries;

  /// List of rectangular shapes which routes must not cross and additional options for this area.
  List<AvoidBoundingBoxAreaOptions> avoidBoundingBoxAreasOptions;

  /// List of polygon shapes which routes must not cross and additional options for this area.
  /// **Note:** Currently, the maximum count of polygons is limited to 20.
  List<AvoidPolygonAreaOptions> avoidPolygonAreasOptions;

  /// List of corridor shapes which routes must not cross and additional options for this area.
  /// **Note:** Currently, the maximum count of corridors is limited to 20.
  List<AvoidCorridorAreaOptions> avoidCorridorAreasOptions;

  /// Zone categories which routes must not cross. Strictly enforced.
  /// Violations are reported as [SectionNoticeCode.violatedZoneRestriction].
  /// **Note:** This avoidance option is not supported in `IsolineOptions` for isoline calculation.
  List<ZoneCategory> zoneCategories;

  /// Segments that routes will avoid going through.
  /// Violations are reported as [SectionNoticeCode.violatedBlockedRoad].
  ///
  /// **Notes:**
  /// - This avoidance option is not supported in `IsolineOptions` for isoline calculation.
  /// - The engine does not support an unlimited number of segments to avoid.
  ///   The limit is defined by the HERE backend services and may change. For now,
  ///   the maximum number of segments to avoid should be below 250. This value may change
  ///   on the backend and it is therefore not guaranteed to be stable.
  List<SegmentReference> segments;

  /// Exception to `AvoidanceOptions.zone_categories`, which can be specified by list of zone identifiers.
  /// e.g. the format of ID is like `here:cm:envzone:2`.
  /// Information about the various routing zones originates from the respective catalogs of platform.here.com.
  /// For example, more information on zone IDs for Environmental Zones is available under "https://platform.here.com/data/hrn:here:data::olp-here:rib-2/environmental-zones/overview".
  List<String> exceptZoneIds;

  /// List containing identifiers of zones that routes should avoid going through.
  /// e.g. the format of ID is like `here:cm:envzone:2`.
  /// Information about the various routing zones originates from the respective catalogs of platform.here.com.
  /// For example, more information on zone IDs for Environmental Zones is available under "https://platform.here.com/data/hrn:here:data::olp-here:rib-2/environmental-zones/overview".
  /// **Note:** This avoidance option is not supported in `IsolineOptions` for isoline calculation.
  List<String> zoneIds;

  /// Creates a new instance.

  /// [roadFeatures] Features which routes should avoid. Best effort only (not enforced).

  /// [countries] Countries that the route must avoid. Strictly enforced.
  /// Violations are reported as [SectionNoticeCode.violatedBlockedRoad].
  /// **Note:** This avoidance option is not supported in `IsolineOptions` for isoline calculation.

  /// [avoidBoundingBoxAreasOptions] List of rectangular shapes which routes must not cross and additional options for this area.

  /// [avoidPolygonAreasOptions] List of polygon shapes which routes must not cross and additional options for this area.
  /// **Note:** Currently, the maximum count of polygons is limited to 20.

  /// [avoidCorridorAreasOptions] List of corridor shapes which routes must not cross and additional options for this area.
  /// **Note:** Currently, the maximum count of corridors is limited to 20.

  /// [zoneCategories] Zone categories which routes must not cross. Strictly enforced.
  /// Violations are reported as [SectionNoticeCode.violatedZoneRestriction].
  /// **Note:** This avoidance option is not supported in `IsolineOptions` for isoline calculation.

  /// [segments] Segments that routes will avoid going through.
  /// Violations are reported as [SectionNoticeCode.violatedBlockedRoad].
  ///
  /// **Notes:**
  /// - This avoidance option is not supported in `IsolineOptions` for isoline calculation.
  /// - The engine does not support an unlimited number of segments to avoid.
  ///   The limit is defined by the HERE backend services and may change. For now,
  ///   the maximum number of segments to avoid should be below 250. This value may change
  ///   on the backend and it is therefore not guaranteed to be stable.

  /// [exceptZoneIds] Exception to `AvoidanceOptions.zone_categories`, which can be specified by list of zone identifiers.
  /// e.g. the format of ID is like `here:cm:envzone:2`.
  /// Information about the various routing zones originates from the respective catalogs of platform.here.com.
  /// For example, more information on zone IDs for Environmental Zones is available under "https://platform.here.com/data/hrn:here:data::olp-here:rib-2/environmental-zones/overview".

  /// [zoneIds] List containing identifiers of zones that routes should avoid going through.
  /// e.g. the format of ID is like `here:cm:envzone:2`.
  /// Information about the various routing zones originates from the respective catalogs of platform.here.com.
  /// For example, more information on zone IDs for Environmental Zones is available under "https://platform.here.com/data/hrn:here:data::olp-here:rib-2/environmental-zones/overview".
  /// **Note:** This avoidance option is not supported in `IsolineOptions` for isoline calculation.

  AvoidanceOptions._(this.roadFeatures, this.countries, this.avoidBoundingBoxAreasOptions, this.avoidPolygonAreasOptions, this.avoidCorridorAreasOptions, this.zoneCategories, this.segments, this.exceptZoneIds, this.zoneIds);
  AvoidanceOptions()
    : roadFeatures = [], countries = [], avoidBoundingBoxAreasOptions = [], avoidPolygonAreasOptions = [], avoidCorridorAreasOptions = [], zoneCategories = [], segments = [], exceptZoneIds = [], zoneIds = [];
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AvoidanceOptions) return false;
    AvoidanceOptions _other = other;
    return DeepCollectionEquality().equals(roadFeatures, _other.roadFeatures) &&
        DeepCollectionEquality().equals(countries, _other.countries) &&
        DeepCollectionEquality().equals(avoidBoundingBoxAreasOptions, _other.avoidBoundingBoxAreasOptions) &&
        DeepCollectionEquality().equals(avoidPolygonAreasOptions, _other.avoidPolygonAreasOptions) &&
        DeepCollectionEquality().equals(avoidCorridorAreasOptions, _other.avoidCorridorAreasOptions) &&
        DeepCollectionEquality().equals(zoneCategories, _other.zoneCategories) &&
        DeepCollectionEquality().equals(segments, _other.segments) &&
        DeepCollectionEquality().equals(exceptZoneIds, _other.exceptZoneIds) &&
        DeepCollectionEquality().equals(zoneIds, _other.zoneIds);
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + DeepCollectionEquality().hash(roadFeatures);
    result = 31 * result + DeepCollectionEquality().hash(countries);
    result = 31 * result + DeepCollectionEquality().hash(avoidBoundingBoxAreasOptions);
    result = 31 * result + DeepCollectionEquality().hash(avoidPolygonAreasOptions);
    result = 31 * result + DeepCollectionEquality().hash(avoidCorridorAreasOptions);
    result = 31 * result + DeepCollectionEquality().hash(zoneCategories);
    result = 31 * result + DeepCollectionEquality().hash(segments);
    result = 31 * result + DeepCollectionEquality().hash(exceptZoneIds);
    result = 31 * result + DeepCollectionEquality().hash(zoneIds);
    return result;
  }
}


// AvoidanceOptions "private" section, not exported.

final _sdkRoutingAvoidanceoptionsCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>)
  >('here_sdk_sdk_routing_AvoidanceOptions_create_handle'));
final _sdkRoutingAvoidanceoptionsReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_AvoidanceOptions_release_handle'));
final _sdkRoutingAvoidanceoptionsGetFieldroadFeatures = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_AvoidanceOptions_get_field_roadFeatures'));
final _sdkRoutingAvoidanceoptionsGetFieldcountries = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_AvoidanceOptions_get_field_countries'));
final _sdkRoutingAvoidanceoptionsGetFieldavoidBoundingBoxAreasOptions = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_AvoidanceOptions_get_field_avoidBoundingBoxAreasOptions'));
final _sdkRoutingAvoidanceoptionsGetFieldavoidPolygonAreasOptions = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_AvoidanceOptions_get_field_avoidPolygonAreasOptions'));
final _sdkRoutingAvoidanceoptionsGetFieldavoidCorridorAreasOptions = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_AvoidanceOptions_get_field_avoidCorridorAreasOptions'));
final _sdkRoutingAvoidanceoptionsGetFieldzoneCategories = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_AvoidanceOptions_get_field_zoneCategories'));
final _sdkRoutingAvoidanceoptionsGetFieldsegments = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_AvoidanceOptions_get_field_segments'));
final _sdkRoutingAvoidanceoptionsGetFieldexceptZoneIds = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_AvoidanceOptions_get_field_exceptZoneIds'));
final _sdkRoutingAvoidanceoptionsGetFieldzoneIds = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_AvoidanceOptions_get_field_zoneIds'));



Pointer<Void> sdkRoutingAvoidanceoptionsToFfi(AvoidanceOptions value) {
  final _roadFeaturesHandle = heresdkRoutingCommonBindingslistofSdkRoutingRoadfeaturesToFfi(value.roadFeatures);
  final _countriesHandle = heresdkRoutingCommonBindingslistofSdkCoreCountrycodeToFfi(value.countries);
  final _avoidBoundingBoxAreasOptionsHandle = heresdkRoutingCommonBindingslistofSdkRoutingAvoidboundingboxareaoptionsToFfi(value.avoidBoundingBoxAreasOptions);
  final _avoidPolygonAreasOptionsHandle = heresdkRoutingCommonBindingslistofSdkRoutingAvoidpolygonareaoptionsToFfi(value.avoidPolygonAreasOptions);
  final _avoidCorridorAreasOptionsHandle = heresdkRoutingCommonBindingslistofSdkRoutingAvoidcorridorareaoptionsToFfi(value.avoidCorridorAreasOptions);
  final _zoneCategoriesHandle = heresdkRoutingCommonBindingslistofSdkRoutingZonecategoryToFfi(value.zoneCategories);
  final _segmentsHandle = heresdkRoutingCommonBindingslistofSdkRoutingSegmentreferenceToFfi(value.segments);
  final _exceptZoneIdsHandle = heresdkRoutingCommonBindingslistofStringToFfi(value.exceptZoneIds);
  final _zoneIdsHandle = heresdkRoutingCommonBindingslistofStringToFfi(value.zoneIds);
  final _result = _sdkRoutingAvoidanceoptionsCreateHandle(_roadFeaturesHandle, _countriesHandle, _avoidBoundingBoxAreasOptionsHandle, _avoidPolygonAreasOptionsHandle, _avoidCorridorAreasOptionsHandle, _zoneCategoriesHandle, _segmentsHandle, _exceptZoneIdsHandle, _zoneIdsHandle);
  heresdkRoutingCommonBindingslistofSdkRoutingRoadfeaturesReleaseFfiHandle(_roadFeaturesHandle);
  heresdkRoutingCommonBindingslistofSdkCoreCountrycodeReleaseFfiHandle(_countriesHandle);
  heresdkRoutingCommonBindingslistofSdkRoutingAvoidboundingboxareaoptionsReleaseFfiHandle(_avoidBoundingBoxAreasOptionsHandle);
  heresdkRoutingCommonBindingslistofSdkRoutingAvoidpolygonareaoptionsReleaseFfiHandle(_avoidPolygonAreasOptionsHandle);
  heresdkRoutingCommonBindingslistofSdkRoutingAvoidcorridorareaoptionsReleaseFfiHandle(_avoidCorridorAreasOptionsHandle);
  heresdkRoutingCommonBindingslistofSdkRoutingZonecategoryReleaseFfiHandle(_zoneCategoriesHandle);
  heresdkRoutingCommonBindingslistofSdkRoutingSegmentreferenceReleaseFfiHandle(_segmentsHandle);
  heresdkRoutingCommonBindingslistofStringReleaseFfiHandle(_exceptZoneIdsHandle);
  heresdkRoutingCommonBindingslistofStringReleaseFfiHandle(_zoneIdsHandle);
  return _result;
}

AvoidanceOptions sdkRoutingAvoidanceoptionsFromFfi(Pointer<Void> handle) {
  final _roadFeaturesHandle = _sdkRoutingAvoidanceoptionsGetFieldroadFeatures(handle);
  final _countriesHandle = _sdkRoutingAvoidanceoptionsGetFieldcountries(handle);
  final _avoidBoundingBoxAreasOptionsHandle = _sdkRoutingAvoidanceoptionsGetFieldavoidBoundingBoxAreasOptions(handle);
  final _avoidPolygonAreasOptionsHandle = _sdkRoutingAvoidanceoptionsGetFieldavoidPolygonAreasOptions(handle);
  final _avoidCorridorAreasOptionsHandle = _sdkRoutingAvoidanceoptionsGetFieldavoidCorridorAreasOptions(handle);
  final _zoneCategoriesHandle = _sdkRoutingAvoidanceoptionsGetFieldzoneCategories(handle);
  final _segmentsHandle = _sdkRoutingAvoidanceoptionsGetFieldsegments(handle);
  final _exceptZoneIdsHandle = _sdkRoutingAvoidanceoptionsGetFieldexceptZoneIds(handle);
  final _zoneIdsHandle = _sdkRoutingAvoidanceoptionsGetFieldzoneIds(handle);
  try {
    return AvoidanceOptions._(
      heresdkRoutingCommonBindingslistofSdkRoutingRoadfeaturesFromFfi(_roadFeaturesHandle), 
      heresdkRoutingCommonBindingslistofSdkCoreCountrycodeFromFfi(_countriesHandle), 
      heresdkRoutingCommonBindingslistofSdkRoutingAvoidboundingboxareaoptionsFromFfi(_avoidBoundingBoxAreasOptionsHandle), 
      heresdkRoutingCommonBindingslistofSdkRoutingAvoidpolygonareaoptionsFromFfi(_avoidPolygonAreasOptionsHandle), 
      heresdkRoutingCommonBindingslistofSdkRoutingAvoidcorridorareaoptionsFromFfi(_avoidCorridorAreasOptionsHandle), 
      heresdkRoutingCommonBindingslistofSdkRoutingZonecategoryFromFfi(_zoneCategoriesHandle), 
      heresdkRoutingCommonBindingslistofSdkRoutingSegmentreferenceFromFfi(_segmentsHandle), 
      heresdkRoutingCommonBindingslistofStringFromFfi(_exceptZoneIdsHandle), 
      heresdkRoutingCommonBindingslistofStringFromFfi(_zoneIdsHandle)
    );
  } finally {
    heresdkRoutingCommonBindingslistofSdkRoutingRoadfeaturesReleaseFfiHandle(_roadFeaturesHandle);
    heresdkRoutingCommonBindingslistofSdkCoreCountrycodeReleaseFfiHandle(_countriesHandle);
    heresdkRoutingCommonBindingslistofSdkRoutingAvoidboundingboxareaoptionsReleaseFfiHandle(_avoidBoundingBoxAreasOptionsHandle);
    heresdkRoutingCommonBindingslistofSdkRoutingAvoidpolygonareaoptionsReleaseFfiHandle(_avoidPolygonAreasOptionsHandle);
    heresdkRoutingCommonBindingslistofSdkRoutingAvoidcorridorareaoptionsReleaseFfiHandle(_avoidCorridorAreasOptionsHandle);
    heresdkRoutingCommonBindingslistofSdkRoutingZonecategoryReleaseFfiHandle(_zoneCategoriesHandle);
    heresdkRoutingCommonBindingslistofSdkRoutingSegmentreferenceReleaseFfiHandle(_segmentsHandle);
    heresdkRoutingCommonBindingslistofStringReleaseFfiHandle(_exceptZoneIdsHandle);
    heresdkRoutingCommonBindingslistofStringReleaseFfiHandle(_zoneIdsHandle);
  }
}

void sdkRoutingAvoidanceoptionsReleaseFfiHandle(Pointer<Void> handle) => _sdkRoutingAvoidanceoptionsReleaseHandle(handle);

// Nullable AvoidanceOptions

final _sdkRoutingAvoidanceoptionsCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_AvoidanceOptions_create_handle_nullable'));
final _sdkRoutingAvoidanceoptionsReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_AvoidanceOptions_release_handle_nullable'));
final _sdkRoutingAvoidanceoptionsGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_AvoidanceOptions_get_value_nullable'));

Pointer<Void> sdkRoutingAvoidanceoptionsToFfiNullable(AvoidanceOptions? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkRoutingAvoidanceoptionsToFfi(value);
  final result = _sdkRoutingAvoidanceoptionsCreateHandleNullable(_handle);
  sdkRoutingAvoidanceoptionsReleaseFfiHandle(_handle);
  return result;
}

AvoidanceOptions? sdkRoutingAvoidanceoptionsFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkRoutingAvoidanceoptionsGetValueNullable(handle);
  final result = sdkRoutingAvoidanceoptionsFromFfi(_handle);
  sdkRoutingAvoidanceoptionsReleaseFfiHandle(_handle);
  return result;
}

void sdkRoutingAvoidanceoptionsReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkRoutingAvoidanceoptionsReleaseHandleNullable(handle);

// End of AvoidanceOptions "private" section.


