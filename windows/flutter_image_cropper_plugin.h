#ifndef FLUTTER_PLUGIN_FLUTTER_IMAGE_CROPPER_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_IMAGE_CROPPER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_image_cropper {

class FlutterImageCropperPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterImageCropperPlugin();

  virtual ~FlutterImageCropperPlugin();

  // Disallow copy and assign.
  FlutterImageCropperPlugin(const FlutterImageCropperPlugin&) = delete;
  FlutterImageCropperPlugin& operator=(const FlutterImageCropperPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_image_cropper

#endif  // FLUTTER_PLUGIN_FLUTTER_IMAGE_CROPPER_PLUGIN_H_
