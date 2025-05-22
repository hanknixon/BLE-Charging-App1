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
import 'package:here_sdk/src/sdk/search/web_source.dart';
import 'package:meta/meta.dart';




/// Contains image information and direct link to it.

class WebImage {
  /// Photo publication date.
  /// Always set to 1.1.1970.
  @Deprecated("Will be removed in v4.24.0.")
  DateTime date;

  /// Detailed information about image source.
  WebSource source;

  /// Photo publication date.
  /// Always set to `null`.
  @Deprecated("Will be removed in v4.24.0.")
  DateTime? publicationDate;

  WebImage._(this.date, this.source, this.publicationDate);
  /// Creates a new instance.
  ///
  /// Sets [WebImage.source] to the given source,
  /// and both [WebImage.date] and [WebImage.publicationDate] to the given date.
  ///
  /// [date] Photo publication date.
  ///
  /// [source] Detailed information about image source.
  ///
  @Deprecated("Will be removed in v4.24.0. Use `WebImage.withSource` instead.")

  factory WebImage(DateTime date, WebSource source) => $prototype.$init(date, source);
  /// Creates a new instance.
  ///
  /// Sets [WebImage.source] to the given source, [WebImage.date] to 1.1.1970.
  /// and [WebImage.publicationDate] to `null`.
  ///
  /// [source] Detailed information about image source.
  ///
  factory WebImage.withSource(WebSource source) => $prototype.withSource(source);
  /// Creates a new instance.
  ///
  /// Sets [WebImage.source] to the given source,
  /// and both [WebImage.date] and [WebImage.publicationDate] to the given publication date.
  ///
  /// [source] Detailed information about image source.
  ///
  /// [publicationDate] Photo publication date.
  ///
  @Deprecated("Will be removed in v4.24.0. Use the constructor that takes only `WebSource`.")

  factory WebImage.withSourceAndPublicationDate(WebSource source, DateTime publicationDate) => $prototype.withSourceAndPublicationDate(source, publicationDate);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WebImage) return false;
    WebImage _other = other;
    return date == _other.date &&
        source == _other.source &&
        publicationDate == _other.publicationDate;
  }

  @override
  int get hashCode {
    int result = 7;
    result = 31 * result + date.hashCode;
    result = 31 * result + source.hashCode;
    result = 31 * result + publicationDate.hashCode;
    return result;
  }

  /// @nodoc
  @visibleForTesting
  static dynamic $prototype = WebImage$Impl();
}


// WebImage "private" section, not exported.

final _sdkSearchWebimageCreateHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Uint64, Pointer<Void>, Pointer<Void>),
    Pointer<Void> Function(int, Pointer<Void>, Pointer<Void>)
  >('here_sdk_sdk_search_WebImage_create_handle'));
final _sdkSearchWebimageReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_search_WebImage_release_handle'));
final _sdkSearchWebimageGetFielddate = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Uint64 Function(Pointer<Void>),
    int Function(Pointer<Void>)
  >('here_sdk_sdk_search_WebImage_get_field_date'));
final _sdkSearchWebimageGetFieldsource = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_WebImage_get_field_source'));
final _sdkSearchWebimageGetFieldpublicationDate = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_WebImage_get_field_publicationDate'));



