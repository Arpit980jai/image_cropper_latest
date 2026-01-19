# flutter_image_cropper

A modern, lightweight, and highly customizable image cropping package for Flutter. It provides a clean API to crop images with gesture-based controls, aspect ratio locking, rotation, and high-quality output—designed for today’s Flutter apps. Built with performance and simplicity in mind, this package works seamlessly on Android and iOS, making it ideal for profile pictures, product images, document scanning, and more.

## Features

*   Crop image from a local file path
*   Freeform cropping
*   Aspect ratio cropping (1:1, 4:3, 16:9, etc.)
*   Rotation support (Android & iOS)
*   Control over output image quality
*   Returns the file path of the cropped image

## Platform Support

| Platform | Supported |
| :------- | :-------: |
| ✅ Android |    ✅     |
| ✅ iOS     |    ✅     |
| ❌ Web     |    ❌     |
| ❌ Desktop |    ❌     |

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_image_cropper: ^0.0.1 # Replace with the latest version
  image_picker: ^1.0.4 # For picking images
```

Then, run `flutter pub get`.

**iOS Integration:**

Add the following keys to your `Info.plist` file, located in `<project root>/ios/Runner/Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to take photos for cropping.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs photo library access to select photos for cropping.</string>
```

**Android Integration:**

No specific configuration is required for Android if you are targeting `minSdkVersion 24` or higher. The plugin uses the uCrop library, which is automatically included.

## Usage Example

Here is a complete example of how to pick an image from the gallery or camera and then crop it.

```dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_cropper/flutter_image_cropper.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _imagePath;
  String? _croppedImagePath;
  final ImagePicker _picker = ImagePicker();

  // Pick an image from the gallery
  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        _croppedImagePath = null; // Clear previous crop
      });
    }
  }

  // Capture an image from the camera
  Future<void> _pickImageFromCamera() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        _croppedImagePath = null; // Clear previous crop
      });
    }
  }

  // Crop the selected image
  Future<void> _cropImage() async {
    if (_imagePath == null) return;

    final String? croppedPath = await FlutterImageCropper.cropImage(
      sourcePath: _imagePath!,
      aspectRatioX: 1.0, // e.g., 16
      aspectRatioY: 1.0, // e.g., 9
      quality: 90,
    );

    if (croppedPath != null) {
      setState(() {
        _croppedImagePath = croppedPath;
      });
    } else {
      // User cancelled the crop
      print("Cropping cancelled.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Image Cropper Example')),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (_imagePath != null) ...[
                  SizedBox(height: 20),
                  Text("Original Image", style: Theme.of(context).textTheme.headlineSmall),
                  Image.file(File(_imagePath!)),
                ],
                if (_croppedImagePath != null) ...[
                  SizedBox(height: 20),
                  Text("Cropped Image", style: Theme.of(context).textTheme.headlineSmall),
                  Image.file(File(_croppedImagePath!)),
                ],
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _pickImageFromGallery,
                  child: const Text('Pick from Gallery'),
                ),
                ElevatedButton(
                  onPressed: _pickImageFromCamera,
                  child: const Text('Capture with Camera'),
                ),
                ElevatedButton(
                  onPressed: _imagePath != null ? _cropImage : null,
                  child: const Text('Crop Image'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

## API Documentation

### `FlutterImageCropper.cropImage`

```dart
static Future<String?> cropImage({
  required String sourcePath,
  double? aspectRatioX,
  double? aspectRatioY,
  int quality = 90,
});
```

*   **`sourcePath`**: (Required) The absolute file path of the image to be cropped.
*   **`aspectRatioX`**: (Optional) The 'X' value for the crop aspect ratio. If both `aspectRatioX` and `aspectRatioY` are provided, the crop view will be locked to this ratio.
*   **`aspectRatioY`**: (Optional) The 'Y' value for the crop aspect ratio.
*   **`quality`**: (Optional) The quality of the output image, ranging from 0 to 100. Defaults to `90`.

**Returns:**

*   A `Future<String?>` which resolves to the file path of the cropped image.
*   Returns `null` if the user cancels the cropping operation.

## Screenshots

*(Placeholder for screenshots of the Android and iOS cropping UI)*

## Contribution

Contributions are welcome! If you find a bug or want to add a new feature, please file an issue or submit a pull request.

1.  Fork the repository.
2.  Create your feature branch (`git checkout -b my-new-feature`).
3.  Commit your changes (`git commit -am 'Add some feature'`).
4.  Push to the branch (`git push origin my-new-feature`).
5.  Create a new Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
