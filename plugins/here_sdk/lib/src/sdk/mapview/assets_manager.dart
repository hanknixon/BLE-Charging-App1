// Copyright (c) 2019-2024 HERE Global B.V. and its affiliate(s).
// All rights reserved.
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
import 'package:here_sdk/src/_native_base.dart' as __lib;
import 'package:here_sdk/src/_token_cache.dart' as __lib;
import 'package:here_sdk/src/builtin_types__conversion.dart';
import 'package:here_sdk/src/generic_types__conversion.dart';
import 'package:here_sdk/src/sdk/mapview/map_context.dart';
import 'package:meta/meta.dart';

/// Assets manager interface.
///
/// Can be used to make assets available to the SDK.
///
/// Note: This is a beta release of this feature, so there could be a few bugs and unexpected
/// behavior. Related APIs may change for new releases without a deprecation process.
abstract class AssetsManager implements Finalizable {
  /// Creates an instance of AssetsManager.
  ///
  /// [context] MapContext to which the assets belong.
  ///
  factory AssetsManager(MapContext context) => $prototype.create(context);

  /// Registers a font under a font name.
  ///
  /// After registration, the font name can be used in
  /// * the SVG `text` tag as `font-family` attribute parameter when creating a `MapImage` with `ImageFormat.SVG`.
  /// * [MapMarkerTextStyle]
  ///
  /// Repeated registration with the same font name is ignored.
  ///
  /// [fontName] A font name.
  ///
  /// [fontPath] A font file path. TTF, OTF and WOFF formats are supported.
  ///
  /// Can be an asset file path or an absolute file path.
  ///
  void registerFont(String fontName, String fontPath);
  /// Registers a font set under a font name.
  ///
  /// After registration, the font name can be used in
  /// * the SVG `text` tag as `font-family` attribute parameter when creating a `MapImage` with `ImageFormat.SVG`.
  /// * [MapMarkerTextStyle]
  ///
  /// Repeated registration with the same font name is ignored.
  ///
  /// [fontName] A font name.
  ///
  /// [fontPath] A font file path. TTF, OTF and WOFF formats are supported.
  ///
  /// Can be an asset file path or an absolute file path.
  ///
  /// [fallbackFontFilePaths] Additional font files are intended to be used if main font
  /// does not contain required character symbol and shall be sorted starting from most useful.
  ///
  void registerFontWithFallback(String fontName, String fontPath, List<String> fallbackFontFilePaths);

  /// @nodoc
  @visibleForTesting
  static dynamic $prototype = AssetsManager$Impl(Pointer<Void>.fromAddress(0));
}


// AssetsManager "private" section, not exported.

final _sdkMapviewAssetsmanagerRegisterFinalizer = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>, Int32, Handle),
    void Function(Pointer<Void>, int, Object)
  >('here_sdk_sdk_mapview_AssetsManager_register_finalizer'));
final _sdkMapviewAssetsmanagerCopyHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Pointer<Void> Function(Pointer<Void>),
    Pointer<Void> Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_AssetsManager_copy_handle'));
final _sdkMapviewAssetsmanagerReleaseHandle = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<
    Void Function(Pointer<Void>),
    void Function(Pointer<Void>)
  >('here_sdk_sdk_mapview_AssetsManager_release_handle'));





/// @nodoc
@visibleForTesting

class AssetsManager$Impl extends __lib.NativeBase implements AssetsManager {

  AssetsManager$Impl(Pointer<Void> handle) : super(handle);


  AssetsManager create(MapContext context) {
    final _result_handle = _create(context);
    final _result = AssetsManager$Impl(_result_handle);

    __lib.cacheInstance(_result_handle, _result);

    _sdkMapviewAssetsmanagerRegisterFinalizer(_result_handle, __lib.LibraryContext.isolateId, _result);

    return _result;
  }

