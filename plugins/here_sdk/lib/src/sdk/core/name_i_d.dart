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

/// Structure to represent name-id pairs.

class NameID {
  /// The name.
  String? name;

  /// The ID.
  String? id;

  /// Creates a new instance.

  /// [name] The name.

  /// [id] The ID.

  NameID._(this.name, this.id);
  NameID()
    : name = null, id = null;
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NameID) return false;
    NameID _other = other;
    return name == _other.name &&
        id == _other.id;
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + name.hashCode;
    result = 31 * result + id.hashCode;
    return result;
  }
}


// NameID "private" section, not exported.

final _sdkCoreNameidCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>, Pointer<Void>)
  >('here_sdk_sdk_core_NameID_create_handle'));
final _sdkCoreNameidReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_core_NameID_release_handle'));
final _sdkCoreNameidGetFieldname = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_NameID_get_field_name'));
final _sdkCoreNameidGetFieldid = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_NameID_get_field_id'));



Pointer<Void> sdkCoreNameidToFfi(NameID value) {
  final _nameHandle = stringToFfiNullable(value.name);
  final _idHandle = stringToFfiNullable(value.id);
  final _result = _sdkCoreNameidCreateHandle(_nameHandle, _idHandle);
  stringReleaseFfiHandleNullable(_nameHandle);
  stringReleaseFfiHandleNullable(_idHandle);
  return _result;
}

NameID sdkCoreNameidFromFfi(Pointer<Void> handle) {
  final _nameHandle = _sdkCoreNameidGetFieldname(handle);
  final _idHandle = _sdkCoreNameidGetFieldid(handle);
  try {
    return NameID._(
      stringFromFfiNullable(_nameHandle), 
      stringFromFfiNullable(_idHandle)
    );
  } finally {
    stringReleaseFfiHandleNullable(_nameHandle);
    stringReleaseFfiHandleNullable(_idHandle);
  }
}

void sdkCoreNameidReleaseFfiHandle(Pointer<Void> handle) => _sdkCoreNameidReleaseHandle(handle);

// Nullable NameID

final _sdkCoreNameidCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_NameID_create_handle_nullable'));
final _sdkCoreNameidReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_core_NameID_release_handle_nullable'));
final _sdkCoreNameidGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_core_NameID_get_value_nullable'));

Pointer<Void> sdkCoreNameidToFfiNullable(NameID? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkCoreNameidToFfi(value);
  final result = _sdkCoreNameidCreateHandleNullable(_handle);
  sdkCoreNameidReleaseFfiHandle(_handle);
  return result;
}

NameID? sdkCoreNameidFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkCoreNameidGetValueNullable(handle);
  final result = sdkCoreNameidFromFfi(_handle);
  sdkCoreNameidReleaseFfiHandle(_handle);
  return result;
}

void sdkCoreNameidReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkCoreNameidReleaseHandleNullable(handle);

// End of NameID "private" section.


