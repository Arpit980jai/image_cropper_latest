## 0.0.4
- Added support for custom crop shapes: `rectangle` (default), `circle`, and `oval`.
- Implemented platform-specific logic for Android (uCrop) and iOS (TOCropViewController) to handle different crop shapes.
- Ensured transparency is preserved for non-rectangular crops (PNG output).
- Updated Dart API to introduce `CropShape` enum and `cropShape` parameter.

## 0.0.1
- Initial release
- Android image cropping using uCrop
- iOS image cropping using TOCropViewController
- Gallery & camera support in example app
