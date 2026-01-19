#include "include/flutter_image_cropper/flutter_image_cropper_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_image_cropper_plugin.h"

void FlutterImageCropperPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_image_cropper::FlutterImageCropperPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
