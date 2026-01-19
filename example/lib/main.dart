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
                  Image.file(File(_croppedImagePath ?? _imagePath!)),
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
