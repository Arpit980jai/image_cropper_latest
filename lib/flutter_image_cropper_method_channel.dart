import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_image_cropper_platform_interface.dart';

/// An implementation of [FlutterImageCropperPlatform] that uses method channels.
class MethodChannelFlutterImageCropper extends FlutterImageCropperPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_image_cropper');

  @override
  Future<String?> cropImage({
    required String sourcePath,
    double? aspectRatioX,
    double? aspectRatioY,
    List<CropAspectRatioPreset>? aspectRatioPresets,
    int quality = 90,
  }) async {
    final Map<String, dynamic> arguments = {
      'source_path': sourcePath,
      'aspect_ratio_x': aspectRatioX,
      'aspect_ratio_y': aspectRatioY,
      'aspect_ratio_presets': aspectRatioPresets?.map((preset) => preset.toString().split('.').last).toList(),
      'quality': quality,
    };
    final String? result = await methodChannel.invokeMethod('cropImage', arguments);
    return result;
  }
}
