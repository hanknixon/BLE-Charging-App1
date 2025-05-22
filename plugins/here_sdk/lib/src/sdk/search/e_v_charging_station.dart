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

/// Group of connectors for electrical vehicles, defined by a common charging connector type and
/// max power level.
///
/// Use [PlaceCategory.businessAndServicesEvChargingStation] to find stations.
/// In the `Details` of a `Place` result you can find the list of found pools containing stations,
/// if any.
///
/// For offline EV rich attributes, also enable [LayerConfigurationFeature.ev]
/// in [SDKOptions.layerConfiguration].

class EVChargingStation {
  /// The EV charging station operator.
  /// This field is always `null` for offline search using the `OfflineSearchEngine`. For online search using the `SearchEngine`, it can be null if data is unavailable.
  String? supplierName;

  /// Name of the connector type.
  /// For more information on the current connector types, see
  /// https://www.here.com/docs/bundle/ev-charge-points-api-developer-guide/page/topics/resource-type-connector.html
  /// Can have customer names, in that case 'customer names' label is present.
  /// This field can be `null` if data is unavailable.
  String? connectorTypeName;

  /// ID of the connector type.
  /// For more information on the current connector types, see
  /// https://www.here.com/docs/bundle/ev-charge-points-api-developer-guide/page/topics/resource-type-connector.html
  /// This field is always `null` for offline search using the `OfflineSearchEngine`. For online search using the `SearchEngine`, it can be null if data is unavailable.
  String? connectorTypeId;

  /// Name of the power feed type with respect to
  /// https://en.wikipedia.org/wiki/SAE_J1772#Charging standard.
  /// Provides the customer information on the charge level of the specific Connector Type.
  /// Also, can describe level that is used in North America and Australia.
  /// In that case label 'North America (Australia)' is present.
  /// This field can be `null` if data is unavailable.
  String? powerFeedTypeName;

  /// ID of the power feed type with respect to
  /// https://en.wikipedia.org/wiki/SAE_J1772#Charging standard.
  /// No data in case of offline search.
  /// This field is always `null` for offline search using the `OfflineSearchEngine`. For online search using the `SearchEngine`, it can be null if data is unavailable.
  String? powerFeedTypeId;

  /// Maximum charge power of connectors in kW.
  /// This field can be `null` if data is unavailable.
  double? maxPowerInKilowatts;

  /// Number of physical connectors at the charging station.
  /// This field can be `null` if data is unavailable.
  int? connectorCount;

  /// Number of available physical connectors at the charging station.
  /// This field is always `null` for offline search using the `OfflineSearchEngine`. For online search using the `SearchEngine`, it can be null if data is unavailable.
  int? availableConnectorCount;

  /// Number of occupied physical connectors at the charging station.
  /// This field is always `null` for offline search using the `OfflineSearchEngine`. For online search using the `SearchEngine`, it can be null if data is unavailable.
  int? occupiedConnectorCount;

  /// Number of physical connectors that are out of service at the charging station.
  /// This field is always `null` for offline search using the `OfflineSearchEngine`. For online search using the `SearchEngine`, it can be null if data is unavailable.
  int? outOfServiceConnectorCount;

  /// Number of physical connectors that are reserved at the charging station.
  /// This field is always `null` for offline search using the `OfflineSearchEngine`. For online search using the `SearchEngine`, it can be null if data is unavailable.
  int? reservedConnectorCount;

  /// Last update of the `available_connector_count` and `occupied_connector_count` fields.
  /// This field is always `null` for offline search using the `OfflineSearchEngine`. For online search using the `SearchEngine`, it can be null if data is unavailable.
  DateTime? lastUpdated;

  /// Charging mode of the charging station. For more information, see
  /// https://en.wikipedia.org/w/index.php?title=Charging_station&oldid=1013010605#IEC-61851-1_Charging_Modes standard.
  /// This field can be `null` if data is unavailable.
  String? chargingMode;

