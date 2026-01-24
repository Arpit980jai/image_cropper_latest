// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'flutter_image_cropper_platform_interface.dart';

/// A web implementation of the image_cropper_latest plugin.
class FlutterImageCropperWeb extends FlutterImageCropperPlatform {
  /// Constructs a FlutterImageCropperWeb.
  FlutterImageCropperWeb();

  static void registerWith(Registrar registrar) {
    FlutterImageCropperPlatform.instance = FlutterImageCropperWeb();
  }

  @override
  Future<String?> cropImage({
    required String sourcePath,
    double? aspectRatioX,
    double? aspectRatioY,
    List<CropAspectRatioPreset>? aspectRatioPresets,
    int quality = 90,
    CropShape cropShape = CropShape.rectangle,
  }) async {
    // We are not implementing the web platform, so we throw an error.
    throw UnimplementedError('cropImage() has not been implemented on the web.');
  }
}