/// @nodoc
@visibleForTesting
class WebImage$Impl {
  WebImage $init(DateTime date, WebSource source) {
    final _$initFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Int32, Uint64, Pointer<Void>), Pointer<Void> Function(int, int, Pointer<Void>)>('here_sdk_sdk_search_WebImage_make__Date_WebSource'));
    final _dateHandle = dateToFfi(date);
    final _sourceHandle = sdkSearchWebsourceToFfi(source);
    final __resultHandle = _$initFfi(__lib.LibraryContext.isolateId, _dateHandle, _sourceHandle);
    dateReleaseFfiHandle(_dateHandle);
    sdkSearchWebsourceReleaseFfiHandle(_sourceHandle);
    try {
      return sdkSearchWebimageFromFfi(__resultHandle);
    } finally {
      sdkSearchWebimageReleaseFfiHandle(__resultHandle);

    }

  }

  WebImage withSource(WebSource source) {
    final _withSourceFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Int32, Pointer<Void>), Pointer<Void> Function(int, Pointer<Void>)>('here_sdk_sdk_search_WebImage_make__WebSource'));
    final _sourceHandle = sdkSearchWebsourceToFfi(source);
    final __resultHandle = _withSourceFfi(__lib.LibraryContext.isolateId, _sourceHandle);
    sdkSearchWebsourceReleaseFfiHandle(_sourceHandle);
    try {
      return sdkSearchWebimageFromFfi(__resultHandle);
    } finally {
      sdkSearchWebimageReleaseFfiHandle(__resultHandle);

    }

  }

  WebImage withSourceAndPublicationDate(WebSource source, DateTime publicationDate) {
    final _withSourceAndPublicationDateFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Int32, Pointer<Void>, Uint64), Pointer<Void> Function(int, Pointer<Void>, int)>('here_sdk_sdk_search_WebImage_make__WebSource_Date'));
    final _sourceHandle = sdkSearchWebsourceToFfi(source);
    final _publicationDateHandle = dateToFfi(publicationDate);
    final __resultHandle = _withSourceAndPublicationDateFfi(__lib.LibraryContext.isolateId, _sourceHandle, _publicationDateHandle);
    sdkSearchWebsourceReleaseFfiHandle(_sourceHandle);
    dateReleaseFfiHandle(_publicationDateHandle);
    try {
      return sdkSearchWebimageFromFfi(__resultHandle);
    } finally {
      sdkSearchWebimageReleaseFfiHandle(__resultHandle);

    }

  }

}

Pointer<Void> sdkSearchWebimageToFfi(WebImage value) {
  final _dateHandle = dateToFfi(value.date);
  final _sourceHandle = sdkSearchWebsourceToFfi(value.source);
  final _publicationDateHandle = dateToFfiNullable(value.publicationDate);
  final _result = _sdkSearchWebimageCreateHandle(_dateHandle, _sourceHandle, _publicationDateHandle);
  dateReleaseFfiHandle(_dateHandle);
  sdkSearchWebsourceReleaseFfiHandle(_sourceHandle);
  dateReleaseFfiHandleNullable(_publicationDateHandle);
  return _result;
}

WebImage sdkSearchWebimageFromFfi(Pointer<Void> handle) {
  final _dateHandle = _sdkSearchWebimageGetFielddate(handle);
  final _sourceHandle = _sdkSearchWebimageGetFieldsource(handle);
  final _publicationDateHandle = _sdkSearchWebimageGetFieldpublicationDate(handle);
  try {
    return WebImage._(
      dateFromFfi(_dateHandle), 
      sdkSearchWebsourceFromFfi(_sourceHandle), 
      dateFromFfiNullable(_publicationDateHandle)
    );
  } finally {
    dateReleaseFfiHandle(_dateHandle);
    sdkSearchWebsourceReleaseFfiHandle(_sourceHandle);
    dateReleaseFfiHandleNullable(_publicationDateHandle);
  }
}

void sdkSearchWebimageReleaseFfiHandle(Pointer<Void> handle) => _sdkSearchWebimageReleaseHandle(handle);

// Nullable WebImage

final _sdkSearchWebimageCreateHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_WebImage_create_handle_nullable'));
final _sdkSearchWebimageReleaseHandleNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_search_WebImage_release_handle_nullable'));
final _sdkSearchWebimageGetValueNullable = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_search_WebImage_get_value_nullable'));

Pointer<Void> sdkSearchWebimageToFfiNullable(WebImage? value) {
  if (value == null) return Pointer<Void>.fromAddress(0);
  final _handle = sdkSearchWebimageToFfi(value);
  final result = _sdkSearchWebimageCreateHandleNullable(_handle);
  sdkSearchWebimageReleaseFfiHandle(_handle);
  return result;
}

WebImage? sdkSearchWebimageFromFfiNullable(Pointer<Void> handle) {
  if (handle.address == 0) return null;
  final _handle = _sdkSearchWebimageGetValueNullable(handle);
  final result = sdkSearchWebimageFromFfi(_handle);
  sdkSearchWebimageReleaseFfiHandle(_handle);
  return result;
}

void sdkSearchWebimageReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkSearchWebimageReleaseHandleNullable(handle);

// End of WebImage "private" section.