  /// Voltage range of the charge provided by the charging station, in volts.
  /// Values are alpha numeric represented by the Volt value followed by 'V' and
  /// by the current type 'AC' or 'DC', for example: '100-120V AC'.
  /// This field can be `null` if data is unavailable.
  String? voltageRangeInVolts;

  /// Current range provided by the charging station, in amperes.
  /// Values are alpha numeric represented by the Ampere value followed by an 'A',
  /// for example '12A-80A'.
  /// This field can be `null` if data is unavailable.
  String? currentRangeInAmperes;

  /// Number of phases used by the charging station.
  /// This field can be `null` if data is unavailable.
  int? phaseCount;

  /// Indicates that the cable is fixed or not fixed for a specific
  /// Connector Type on the charge station.
  /// This field can be `null` if data is unavailable.
  bool? hasFixedCable;

  /// Creates a new instance.

  /// [supplierName] The EV charging station operator.
  /// This field is always `null` for offline search using the `OfflineSearchEngine`. For online search using the `SearchEngine`, it can be null if data is unavailable.

  /// [connectorTypeName] Name of the connector type.
  /// For more information on the current connector types, see
  /// https://www.here.com/docs/bundle/ev-charge-points-api-developer-guide/page/topics/resource-type-connector.html
  /// Can have customer names, in that case 'customer names' label is present.
  /// This field can be `null` if data is unavailable.

  /// [connectorTypeId] ID of the connector type.
  /// For more information on the current connector types, see
  /// https://www.here.com/docs/bundle/ev-charge-points-api-developer-guide/page/topics/resource-type-connector.html
  /// This field is always `null` for offline search using the `OfflineSearchEngine`. For online search using the `SearchEngine`, it can be null if data is unavailable.

  /// [powerFeedTypeName] Name of the power feed type with respect to
  /// https://en.wikipedia.org/wiki/SAE_J1772#Charging standard.
  /// Provides the customer information on the charge level of the specific Connector Type.
  /// Also, can describe level that is used in North America and Australia.
  /// In that case label 'North America (Australia)' is present.
  /// This field can be `null` if data is unavailable.

  /// [powerFeedTypeId] ID of the power feed type with respect to
  /// https://en.wikipedia.org/wiki/SAE_J1772#Charging standard.
  /// No data in case of offline search.
  /// This field is always `null` for offline search using the `OfflineSearchEngine`. For online search using the `SearchEngine`, it can be null if data is unavailable.

  /// [maxPowerInKilowatts] Maximum charge power of connectors in kW.
  /// This field can be `null` if data is unavailable.

  /// [connectorCount] Number of physical connectors at the charging station.
  /// This field can be `null` if data is unavailable.

  /// [availableConnectorCount] Number of available physical connectors at the charging station.
  /// This field is always `null` for offline search using the `OfflineSearchEngine`. For online search using the `SearchEngine`, it can be null if data is unavailable.

  /// [occupiedConnectorCount] Number of occupied physical connectors at the charging station.
  /// This field is always `null` for offline search using the `OfflineSearchEngine`. For online search using the `SearchEngine`, it can be null if data is unavailable.

  /// [outOfServiceConnectorCount] Number of physical connectors that are out of service at the charging station.
  /// This field is always `null` for offline search using the `OfflineSearchEngine`. For online search using the `SearchEngine`, it can be null if data is unavailable.

  /// [reservedConnectorCount] Number of physical connectors that are reserved at the charging station.
  /// This field is always `null` for offline search using the `OfflineSearchEngine`. For online search using the `SearchEngine`, it can be null if data is unavailable.

  /// [lastUpdated] Last update of the `available_connector_count` and `occupied_connector_count` fields.
  /// This field is always `null` for offline search using the `OfflineSearchEngine`. For online search using the `SearchEngine`, it can be null if data is unavailable.

  /// [chargingMode] Charging mode of the charging station. For more information, see
  /// https://en.wikipedia.org/w/index.php?title=Charging_station&oldid=1013010605#IEC-61851-1_Charging_Modes standard.
  /// This field can be `null` if data is unavailable.

