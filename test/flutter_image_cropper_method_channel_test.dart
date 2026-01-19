import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_cropper_latest/flutter_image_cropper_method_channel.dart';

void main() {
  MethodChannelFlutterImageCropper platform = MethodChannelFlutterImageCropper();
  const MethodChannel channel = MethodChannel('image_cropper_latest');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('cropImage', () async {
    expect(await platform.cropImage(sourcePath: 'test_path'), '42');
  });
}
