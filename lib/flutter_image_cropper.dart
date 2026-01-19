import 'flutter_image_cropper_platform_interface.dart';

export 'flutter_image_cropper_platform_interface.dart' show CropAspectRatioPreset;

class FlutterImageCropper {
  static Future<String?> cropImage({
    required String sourcePath,
    double? aspectRatioX,
    double? aspectRatioY,
    List<CropAspectRatioPreset>? aspectRatioPresets,
    int quality = 90,
  }) {
    return FlutterImageCropperPlatform.instance.cropImage(
      sourcePath: sourcePath,
      aspectRatioX: aspectRatioX,
      aspectRatioY: aspectRatioY,
      aspectRatioPresets: aspectRatioPresets,
      quality: quality,
    );
  }
}