  /// [voltageRangeInVolts] Voltage range of the charge provided by the charging station, in volts.
  /// Values are alpha numeric represented by the Volt value followed by 'V' and
  /// by the current type 'AC' or 'DC', for example: '100-120V AC'.
  /// This field can be `null` if data is unavailable.

  /// [currentRangeInAmperes] Current range provided by the charging station, in amperes.
  /// Values are alpha numeric represented by the Ampere value followed by an 'A',
  /// for example '12A-80A'.
  /// This field can be `null` if data is unavailable.

  /// [phaseCount] Number of phases used by the charging station.
  /// This field can be `null` if data is unavailable.

  /// [hasFixedCable] Indicates that the cable is fixed or not fixed for a specific
  /// Connector Type on the charge station.
  /// This field can be `null` if data is unavailable.

  EVChargingStation._(this.supplierName, this.connectorTypeName, this.connectorTypeId, this.powerFeedTypeName, this.powerFeedTypeId, this.maxPowerInKilowatts, this.connectorCount, this.availableConnectorCount, this.occupiedConnectorCount, this.outOfServiceConnectorCount, this.reservedConnectorCount, this.lastUpdated, this.chargingMode, this.voltageRangeInVolts, this.currentRangeInAmperes, this.phaseCount, this.hasFixedCable);
  /// Creates a new instance.
  /// [supplierName] The EV charging station operator.
  /// This field is always `null` for offline search using the `OfflineSearchEngine`. For online search using the `SearchEngine`, it can be null if data is unavailable.
  /// [connectorTypeName] Name of the connector type.
  /// For more information on the current connector types, see
  /// https://www.here.com/docs/bundle/ev-charge-points-api-developer-guide/page/topics/resource-type-connector.html
  /// Can have customer names, in that case 'customer names' label is present.
  /// This field can be `null` if data is unavailable.
  /// [connectorTypeId] ID of the connector type.
  /// For more information on the current connector types, see
  /// https://www.here.com/docs/bundle/ev-charge-points-api-developer-guide/page/topics/resource-type-connector.html
  /// This field is always `null` for offline search using the `OfflineSearchEngine`. For online search using the `SearchEngine`, it can be null if data is unavailable.
  /// [powerFeedTypeName] Name of the power feed type with respect to
  /// https://en.wikipedia.org/wiki/SAE_J1772#Charging standard.
  /// Provides the customer information on the charge level of the specific Connector Type.
  /// Also, can describe level that is used in North America and Australia.
  /// In that case label 'North America (Australia)' is present.
  /// This field can be `null` if data is unavailable.
  /// [powerFeedTypeId] ID of the power feed type with respect to
  /// https://en.wikipedia.org/wiki/SAE_J1772#Charging standard.
  /// No data in case of offline search.
  /// This field is always `null` for offline search using the `OfflineSearchEngine`. For online search using the `SearchEngine`, it can be null if data is unavailable.
  /// [maxPowerInKilowatts] Maximum charge power of connectors in kW.
  /// This field can be `null` if data is unavailable.
  /// [connectorCount] Number of physical connectors at the charging station.
  /// This field can be `null` if data is unavailable.
  /// [availableConnectorCount] Number of available physical connectors at the charging station.
  /// This field is always `null` for offline search using the `OfflineSearchEngine`. For online search using the `SearchEngine`, it can be null if data is unavailable.
  /// [chargingMode] Charging mode of the charging station. For more information, see
  /// https://en.wikipedia.org/w/index.php?title=Charging_station&oldid=1013010605#IEC-61851-1_Charging_Modes standard.
  /// This field can be `null` if data is unavailable.
  /// [voltageRangeInVolts] Voltage range of the charge provided by the charging station, in volts.
  /// Values are alpha numeric represented by the Volt value followed by 'V' and
  /// by the current type 'AC' or 'DC', for example: '100-120V AC'.
  /// This field can be `null` if data is unavailable.
  /// [currentRangeInAmperes] Current range provided by the charging station, in amperes.
  /// Values are alpha numeric represented by the Ampere value followed by an 'A',
  /// for example '12A-80A'.
  /// This field can be `null` if data is unavailable.
  /// [phaseCount] Number of phases used by the charging station.
  /// This field can be `null` if data is unavailable.
  @Deprecated("Will be removed in v4.23.0. Use the `withDefaults` instead.")
  EVChargingStation(this.supplierName, this.connectorTypeName, this.connectorTypeId, this.powerFeedTypeName, this.powerFeedTypeId, this.maxPowerInKilowatts, this.connectorCount, this.availableConnectorCount, this.chargingMode, this.voltageRangeInVolts, this.currentRangeInAmperes, this.phaseCount)
      : occupiedConnectorCount = null, outOfServiceConnectorCount = null, reservedConnectorCount = null, lastUpdated = null, hasFixedCable = null;
  /// Creates a new instance.
  EVChargingStation.withDefaults()
      : supplierName = null, connectorTypeName = null, connectorTypeId = null, powerFeedTypeName = null, powerFeedTypeId = null, maxPowerInKilowatts = null, connectorCount = null, availableConnectorCount = null, occupiedConnectorCount = null, outOfServiceConnectorCount = null, reservedConnectorCount = null, lastUpdated = null, chargingMode = null, voltageRangeInVolts = null, currentRangeInAmperes = null, phaseCount = null, hasFixedCable = null;
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EVChargingStation) return false;
    EVChargingStation _other = other;
    return supplierName == _other.supplierName &&
        connectorTypeName == _other.connectorTypeName &&
        connectorTypeId == _other.connectorTypeId &&
        powerFeedTypeName == _other.powerFeedTypeName &&
        powerFeedTypeId == _other.powerFeedTypeId &&
        maxPowerInKilowatts == _other.maxPowerInKilowatts &&
        connectorCount == _other.connectorCount &&
        availableConnectorCount == _other.availableConnectorCount &&
        occupiedConnectorCount == _other.occupiedConnectorCount &&
        outOfServiceConnectorCount == _other.outOfServiceConnectorCount &&
        reservedConnectorCount == _other.reservedConnectorCount &&
        lastUpdated == _other.lastUpdated &&
        chargingMode == _other.chargingMode &&
        voltageRangeInVolts == _other.voltageRangeInVolts &&
        currentRangeInAmperes == _other.currentRangeInAmperes &&
        phaseCount == _other.phaseCount &&
        hasFixedCable == _other.hasFixedCable;
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + supplierName.hashCode;
    result = 31 * result + connectorTypeName.hashCode;
    result = 31 * result + connectorTypeId.hashCode;
    result = 31 * result + powerFeedTypeName.hashCode;
    result = 31 * result + powerFeedTypeId.hashCode;
    result = 31 * result + maxPowerInKilowatts.hashCode;
    result = 31 * result + connectorCount.hashCode;
    result = 31 * result + availableConnectorCount.hashCode;
    result = 31 * result + occupiedConnectorCount.hashCode;
    result = 31 * result + outOfServiceConnectorCount.hashCode;
    result = 31 * result + reservedConnectorCount.hashCode;
    result = 31 * result + lastUpdated.hashCode;
    result = 31 * result + chargingMode.hashCode;
    result = 31 * result + voltageRangeInVolts.hashCode;
    result = 31 * result + currentRangeInAmperes.hashCode;
    result = 31 * result + phaseCount.hashCode;
    result = 31 * result + hasFixedCable.hashCode;
    return result;
  }
}


