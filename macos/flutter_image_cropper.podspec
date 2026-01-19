#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_image_cropper.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_image_cropper'
  s.version          = '0.0.1'
  s.summary          = 'flutter_image_cropper is a modern, lightweight, and highly customizable image cropping package for Flutter.  It provides a clean API to crop images with gesture-based controls, aspect ratio locking, rotation, and high-quality output—designed for today’s Flutter apps.  Built with performance and simplicity in mind, this package works seamlessly on Android and iOS, making it ideal for profile pictures, product images, document scanning, and more.'
  s.description      = <<-DESC
flutter_image_cropper is a modern, lightweight, and highly customizable image cropping package for Flutter.  It provides a clean API to crop images with gesture-based controls, aspect ratio locking, rotation, and high-quality output—designed for today’s Flutter apps.  Built with performance and simplicity in mind, this package works seamlessly on Android and iOS, making it ideal for profile pictures, product images, document scanning, and more.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }

  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'

  # If your plugin requires a privacy manifest, for example if it collects user
  # data, update the PrivacyInfo.xcprivacy file to describe your plugin's
  # privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'flutter_image_cropper_privacy' => ['Resources/PrivacyInfo.xcprivacy']}

  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
