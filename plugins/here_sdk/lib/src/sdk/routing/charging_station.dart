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
import 'package:here_sdk/src/sdk/core/name_i_d.dart';
import 'package:here_sdk/src/sdk/routing/charging_connector_attributes.dart';

/// Data for an electric vehicle charging station.

class ChargingStation {
  /// Identifier of this charging station. It can only be null when custom charging
  /// stations from non-HERE datasets have been injected on the HERE platform.
  /// By default, with HERE datasets it is guranteed to be not null.
  String? id;

  /// Human readable name of this charging station. It can be null when there is no
  /// name associated with the station.
  String? name;

  /// Details of the connector suggested to be used.
  ChargingConnectorAttributes? connectorAttributes;

  /// Charging station brand.
  /// [NameID.name] reflect to charging station brand name.
  /// [NameID.id] reflect to charging station brand unique ID.
  NameID? brand;

  /// Charging station charge-point-operator.
  /// [NameID.name] reflect to charge-point-operator name.
  /// [NameID.id] reflect to charge-point-operator ID.
  NameID? chargePointOperator;

  /// List of matched E-Mobility Service Providers.
  /// Populated only when [EVCarOptions.evMobilityServiceProviderPreferences] was set.
  /// This list reflects the subset of E-Mobility Service Providers supported by the charging station,
  /// from the list specified in the request parameter [EVCarOptions.evMobilityServiceProviderPreferences].
  /// [NameID.name] in each list item reflect to E-Mobility Service Provider name.
  /// [NameID.id] in each list item reflect to E-Mobility Service Provider id.
  List<NameID> matchingEMobilityServiceProviders;

  /// Creates a new instance.
  /// [id] Identifier of this charging station. It can only be null when custom charging
  /// stations from non-HERE datasets have been injected on the HERE platform.
  /// By default, with HERE datasets it is guranteed to be not null.
  /// [name] Human readable name of this charging station. It can be null when there is no
  /// name associated with the station.
  /// [connectorAttributes] Details of the connector suggested to be used.
  ChargingStation(this.id, this.name, this.connectorAttributes)
      : brand = null, chargePointOperator = null, matchingEMobilityServiceProviders = [];
  /// Creates a new instance.
  /// [id] Identifier of this charging station. It can only be null when custom charging
  /// stations from non-HERE datasets have been injected on the HERE platform.
  /// By default, with HERE datasets it is guranteed to be not null.
  /// [name] Human readable name of this charging station. It can be null when there is no
  /// name associated with the station.
  /// [connectorAttributes] Details of the connector suggested to be used.
  /// [brand] Charging station brand.
  /// [NameID.name] reflect to charging station brand name.
  /// [NameID.id] reflect to charging station brand unique ID.
  /// [chargePointOperator] Charging station charge-point-operator.
  /// [NameID.name] reflect to charge-point-operator name.
  /// [NameID.id] reflect to charge-point-operator ID.
  /// [matchingEMobilityServiceProviders] List of matched E-Mobility Service Providers.
  /// Populated only when [EVCarOptions.evMobilityServiceProviderPreferences] was set.
  /// This list reflects the subset of E-Mobility Service Providers supported by the charging station,
  /// from the list specified in the request parameter [EVCarOptions.evMobilityServiceProviderPreferences].
  /// [NameID.name] in each list item reflect to E-Mobility Service Provider name.
  /// [NameID.id] in each list item reflect to E-Mobility Service Provider id.
  ChargingStation.withDetails(this.id, this.name, this.connectorAttributes, this.brand, this.chargePointOperator, this.matchingEMobilityServiceProviders);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChargingStation) return false;
    ChargingStation _other = other;
    return id == _other.id &&
        name == _other.name &&
        connectorAttributes == _other.connectorAttributes &&
        brand == _other.brand &&
        chargePointOperator == _other.chargePointOperator &&
        DeepCollectionEquality().equals(matchingEMobilityServiceProviders, _other.matchingEMobilityServiceProviders);
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + id.hashCode;
    result = 31 * result + name.hashCode;
    result = 31 * result + connectorAttributes.hashCode;
    result = 31 * result + brand.hashCode;
    result = 31 * result + chargePointOperator.hashCode;
    result = 31 * result + DeepCollectionEquality().hash(matchingEMobilityServiceProviders);
    return result;
  }
}


// ChargingStation "private" section, not exported.

final _sdkRoutingChargingstationCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>, Pointer<Void>)
  >('here_sdk_sdk_routing_ChargingStation_create_handle'));
final _sdkRoutingChargingstationReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_ChargingStation_release_handle'));
final _sdkRoutingChargingstationGetFieldid = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_ChargingStation_get_field_id'));
final _sdkRoutingChargingstationGetFieldname = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_ChargingStation_get_field_name'));
final _sdkRoutingChargingstationGetFieldconnectorAttributes = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_ChargingStation_get_field_connectorAttributes'));
final _sdkRoutingChargingstationGetFieldbrand = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_ChargingStation_get_field_brand'));
final _sdkRoutingChargingstationGetFieldchargePointOperator = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_ChargingStation_get_field_chargePointOperator'));
final _sdkRoutingChargingstationGetFieldmatchingEMobilityServiceProviders = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_ChargingStation_get_field_matchingEMobilityServiceProviders'));