// EVChargingStation "private" section, not exported.

final _sdkSearchEvchargingstationCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>)
  >('here_sdk_sdk_search_EVChargingStation_create_handle'));
final _sdkSearchEvchargingstationReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_search_EVChargingStation_release_handle'));
final _sdkSearchEvchargingstationGetFieldsupplierName = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EVChargingStation_get_field_supplierName'));
final _sdkSearchEvchargingstationGetFieldconnectorTypeName = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EVChargingStation_get_field_connectorTypeName'));
final _sdkSearchEvchargingstationGetFieldconnectorTypeId = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EVChargingStation_get_field_connectorTypeId'));
final _sdkSearchEvchargingstationGetFieldpowerFeedTypeName = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EVChargingStation_get_field_powerFeedTypeName'));
final _sdkSearchEvchargingstationGetFieldpowerFeedTypeId = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EVChargingStation_get_field_powerFeedTypeId'));
final _sdkSearchEvchargingstationGetFieldmaxPowerInKilowatts = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EVChargingStation_get_field_maxPowerInKilowatts'));
final _sdkSearchEvchargingstationGetFieldconnectorCount = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EVChargingStation_get_field_connectorCount'));
final _sdkSearchEvchargingstationGetFieldavailableConnectorCount = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EVChargingStation_get_field_availableConnectorCount'));
final _sdkSearchEvchargingstationGetFieldoccupiedConnectorCount = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EVChargingStation_get_field_occupiedConnectorCount'));
final _sdkSearchEvchargingstationGetFieldoutOfServiceConnectorCount = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EVChargingStation_get_field_outOfServiceConnectorCount'));
final _sdkSearchEvchargingstationGetFieldreservedConnectorCount = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EVChargingStation_get_field_reservedConnectorCount'));
final _sdkSearchEvchargingstationGetFieldlastUpdated = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EVChargingStation_get_field_lastUpdated'));
final _sdkSearchEvchargingstationGetFieldchargingMode = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EVChargingStation_get_field_chargingMode'));
final _sdkSearchEvchargingstationGetFieldvoltageRangeInVolts = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EVChargingStation_get_field_voltageRangeInVolts'));
final _sdkSearchEvchargingstationGetFieldcurrentRangeInAmperes = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EVChargingStation_get_field_currentRangeInAmperes'));
final _sdkSearchEvchargingstationGetFieldphaseCount = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EVChargingStation_get_field_phaseCount'));
final _sdkSearchEvchargingstationGetFieldhasFixedCable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EVChargingStation_get_field_hasFixedCable'));



