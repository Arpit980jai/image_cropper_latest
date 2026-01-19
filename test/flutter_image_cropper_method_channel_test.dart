import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_image_cropper/flutter_image_cropper_method_channel.dart';

void main() {
  MethodChannelFlutterImageCropper platform = MethodChannelFlutterImageCropper();
  const MethodChannel channel = MethodChannel('flutter_image_cropper');

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