Pointer<Void> sdkRoutingChargingstationToFfi(ChargingStation value) {
  final _idHandle = stringToFfiNullable(value.id);
  final _nameHandle = stringToFfiNullable(value.name);
  final _connectorAttributesHandle = sdkRoutingChargingconnectorattributesToFfiNullable(value.connectorAttributes);
  final _brandHandle = sdkCoreNameidToFfiNullable(value.brand);
  final _chargePointOperatorHandle = sdkCoreNameidToFfiNullable(value.chargePointOperator);
  final _matchingEMobilityServiceProvidersHandle = heresdkRoutingCommonBindingslistofSdkCoreNameidToFfi(value.matchingEMobilityServiceProviders);
  final _result = _sdkRoutingChargingstationCreateHandle(_idHandle, _nameHandle, _connectorAttributesHandle, _brandHandle, _chargePointOperatorHandle, _matchingEMobilityServiceProvidersHandle);
  stringReleaseFfiHandleNullable(_idHandle);
  stringReleaseFfiHandleNullable(_nameHandle);
  sdkRoutingChargingconnectorattributesReleaseFfiHandleNullable(_connectorAttributesHandle);
  sdkCoreNameidReleaseFfiHandleNullable(_brandHandle);
  sdkCoreNameidReleaseFfiHandleNullable(_chargePointOperatorHandle);
  heresdkRoutingCommonBindingslistofSdkCoreNameidReleaseFfiHandle(_matchingEMobilityServiceProvidersHandle);
  return _result;
}

ChargingStation sdkRoutingChargingstationFromFfi(Pointer<Void> handle) {
  final _idHandle = _sdkRoutingChargingstationGetFieldid(handle);
  final _nameHandle = _sdkRoutingChargingstationGetFieldname(handle);
  final _connectorAttributesHandle = _sdkRoutingChargingstationGetFieldconnectorAttributes(handle);
  final _brandHandle = _sdkRoutingChargingstationGetFieldbrand(handle);
  final _chargePointOperatorHandle = _sdkRoutingChargingstationGetFieldchargePointOperator(handle);
  final _matchingEMobilityServiceProvidersHandle = _sdkRoutingChargingstationGetFieldmatchingEMobilityServiceProviders(handle);
  try {
    return ChargingStation.withDetails(
      stringFromFfiNullable(_idHandle), 
      stringFromFfiNullable(_nameHandle), 
      sdkRoutingChargingconnectorattributesFromFfiNullable(_connectorAttributesHandle), 
      sdkCoreNameidFromFfiNullable(_brandHandle), 
      sdkCoreNameidFromFfiNullable(_chargePointOperatorHandle), 
      heresdkRoutingCommonBindingslistofSdkCoreNameidFromFfi(_matchingEMobilityServiceProvidersHandle)
    );
  } finally {
    stringReleaseFfiHandleNullable(_idHandle);
    stringReleaseFfiHandleNullable(_nameHandle);
    sdkRoutingChargingconnectorattributesReleaseFfiHandleNullable(_connectorAttributesHandle);
    sdkCoreNameidReleaseFfiHandleNullable(_brandHandle);
    sdkCoreNameidReleaseFfiHandleNullable(_chargePointOperatorHandle);
    heresdkRoutingCommonBindingslistofSdkCoreNameidReleaseFfiHandle(_matchingEMobilityServiceProvidersHandle);
  }
}

void sdkRoutingChargingstationReleaseFfiHandle(Pointer<Void> handle) => _sdkRoutingChargingstationReleaseHandle(handle);

// Nullable ChargingStation

final _sdkRoutingChargingstationCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_ChargingStation_create_handle_nullable'));
final _sdkRoutingChargingstationReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_ChargingStation_release_handle_nullable'));
final _sdkRoutingChargingstationGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_ChargingStation_get_value_nullable'));

Pointer<Void> sdkRoutingChargingstationToFfiNullable(ChargingStation? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkRoutingChargingstationToFfi(value);
  final result = _sdkRoutingChargingstationCreateHandleNullable(_handle);
  sdkRoutingChargingstationReleaseFfiHandle(_handle);
  return result;
}

ChargingStation? sdkRoutingChargingstationFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkRoutingChargingstationGetValueNullable(handle);
  final result = sdkRoutingChargingstationFromFfi(_handle);
  sdkRoutingChargingstationReleaseFfiHandle(_handle);
  return result;
}

void sdkRoutingChargingstationReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkRoutingChargingstationReleaseHandleNullable(handle);

// End of ChargingStation "private" section.