Pointer<Void> sdkSearchEvchargingstationToFfi(EVChargingStation value) {
  final _supplierNameHandle = stringToFfiNullable(value.supplierName);
  final _connectorTypeNameHandle = stringToFfiNullable(value.connectorTypeName);
  final _connectorTypeIdHandle = stringToFfiNullable(value.connectorTypeId);
  final _powerFeedTypeNameHandle = stringToFfiNullable(value.powerFeedTypeName);
  final _powerFeedTypeIdHandle = stringToFfiNullable(value.powerFeedTypeId);
  final _maxPowerInKilowattsHandle = doubleToFfiNullable(value.maxPowerInKilowatts);
  final _connectorCountHandle = intToFfiNullable(value.connectorCount);
  final _availableConnectorCountHandle = intToFfiNullable(value.availableConnectorCount);
  final _occupiedConnectorCountHandle = intToFfiNullable(value.occupiedConnectorCount);
  final _outOfServiceConnectorCountHandle = intToFfiNullable(value.outOfServiceConnectorCount);
  final _reservedConnectorCountHandle = intToFfiNullable(value.reservedConnectorCount);
  final _lastUpdatedHandle = dateToFfiNullable(value.lastUpdated);
  final _chargingModeHandle = stringToFfiNullable(value.chargingMode);
  final _voltageRangeInVoltsHandle = stringToFfiNullable(value.voltageRangeInVolts);
  final _currentRangeInAmperesHandle = stringToFfiNullable(value.currentRangeInAmperes);
  final _phaseCountHandle = intToFfiNullable(value.phaseCount);
  final _hasFixedCableHandle = booleanToFfiNullable(value.hasFixedCable);
  final _result = _sdkSearchEvchargingstationCreateHandle(_supplierNameHandle, _connectorTypeNameHandle, _connectorTypeIdHandle, _powerFeedTypeNameHandle, _powerFeedTypeIdHandle, _maxPowerInKilowattsHandle, _connectorCountHandle, _availableConnectorCountHandle, _occupiedConnectorCountHandle, _outOfServiceConnectorCountHandle, _reservedConnectorCountHandle, _lastUpdatedHandle, _chargingModeHandle, _voltageRangeInVoltsHandle, _currentRangeInAmperesHandle, _phaseCountHandle, _hasFixedCableHandle);
  stringReleaseFfiHandleNullable(_supplierNameHandle);
  stringReleaseFfiHandleNullable(_connectorTypeNameHandle);
  stringReleaseFfiHandleNullable(_connectorTypeIdHandle);
  stringReleaseFfiHandleNullable(_powerFeedTypeNameHandle);
  stringReleaseFfiHandleNullable(_powerFeedTypeIdHandle);
  doubleReleaseFfiHandleNullable(_maxPowerInKilowattsHandle);
  intReleaseFfiHandleNullable(_connectorCountHandle);
  intReleaseFfiHandleNullable(_availableConnectorCountHandle);
  intReleaseFfiHandleNullable(_occupiedConnectorCountHandle);
  intReleaseFfiHandleNullable(_outOfServiceConnectorCountHandle);
  intReleaseFfiHandleNullable(_reservedConnectorCountHandle);
  dateReleaseFfiHandleNullable(_lastUpdatedHandle);
  stringReleaseFfiHandleNullable(_chargingModeHandle);
  stringReleaseFfiHandleNullable(_voltageRangeInVoltsHandle);
  stringReleaseFfiHandleNullable(_currentRangeInAmperesHandle);
  intReleaseFfiHandleNullable(_phaseCountHandle);
  booleanReleaseFfiHandleNullable(_hasFixedCableHandle);
  return _result;
}

