import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_image_cropper/flutter_image_cropper.dart';
import 'package:flutter_image_cropper/flutter_image_cropper_platform_interface.dart';
import 'package:flutter_image_cropper/flutter_image_cropper_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterImageCropperPlatform
    with MockPlatformInterfaceMixin
    implements FlutterImageCropperPlatform {

  @override
  Future<String?> cropImage({
    required String sourcePath,
    double? aspectRatioX,
    double? aspectRatioY,
    List<CropAspectRatioPreset>? aspectRatioPresets,
    int quality = 90,
  }) {
    return Future.value('mock_cropped_path');
  }
}

void main() {
  final FlutterImageCropperPlatform initialPlatform = FlutterImageCropperPlatform.instance;

  test('$MethodChannelFlutterImageCropper is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterImageCropper>());
  });

  test('cropImage', () async {
    MockFlutterImageCropperPlatform fakePlatform = MockFlutterImageCropperPlatform();
    FlutterImageCropperPlatform.instance = fakePlatform;

    expect(await FlutterImageCropper.cropImage(sourcePath: 'test_path'), 'mock_cropped_path');
  });
}
