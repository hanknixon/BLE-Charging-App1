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
import 'package:here_sdk/src/sdk/core/current_type.dart';
import 'package:here_sdk/src/sdk/transport/fuel_type.dart';
import 'package:here_sdk/src/sdk/transport/truck_class.dart';
import 'package:here_sdk/src/sdk/transport/truck_fuel_type.dart';

/// The filter options to specify a place.
///
/// Consists of fuel, truck and EV options.

class PlaceFilter {
  /// The list of [FuelType] elements that should be used to find only
  /// the [FuelStation] search results that support all of them.
  /// This filter is available to use with the `SearchEngine` and
  /// `OfflineSearchEngine` (not available for all editions), however `OfflineSearchEngine`
  /// supports it only for `searchByText` and `searchByCategory` with allowed fuel types `DIESEL`, `LPG`,
  /// `BIO_DIESEL`, `CNG`, `DIESEL_WITH_ADDITIVES`, `E10`, `E85`, `ETHANOL`, `ETHANOL_WITH_ADDITIVES`,
  /// `GASOLINE`, `HYDROGEN`, `LNG`, `MIDGRADE`, `PREMIUM` and `REGULAR`.
  ///
  /// **Note:** This is a beta release of this feature, so there could be a few bugs and unexpected behaviors.
  /// Related APIs may change for new releases without a deprecation process.
  List<FuelType> fuelTypes;

  /// The list of [TruckFuelType] elements that should be used to find only
  /// the [FuelStation] search results that support all of them.
  /// Not supported for `suggestByText` in `OfflineSearchEngine` (not available in all editions).
  ///
  /// **Note:** This is a beta release of this feature, so there could be a few bugs and unexpected behaviors.
  /// Related APIs may change for new releases without a deprecation process.
  List<TruckFuelType> truckFuelTypes;

  /// Should be used to find only the [FuelStation] search results with minimum supported [TruckClass].
  /// This filter is only available to use with the `SearchEngine`.
  /// The `OfflineSearchEngine` (not available for all editions) does not apply this filter.
  /// [TruckClass.lightClass] is not accepted in the filter.
  /// Otherwise will result in [SearchError.invalidTruckClass].
  ///
  /// **Note:** This is a beta release of this feature, so there could be a few bugs and unexpected behaviors.
  /// Related APIs may change for new releases without a deprecation process.
  TruckClass? truckClass;

  /// Constraints that are applicable on the places of category EV station.
  PlaceFilterEv ev;

  /// Creates a new instance.

  /// [fuelTypes] The list of [FuelType] elements that should be used to find only
  /// the [FuelStation] search results that support all of them.
  /// This filter is available to use with the `SearchEngine` and
  /// `OfflineSearchEngine` (not available for all editions), however `OfflineSearchEngine`
  /// supports it only for `searchByText` and `searchByCategory` with allowed fuel types `DIESEL`, `LPG`,
  /// `BIO_DIESEL`, `CNG`, `DIESEL_WITH_ADDITIVES`, `E10`, `E85`, `ETHANOL`, `ETHANOL_WITH_ADDITIVES`,
  /// `GASOLINE`, `HYDROGEN`, `LNG`, `MIDGRADE`, `PREMIUM` and `REGULAR`.
  ///
  /// **Note:** This is a beta release of this feature, so there could be a few bugs and unexpected behaviors.
  /// Related APIs may change for new releases without a deprecation process.

  /// [truckFuelTypes] The list of [TruckFuelType] elements that should be used to find only
  /// the [FuelStation] search results that support all of them.
  /// Not supported for `suggestByText` in `OfflineSearchEngine` (not available in all editions).
  ///
  /// **Note:** This is a beta release of this feature, so there could be a few bugs and unexpected behaviors.
  /// Related APIs may change for new releases without a deprecation process.

