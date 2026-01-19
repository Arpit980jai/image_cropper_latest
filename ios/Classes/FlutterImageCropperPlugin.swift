import Flutter
import UIKit
import TOCropViewController

public class FlutterImageCropperPlugin: NSObject, FlutterPlugin, TOCropViewControllerDelegate {
    var result: FlutterResult?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_image_cropper", binaryMessenger: registrar.messenger())
        let instance = FlutterImageCropperPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "cropImage" {
            self.result = result
            let args = call.arguments as? [String: Any]
            let sourcePath = args?["source_path"] as? String
            let aspectRatioX = args?["aspect_ratio_x"] as? Double
            let aspectRatioY = args?["aspect_ratio_y"] as? Double
            let aspectRatioPresets = args?["aspect_ratio_presets"] as? [String]

            let image = UIImage(contentsOfFile: sourcePath!)
            let cropViewController = TOCropViewController(image: image!)
            cropViewController.delegate = self

            if aspectRatioX != nil && aspectRatioY != nil {
                cropViewController.aspectRatioPreset = .presetCustom
                cropViewController.customAspectRatio = CGSize(width: aspectRatioX!, height: aspectRatioY!)
                cropViewController.aspectRatioLockEnabled = true
            } else if aspectRatioPresets != nil && !aspectRatioPresets!.isEmpty {
                let firstPreset = aspectRatioPresets!.first
                switch firstPreset {
                case "original":
                    cropViewController.aspectRatioPreset = .presetOriginal
                case "square":
                    cropViewController.aspectRatioPreset = .presetSquare
                case "ratio3x4":
                    cropViewController.aspectRatioPreset = .preset4x3
                case "ratio4x3":
                    cropViewController.aspectRatioPreset = .preset3x4
                case "ratio9x16":
                    cropViewController.aspectRatioPreset = .preset16x9
                case "ratio16x9":
                    cropViewController.aspectRatioPreset = .preset9x16
                default:
                    cropViewController.aspectRatioPreset = .presetFree
                }
            }

            let rootViewController = UIApplication.shared.keyWindow?.rootViewController
            rootViewController?.present(cropViewController, animated: true, completion: nil)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    public func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        let tempDir = NSTemporaryDirectory()
        let imageName = "\(Int(Date().timeIntervalSince1970 * 1000)).jpg"
        let path = (tempDir as NSString).appendingPathComponent(imageName)
        let url = URL(fileURLWithPath: path)
        
        do {
            try image.jpegData(compressionQuality: 1.0)?.write(to: url)
            result?(url.path)
        } catch {
            result?(FlutterError(code: "SAVE_ERROR", message: "Could not save cropped image", details: nil))
        }
        
        cropViewController.dismiss(animated: true, completion: nil)
    }

    public func cropViewControllerDidCancel(_ cropViewController: TOCropViewController) {
        result?(nil)
        cropViewController.dismiss(animated: true, completion: nil)
    }
}