EVChargingStation sdkSearchEvchargingstationFromFfi(Pointer<Void> handle) {
  final _supplierNameHandle = _sdkSearchEvchargingstationGetFieldsupplierName(handle);
  final _connectorTypeNameHandle = _sdkSearchEvchargingstationGetFieldconnectorTypeName(handle);
  final _connectorTypeIdHandle = _sdkSearchEvchargingstationGetFieldconnectorTypeId(handle);
  final _powerFeedTypeNameHandle = _sdkSearchEvchargingstationGetFieldpowerFeedTypeName(handle);
  final _powerFeedTypeIdHandle = _sdkSearchEvchargingstationGetFieldpowerFeedTypeId(handle);
  final _maxPowerInKilowattsHandle = _sdkSearchEvchargingstationGetFieldmaxPowerInKilowatts(handle);
  final _connectorCountHandle = _sdkSearchEvchargingstationGetFieldconnectorCount(handle);
  final _availableConnectorCountHandle = _sdkSearchEvchargingstationGetFieldavailableConnectorCount(handle);
  final _occupiedConnectorCountHandle = _sdkSearchEvchargingstationGetFieldoccupiedConnectorCount(handle);
  final _outOfServiceConnectorCountHandle = _sdkSearchEvchargingstationGetFieldoutOfServiceConnectorCount(handle);
  final _reservedConnectorCountHandle = _sdkSearchEvchargingstationGetFieldreservedConnectorCount(handle);
  final _lastUpdatedHandle = _sdkSearchEvchargingstationGetFieldlastUpdated(handle);
  final _chargingModeHandle = _sdkSearchEvchargingstationGetFieldchargingMode(handle);
  final _voltageRangeInVoltsHandle = _sdkSearchEvchargingstationGetFieldvoltageRangeInVolts(handle);
  final _currentRangeInAmperesHandle = _sdkSearchEvchargingstationGetFieldcurrentRangeInAmperes(handle);
  final _phaseCountHandle = _sdkSearchEvchargingstationGetFieldphaseCount(handle);
  final _hasFixedCableHandle = _sdkSearchEvchargingstationGetFieldhasFixedCable(handle);
  try {
    return EVChargingStation._(
      stringFromFfiNullable(_supplierNameHandle), 
      stringFromFfiNullable(_connectorTypeNameHandle), 
      stringFromFfiNullable(_connectorTypeIdHandle), 
      stringFromFfiNullable(_powerFeedTypeNameHandle), 
      stringFromFfiNullable(_powerFeedTypeIdHandle), 
      doubleFromFfiNullable(_maxPowerInKilowattsHandle), 
      intFromFfiNullable(_connectorCountHandle), 
      intFromFfiNullable(_availableConnectorCountHandle), 
      intFromFfiNullable(_occupiedConnectorCountHandle), 
      intFromFfiNullable(_outOfServiceConnectorCountHandle), 
      intFromFfiNullable(_reservedConnectorCountHandle), 
      dateFromFfiNullable(_lastUpdatedHandle), 
      stringFromFfiNullable(_chargingModeHandle), 
      stringFromFfiNullable(_voltageRangeInVoltsHandle), 
      stringFromFfiNullable(_currentRangeInAmperesHandle), 
      intFromFfiNullable(_phaseCountHandle), 
      booleanFromFfiNullable(_hasFixedCableHandle)
    );
  } finally {
    stringReleaseFfiHandleNullable(_supplierNameHandle);
    stringReleaseFfiHandleNullable(_connectorTypeNameHandle);
    stringReleaseFfiHandleNullable(_connectorTypeIdHandle);
    stringReleaseFfiHandleNullable(_powerFeedTypeNameHandle);
    stringReleaseFfiHandleNullable(_powerFeedTypeIdHandle);
    doubleReleaseFfiHandleNullable(_maxPowerInKilowattsHandle);
    intReleaseFfiHandleNullable(_connectorCountHandle);
    intReleaseFfiHandleNullable(_availableConnectorCountHandle);
    intReleaseFfiHandleNullable(_occupiedConnectorCountHandle);
    intReleaseFfiHandleNullable(_outOfServiceConnectorCountHandle);
    intReleaseFfiHandleNullable(_reservedConnectorCountHandle);
    dateReleaseFfiHandleNullable(_lastUpdatedHandle);
    stringReleaseFfiHandleNullable(_chargingModeHandle);
    stringReleaseFfiHandleNullable(_voltageRangeInVoltsHandle);
    stringReleaseFfiHandleNullable(_currentRangeInAmperesHandle);
    intReleaseFfiHandleNullable(_phaseCountHandle);
    booleanReleaseFfiHandleNullable(_hasFixedCableHandle);
  }
}

void sdkSearchEvchargingstationReleaseFfiHandle(Pointer<Void> handle) => _sdkSearchEvchargingstationReleaseHandle(handle);

// Nullable EVChargingStation

final _sdkSearchEvchargingstationCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EVChargingStation_create_handle_nullable'));
final _sdkSearchEvchargingstationReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_search_EVChargingStation_release_handle_nullable'));
final _sdkSearchEvchargingstationGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_EVChargingStation_get_value_nullable'));

Pointer<Void> sdkSearchEvchargingstationToFfiNullable(EVChargingStation? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkSearchEvchargingstationToFfi(value);
  final result = _sdkSearchEvchargingstationCreateHandleNullable(_handle);
  sdkSearchEvchargingstationReleaseFfiHandle(_handle);
  return result;
}

EVChargingStation? sdkSearchEvchargingstationFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkSearchEvchargingstationGetValueNullable(handle);
  final result = sdkSearchEvchargingstationFromFfi(_handle);
  sdkSearchEvchargingstationReleaseFfiHandle(_handle);
  return result;
}

void sdkSearchEvchargingstationReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkSearchEvchargingstationReleaseHandleNullable(handle);

// End of EVChargingStation "private" section.