  /// [truckClass] Should be used to find only the [FuelStation] search results with minimum supported [TruckClass].
  /// This filter is only available to use with the `SearchEngine`.
  /// The `OfflineSearchEngine` (not available for all editions) does not apply this filter.
  /// [TruckClass.lightClass] is not accepted in the filter.
  /// Otherwise will result in [SearchError.invalidTruckClass].
  ///
  /// **Note:** This is a beta release of this feature, so there could be a few bugs and unexpected behaviors.
  /// Related APIs may change for new releases without a deprecation process.

  /// [ev] Constraints that are applicable on the places of category EV station.

  PlaceFilter._(this.fuelTypes, this.truckFuelTypes, this.truckClass, this.ev);
  PlaceFilter()
    : fuelTypes = [], truckFuelTypes = [], truckClass = null, ev = PlaceFilterEv();
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PlaceFilter) return false;
    PlaceFilter _other = other;
    return DeepCollectionEquality().equals(fuelTypes, _other.fuelTypes) &&
        DeepCollectionEquality().equals(truckFuelTypes, _other.truckFuelTypes) &&
        truckClass == _other.truckClass &&
        ev == _other.ev;
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + DeepCollectionEquality().hash(fuelTypes);
    result = 31 * result + DeepCollectionEquality().hash(truckFuelTypes);
    result = 31 * result + truckClass.hashCode;
    result = 31 * result + ev.hashCode;
    return result;
  }
}

/// Constraints that are applicable on the places of category EV station.

class PlaceFilterEv {
  /// Sets a constraint on the charge point operator name of the EV station.
  ///
  /// Not supported in `OfflineSearchEngine` (not available in all editions).
  List<String> supplierNames;

  /// Filter to retrieve EV charging stations with at least one of the connector type IDs.
  /// For more information on the current connector types, see
  /// https://www.here.com/docs/bundle/ev-charge-points-api-developer-guide/page/topics/resource-type-connector.html
  ///
  /// Not supported in `OfflineSearchEngine` (not available in all editions).
  List<String> connectorTypeIDs;

  /// Filter to retrieve EV charging stations with the given minimum charging power in KW
  /// delivered by at least one of the station EVSE.
  /// Not supported for `suggestByText` in `OfflineSearchEngine` (not available in all editions).
  double? minPowerInKilowatts;

  /// Filter to retrieve EV charging stations with at least one matching e-Mobility Service Provider Partner ID.
  ///
  /// Not supported in `OfflineSearchEngine` (not available in all editions).
  List<String> eMobilityServiceProviderPartnerIDs;

  /// Filter to retrieve EV charging stations with the given current type
  /// provided at one of the station EVSE. Accepted is either AC or DC.
  /// Not supported for `suggestByText` in `OfflineSearchEngine` (not available in all editions).
  CurrentType? currentType;

  /// Creates a new instance.

  /// [supplierNames] Sets a constraint on the charge point operator name of the EV station.
  ///
  /// Not supported in `OfflineSearchEngine` (not available in all editions).

  /// [connectorTypeIDs] Filter to retrieve EV charging stations with at least one of the connector type IDs.
  /// For more information on the current connector types, see
  /// https://www.here.com/docs/bundle/ev-charge-points-api-developer-guide/page/topics/resource-type-connector.html
  ///
  /// Not supported in `OfflineSearchEngine` (not available in all editions).

  /// [minPowerInKilowatts] Filter to retrieve EV charging stations with the given minimum charging power in KW
  /// delivered by at least one of the station EVSE.
  /// Not supported for `suggestByText` in `OfflineSearchEngine` (not available in all editions).

  /// [eMobilityServiceProviderPartnerIDs] Filter to retrieve EV charging stations with at least one matching e-Mobility Service Provider Partner ID.
  ///
  /// Not supported in `OfflineSearchEngine` (not available in all editions).

  /// [currentType] Filter to retrieve EV charging stations with the given current type
  /// provided at one of the station EVSE. Accepted is either AC or DC.
  /// Not supported for `suggestByText` in `OfflineSearchEngine` (not available in all editions).

