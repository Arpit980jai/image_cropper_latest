
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_image_cropper_method_channel.dart';

enum CropAspectRatioPreset {
  original,
  square,
  ratio3x4,
  ratio4x3,
  ratio9x16,
  ratio16x9
}

/// Defines the shape of the cropping frame.
enum CropShape {
  /// A rectangular crop frame.
  rectangle,

  /// A circular crop frame.
  circle,

  /// An oval crop frame.
  oval,
}

abstract class FlutterImageCropperPlatform extends PlatformInterface {
  /// Constructs a FlutterImageCropperPlatform.
  FlutterImageCropperPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterImageCropperPlatform _instance = MethodChannelFlutterImageCropper();

  /// The default instance of [FlutterImageCropperPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterImageCropper].
  static FlutterImageCropperPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterImageCropperPlatform] when
  /// they register themselves.
  static set instance(FlutterImageCropperPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> cropImage({
    required String sourcePath,
    double? aspectRatioX,
    double? aspectRatioY,
    List<CropAspectRatioPreset>? aspectRatioPresets,
    int quality = 90,
    CropShape cropShape = CropShape.rectangle,
  }) {
    throw UnimplementedError('cropImage() has not been implemented.');
  }
}
