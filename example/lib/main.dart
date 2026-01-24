import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_cropper/flutter_image_cropper.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _imagePath;
  String? _croppedImagePath;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
        _croppedImagePath = null;
      });
    }
  }

  Future<void> _cropImage() async {
    if (_imagePath != null) {
      // The `cropImage` function now allows free-form cropping.
      // You can also pass `aspectRatioX` and `aspectRatioY` for a fixed aspect ratio.
      // For general rectangular crops, transparency for PNGs is preserved by default.
      final croppedPath = await FlutterImageCropper.cropImage(
        sourcePath: _imagePath!,
      );
      if (croppedPath != null) {
        setState(() {
          _croppedImagePath = croppedPath;
        });
      }
    }
  }

  Future<void> _cropImageCircular() async {
    if (_imagePath != null) {
      final croppedPath = await FlutterImageCropper.cropImage(
        sourcePath: _imagePath!,
        cropShape: CropShape.circle,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        // Transparency for PNGs is preserved by default.
        // The output will be a square image, which can then be displayed as a circle using ClipOval.
      );
      if (croppedPath != null) {
        setState(() {
          _croppedImagePath = croppedPath;
        });
      }
    }
  }

  Future<void> _cropImageElliptical() async {
    if (_imagePath != null) {
      final croppedPath = await FlutterImageCropper.cropImage(
        sourcePath: _imagePath!,
        cropShape: CropShape.rectangle, // Elliptical cropping is achieved by cropping a rectangle and then displaying it as an oval.
        aspectRatioPresets: [
          CropAspectRatioPreset.ratio16x9, // Example aspect ratio for an elliptical shape
          // CropAspectRatioPreset.ratio3x2, // Removed as it's undefined
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
        ],
        // Transparency for PNGs is preserved by default.
        // The output will be a rectangular image, which can then be displayed as an ellipse using ClipOval.
      );
      if (croppedPath != null) {
        setState(() {
          _croppedImagePath = croppedPath;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Image Cropper Example'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (_imagePath != null)
                  // Display the image. For circular/elliptical display, use ClipOval.
                  ClipOval(
                    child: Image.file(File(_croppedImagePath ?? _imagePath!)),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  child: const Text('Pick Image from Gallery'),
                ),
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.camera),
                  child: const Text('Capture Image from Camera'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _cropImage,
                  child: const Text('Crop Image (Free-form)'),
                ),
                ElevatedButton(
                  onPressed: _cropImageCircular,
                  child: const Text('Crop Image (Circular)'),
                ),
                ElevatedButton(
                  onPressed: _cropImageElliptical,
                  child: const Text('Crop Image (Elliptical)'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