  PlaceFilterEv._(this.supplierNames, this.connectorTypeIDs, this.minPowerInKilowatts, this.eMobilityServiceProviderPartnerIDs, this.currentType);
  PlaceFilterEv()
    : supplierNames = [], connectorTypeIDs = [], minPowerInKilowatts = null, eMobilityServiceProviderPartnerIDs = [], currentType = null;
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PlaceFilterEv) return false;
    PlaceFilterEv _other = other;
    return DeepCollectionEquality().equals(supplierNames, _other.supplierNames) &&
        DeepCollectionEquality().equals(connectorTypeIDs, _other.connectorTypeIDs) &&
        minPowerInKilowatts == _other.minPowerInKilowatts &&
        DeepCollectionEquality().equals(eMobilityServiceProviderPartnerIDs, _other.eMobilityServiceProviderPartnerIDs) &&
        currentType == _other.currentType;
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + DeepCollectionEquality().hash(supplierNames);
    result = 31 * result + DeepCollectionEquality().hash(connectorTypeIDs);
    result = 31 * result + minPowerInKilowatts.hashCode;
    result = 31 * result + DeepCollectionEquality().hash(eMobilityServiceProviderPartnerIDs);
    result = 31 * result + currentType.hashCode;
    return result;
  }
}


// PlaceFilterEv "private" section, not exported.

final _sdkSearchPlacefilterEvCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>)
  >('here_sdk_sdk_search_PlaceFilter_Ev_create_handle'));
final _sdkSearchPlacefilterEvReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_search_PlaceFilter_Ev_release_handle'));
final _sdkSearchPlacefilterEvGetFieldsupplierNames = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_PlaceFilter_Ev_get_field_supplierNames'));
final _sdkSearchPlacefilterEvGetFieldconnectorTypeIDs = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_PlaceFilter_Ev_get_field_connectorTypeIDs'));
final _sdkSearchPlacefilterEvGetFieldminPowerInKilowatts = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_PlaceFilter_Ev_get_field_minPowerInKilowatts'));
final _sdkSearchPlacefilterEvGetFieldeMobilityServiceProviderPartnerIDs = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_PlaceFilter_Ev_get_field_eMobilityServiceProviderPartnerIDs'));
final _sdkSearchPlacefilterEvGetFieldcurrentType = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_PlaceFilter_Ev_get_field_currentType'));



Pointer<Void> sdkSearchPlacefilterEvToFfi(PlaceFilterEv value) {
  final _supplierNamesHandle = heresdkSearchCommonBindingslistofStringToFfi(value.supplierNames);
  final _connectorTypeIDsHandle = heresdkSearchCommonBindingslistofStringToFfi(value.connectorTypeIDs);
  final _minPowerInKilowattsHandle = doubleToFfiNullable(value.minPowerInKilowatts);
  final _eMobilityServiceProviderPartnerIDsHandle = heresdkSearchCommonBindingslistofStringToFfi(value.eMobilityServiceProviderPartnerIDs);
  final _currentTypeHandle = sdkCoreCurrenttypeToFfiNullable(value.currentType);
  final _result = _sdkSearchPlacefilterEvCreateHandle(_supplierNamesHandle, _connectorTypeIDsHandle, _minPowerInKilowattsHandle, _eMobilityServiceProviderPartnerIDsHandle, _currentTypeHandle);
  heresdkSearchCommonBindingslistofStringReleaseFfiHandle(_supplierNamesHandle);
  heresdkSearchCommonBindingslistofStringReleaseFfiHandle(_connectorTypeIDsHandle);
  doubleReleaseFfiHandleNullable(_minPowerInKilowattsHandle);
  heresdkSearchCommonBindingslistofStringReleaseFfiHandle(_eMobilityServiceProviderPartnerIDsHandle);
  sdkCoreCurrenttypeReleaseFfiHandleNullable(_currentTypeHandle);
  return _result;
}

