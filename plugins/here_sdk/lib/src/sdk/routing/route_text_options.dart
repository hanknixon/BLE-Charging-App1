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
import 'package:here_sdk/src/sdk/core/language_code.dart';
import 'package:here_sdk/src/sdk/core/unit_system.dart';
import 'package:here_sdk/src/sdk/routing/text_usage_options.dart';

/// Specify how textual output should be provided.

class RouteTextOptions {
  /// The language for all textual information. When the specified language is not supported,
  /// the default language is used, which is English (United States).
  LanguageCode language;

  /// Defines the measurement system used in instruction text. When imperial is selected,
  /// units used are based on the language specified in the request. Defaults to metric.
  UnitSystem unitSystem;

  /// An option whether street name, road number and sign post direction should be used when generating notification.
  /// Defaults to each attribute as [LocalizedTextPreference.useAlways].
  TextUsageOptions textUsageOptions;

  /// Creates a new instance.

  /// [language] The language for all textual information. When the specified language is not supported,
  /// the default language is used, which is English (United States).

  /// [unitSystem] Defines the measurement system used in instruction text. When imperial is selected,
  /// units used are based on the language specified in the request. Defaults to metric.

  /// [textUsageOptions] An option whether street name, road number and sign post direction should be used when generating notification.
  /// Defaults to each attribute as [LocalizedTextPreference.useAlways].

  RouteTextOptions._(this.language, this.unitSystem, this.textUsageOptions);
  RouteTextOptions()
    : language = LanguageCode.enUs, unitSystem = UnitSystem.metric, textUsageOptions = TextUsageOptions();
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RouteTextOptions) return false;
    RouteTextOptions _other = other;
    return language == _other.language &&
        unitSystem == _other.unitSystem &&
        textUsageOptions == _other.textUsageOptions;
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + language.hashCode;
    result = 31 * result + unitSystem.hashCode;
    result = 31 * result + textUsageOptions.hashCode;
    return result;
  }
}


// RouteTextOptions "private" section, not exported.

final _sdkRoutingRoutetextoptionsCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Uint32, Uint32, Pointer<Void>),
    Pointer<Void> Function(int, int, Pointer<Void>)
  >('here_sdk_sdk_routing_RouteTextOptions_create_handle'));
final _sdkRoutingRoutetextoptionsReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_RouteTextOptions_release_handle'));
final _sdkRoutingRoutetextoptionsGetFieldlanguage = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_routing_RouteTextOptions_get_field_language'));
final _sdkRoutingRoutetextoptionsGetFieldunitSystem = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint32 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_routing_RouteTextOptions_get_field_unitSystem'));
final _sdkRoutingRoutetextoptionsGetFieldtextUsageOptions = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_RouteTextOptions_get_field_textUsageOptions'));



Pointer<Void> sdkRoutingRoutetextoptionsToFfi(RouteTextOptions value) {
  final _languageHandle = sdkCoreLanguagecodeToFfi(value.language);
  final _unitSystemHandle = sdkCoreUnitsystemToFfi(value.unitSystem);
  final _textUsageOptionsHandle = sdkRoutingTextusageoptionsToFfi(value.textUsageOptions);
  final _result = _sdkRoutingRoutetextoptionsCreateHandle(_languageHandle, _unitSystemHandle, _textUsageOptionsHandle);
  sdkCoreLanguagecodeReleaseFfiHandle(_languageHandle);
  sdkCoreUnitsystemReleaseFfiHandle(_unitSystemHandle);
  sdkRoutingTextusageoptionsReleaseFfiHandle(_textUsageOptionsHandle);
  return _result;
}

RouteTextOptions sdkRoutingRoutetextoptionsFromFfi(Pointer<Void> handle) {
  final _languageHandle = _sdkRoutingRoutetextoptionsGetFieldlanguage(handle);
  final _unitSystemHandle = _sdkRoutingRoutetextoptionsGetFieldunitSystem(handle);
  final _textUsageOptionsHandle = _sdkRoutingRoutetextoptionsGetFieldtextUsageOptions(handle);
  try {
    return RouteTextOptions._(
      sdkCoreLanguagecodeFromFfi(_languageHandle), 
      sdkCoreUnitsystemFromFfi(_unitSystemHandle), 
      sdkRoutingTextusageoptionsFromFfi(_textUsageOptionsHandle)
    );
  } finally {
    sdkCoreLanguagecodeReleaseFfiHandle(_languageHandle);
    sdkCoreUnitsystemReleaseFfiHandle(_unitSystemHandle);
    sdkRoutingTextusageoptionsReleaseFfiHandle(_textUsageOptionsHandle);
  }
}

void sdkRoutingRoutetextoptionsReleaseFfiHandle(Pointer<Void> handle) => _sdkRoutingRoutetextoptionsReleaseHandle(handle);

// Nullable RouteTextOptions

final _sdkRoutingRoutetextoptionsCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_RouteTextOptions_create_handle_nullable'));
final _sdkRoutingRoutetextoptionsReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_routing_RouteTextOptions_release_handle_nullable'));
final _sdkRoutingRoutetextoptionsGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_routing_RouteTextOptions_get_value_nullable'));

Pointer<Void> sdkRoutingRoutetextoptionsToFfiNullable(RouteTextOptions? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkRoutingRoutetextoptionsToFfi(value);
  final result = _sdkRoutingRoutetextoptionsCreateHandleNullable(_handle);
  sdkRoutingRoutetextoptionsReleaseFfiHandle(_handle);
  return result;
}

RouteTextOptions? sdkRoutingRoutetextoptionsFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkRoutingRoutetextoptionsGetValueNullable(handle);
  final result = sdkRoutingRoutetextoptionsFromFfi(_handle);
  sdkRoutingRoutetextoptionsReleaseFfiHandle(_handle);
  return result;
}

void sdkRoutingRoutetextoptionsReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkRoutingRoutetextoptionsReleaseHandleNullable(handle);

// End of RouteTextOptions "private" section.