  static Pointer<Void> _create(MapContext context) {
    final _createFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Pointer<Void> Function(Int32, Pointer<Void>), Pointer<Void> Function(int, Pointer<Void>)>('here_sdk_sdk_mapview_AssetsManager_create__MapContext'));
    final _contextHandle = sdkMapviewMapcontextToFfi(context);
    final __resultHandle = _createFfi(__lib.LibraryContext.isolateId, _contextHandle);
    sdkMapviewMapcontextReleaseFfiHandle(_contextHandle);
    return __resultHandle;
  }

  @override
  void registerFont(String fontName, String fontPath) {
    final _registerFontFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>, Pointer<Void>)>('here_sdk_sdk_mapview_AssetsManager_registerFont__String_String'));
    final _fontNameHandle = stringToFfi(fontName);
    final _fontPathHandle = stringToFfi(fontPath);
    final _handle = this.handle;
    _registerFontFfi(_handle, __lib.LibraryContext.isolateId, _fontNameHandle, _fontPathHandle);
    stringReleaseFfiHandle(_fontNameHandle);
    stringReleaseFfiHandle(_fontPathHandle);

  }

  @override
  void registerFontWithFallback(String fontName, String fontPath, List<String> fallbackFontFilePaths) {
    final _registerFontWithFallbackFfi = __lib.catchArgumentError(() => __lib.nativeLibrary.lookupFunction<Void Function(Pointer<Void>, Int32, Pointer<Void>, Pointer<Void>, Pointer<Void>), void Function(Pointer<Void>, int, Pointer<Void>, Pointer<Void>, Pointer<Void>)>('here_sdk_sdk_mapview_AssetsManager_registerFontWithFallback__String_String_ListOf_String'));
    final _fontNameHandle = stringToFfi(fontName);
    final _fontPathHandle = stringToFfi(fontPath);
    final _fallbackFontFilePathsHandle = harpSdkBindingslistofStringToFfi(fallbackFontFilePaths);
    final _handle = this.handle;
    _registerFontWithFallbackFfi(_handle, __lib.LibraryContext.isolateId, _fontNameHandle, _fontPathHandle, _fallbackFontFilePathsHandle);
    stringReleaseFfiHandle(_fontNameHandle);
    stringReleaseFfiHandle(_fontPathHandle);
    harpSdkBindingslistofStringReleaseFfiHandle(_fallbackFontFilePathsHandle);

  }


}

Pointer<Void> sdkMapviewAssetsmanagerToFfi(AssetsManager value) =>
  _sdkMapviewAssetsmanagerCopyHandle((value as __lib.NativeBase).handle);

AssetsManager sdkMapviewAssetsmanagerFromFfi(Pointer<Void> handle) {
  if (handle.address == 0) throw StateError("Expected non-null value.");
  final instance = __lib.getCachedInstance(handle);
  if (instance != null && instance is AssetsManager) return instance;

  final _copiedHandle = _sdkMapviewAssetsmanagerCopyHandle(handle);
  final result = AssetsManager$Impl(_copiedHandle);
  __lib.cacheInstance(_copiedHandle, result);
  _sdkMapviewAssetsmanagerRegisterFinalizer(_copiedHandle, __lib.LibraryContext.isolateId, result);
  return result;
}

void sdkMapviewAssetsmanagerReleaseFfiHandle(Pointer<Void> handle) =>
  _sdkMapviewAssetsmanagerReleaseHandle(handle);

Pointer<Void> sdkMapviewAssetsmanagerToFfiNullable(AssetsManager? value) =>
  value != null ? sdkMapviewAssetsmanagerToFfi(value) : Pointer<Void>.fromAddress(0);

AssetsManager? sdkMapviewAssetsmanagerFromFfiNullable(Pointer<Void> handle) =>
  handle.address != 0 ? sdkMapviewAssetsmanagerFromFfi(handle) : null;

void sdkMapviewAssetsmanagerReleaseFfiHandleNullable(Pointer<Void> handle) =>
  _sdkMapviewAssetsmanagerReleaseHandle(handle);

// End of AssetsManager "private" section.