PlaceFilterEv sdkSearchPlacefilterEvFromFfi(Pointer<Void> handle) {
  final _supplierNamesHandle = _sdkSearchPlacefilterEvGetFieldsupplierNames(handle);
  final _connectorTypeIDsHandle = _sdkSearchPlacefilterEvGetFieldconnectorTypeIDs(handle);
  final _minPowerInKilowattsHandle = _sdkSearchPlacefilterEvGetFieldminPowerInKilowatts(handle);
  final _eMobilityServiceProviderPartnerIDsHandle = _sdkSearchPlacefilterEvGetFieldeMobilityServiceProviderPartnerIDs(handle);
  final _currentTypeHandle = _sdkSearchPlacefilterEvGetFieldcurrentType(handle);
  try {
    return PlaceFilterEv._(
      heresdkSearchCommonBindingslistofStringFromFfi(_supplierNamesHandle), 
      heresdkSearchCommonBindingslistofStringFromFfi(_connectorTypeIDsHandle), 
      doubleFromFfiNullable(_minPowerInKilowattsHandle), 
      heresdkSearchCommonBindingslistofStringFromFfi(_eMobilityServiceProviderPartnerIDsHandle), 
      sdkCoreCurrenttypeFromFfiNullable(_currentTypeHandle)
    );
  } finally {
    heresdkSearchCommonBindingslistofStringReleaseFfiHandle(_supplierNamesHandle);
    heresdkSearchCommonBindingslistofStringReleaseFfiHandle(_connectorTypeIDsHandle);
    doubleReleaseFfiHandleNullable(_minPowerInKilowattsHandle);
    heresdkSearchCommonBindingslistofStringReleaseFfiHandle(_eMobilityServiceProviderPartnerIDsHandle);
    sdkCoreCurrenttypeReleaseFfiHandleNullable(_currentTypeHandle);
  }
}

void sdkSearchPlacefilterEvReleaseFfiHandle(Pointer<Void> handle) => _sdkSearchPlacefilterEvReleaseHandle(handle);

// Nullable PlaceFilterEv

final _sdkSearchPlacefilterEvCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_PlaceFilter_Ev_create_handle_nullable'));
final _sdkSearchPlacefilterEvReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_search_PlaceFilter_Ev_release_handle_nullable'));
final _sdkSearchPlacefilterEvGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_PlaceFilter_Ev_get_value_nullable'));

Pointer<Void> sdkSearchPlacefilterEvToFfiNullable(PlaceFilterEv? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkSearchPlacefilterEvToFfi(value);
  final result = _sdkSearchPlacefilterEvCreateHandleNullable(_handle);
  sdkSearchPlacefilterEvReleaseFfiHandle(_handle);
  return result;
}

PlaceFilterEv? sdkSearchPlacefilterEvFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkSearchPlacefilterEvGetValueNullable(handle);
  final result = sdkSearchPlacefilterEvFromFfi(_handle);
  sdkSearchPlacefilterEvReleaseFfiHandle(_handle);
  return result;
}

void sdkSearchPlacefilterEvReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkSearchPlacefilterEvReleaseHandleNullable(handle);

// End of PlaceFilterEv "private" section.

// PlaceFilter "private" section, not exported.

final _sdkSearchPlacefilterCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>)
  >('here_sdk_sdk_search_PlaceFilter_create_handle'));
final _sdkSearchPlacefilterReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_search_PlaceFilter_release_handle'));
final _sdkSearchPlacefilterGetFieldfuelTypes = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_PlaceFilter_get_field_fuelTypes'));
final _sdkSearchPlacefilterGetFieldtruckFuelTypes = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_PlaceFilter_get_field_truckFuelTypes'));
final _sdkSearchPlacefilterGetFieldtruckClass = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_PlaceFilter_get_field_truckClass'));
final _sdkSearchPlacefilterGetFieldev = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_PlaceFilter_get_field_ev'));



Pointer<Void> sdkSearchPlacefilterToFfi(PlaceFilter value) {
  final _fuelTypesHandle = heresdkSearchCommonBindingslistofSdkTransportFueltypeToFfi(value.fuelTypes);
  final _truckFuelTypesHandle = heresdkSearchCommonBindingslistofSdkTransportTruckfueltypeToFfi(value.truckFuelTypes);
  final _truckClassHandle = sdkTransportTruckclassToFfiNullable(value.truckClass);
  final _evHandle = sdkSearchPlacefilterEvToFfi(value.ev);
  final _result = _sdkSearchPlacefilterCreateHandle(_fuelTypesHandle, _truckFuelTypesHandle, _truckClassHandle, _evHandle);
  heresdkSearchCommonBindingslistofSdkTransportFueltypeReleaseFfiHandle(_fuelTypesHandle);
  heresdkSearchCommonBindingslistofSdkTransportTruckfueltypeReleaseFfiHandle(_truckFuelTypesHandle);
  sdkTransportTruckclassReleaseFfiHandleNullable(_truckClassHandle);
  sdkSearchPlacefilterEvReleaseFfiHandle(_evHandle);
  return _result;
}

PlaceFilter sdkSearchPlacefilterFromFfi(Pointer<Void> handle) {
  final _fuelTypesHandle = _sdkSearchPlacefilterGetFieldfuelTypes(handle);
  final _truckFuelTypesHandle = _sdkSearchPlacefilterGetFieldtruckFuelTypes(handle);
  final _truckClassHandle = _sdkSearchPlacefilterGetFieldtruckClass(handle);
  final _evHandle = _sdkSearchPlacefilterGetFieldev(handle);
  try {
    return PlaceFilter._(
      heresdkSearchCommonBindingslistofSdkTransportFueltypeFromFfi(_fuelTypesHandle), 
      heresdkSearchCommonBindingslistofSdkTransportTruckfueltypeFromFfi(_truckFuelTypesHandle), 
      sdkTransportTruckclassFromFfiNullable(_truckClassHandle), 
      sdkSearchPlacefilterEvFromFfi(_evHandle)
    );
  } finally {
    heresdkSearchCommonBindingslistofSdkTransportFueltypeReleaseFfiHandle(_fuelTypesHandle);
    heresdkSearchCommonBindingslistofSdkTransportTruckfueltypeReleaseFfiHandle(_truckFuelTypesHandle);
    sdkTransportTruckclassReleaseFfiHandleNullable(_truckClassHandle);
    sdkSearchPlacefilterEvReleaseFfiHandle(_evHandle);
  }
}

void sdkSearchPlacefilterReleaseFfiHandle(Pointer<Void> handle) => _sdkSearchPlacefilterReleaseHandle(handle);

// Nullable PlaceFilter

final _sdkSearchPlacefilterCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_PlaceFilter_create_handle_nullable'));
final _sdkSearchPlacefilterReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_search_PlaceFilter_release_handle_nullable'));
final _sdkSearchPlacefilterGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_PlaceFilter_get_value_nullable'));

Pointer<Void> sdkSearchPlacefilterToFfiNullable(PlaceFilter? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkSearchPlacefilterToFfi(value);
  final result = _sdkSearchPlacefilterCreateHandleNullable(_handle);
  sdkSearchPlacefilterReleaseFfiHandle(_handle);
  return result;
}

PlaceFilter? sdkSearchPlacefilterFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkSearchPlacefilterGetValueNullable(handle);
  final result = sdkSearchPlacefilterFromFfi(_handle);
  sdkSearchPlacefilterReleaseFfiHandle(_handle);
  return result;
}

void sdkSearchPlacefilterReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkSearchPlacefilterReleaseHandleNullable(handle);

// End of PlaceFilter "private" section.


