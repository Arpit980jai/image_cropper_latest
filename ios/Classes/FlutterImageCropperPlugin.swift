
import Flutter
import UIKit
import TOCropViewController

public class FlutterImageCropperPlugin: NSObject, FlutterPlugin, TOCropViewControllerDelegate {
    var result: FlutterResult?
    var cropShape: String = "rectangle"

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "image_cropper_latest", binaryMessenger: registrar.messenger())
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
            self.cropShape = args?["crop_shape"] as? String ?? "rectangle"

            let image = UIImage(contentsOfFile: sourcePath!)
            
            let style: TOCropViewCroppingStyle
            switch self.cropShape {
            case "circle", "oval":
                style = .circular
            default:
                style = .default
            }
            
            let cropViewController = TOCropViewController(croppingStyle: style, image: image!)
            cropViewController.delegate = self

            if style == .default {
                if aspectRatioX != nil && aspectRatioY != nil {
                    cropViewController.aspectRatioPreset = .presetCustom
                    cropViewController.customAspectRatio = CGSize(width: aspectRatioX!, height: aspectRatioY!)
                    cropViewController.aspectRatioLockEnabled = true
                } else {
                    // Configure presets for rectangle mode if any
                    let aspectRatioPresets = args?["aspect_ratio_presets"] as? [String]
                    if aspectRatioPresets != nil && !aspectRatioPresets!.isEmpty {
                        // TOCropViewController doesn't support multiple presets, so we use the first one.
                    }
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
        let fileExtension = (self.cropShape == "circle" || self.cropShape == "oval") ? ".png" : ".jpg"
        let imageName = "\(Int(Date().timeIntervalSince1970 * 1000))\(fileExtension)"
        let path = (tempDir as NSString).appendingPathComponent(imageName)
        let url = URL(fileURLWithPath: path)
        
        do {
            if self.cropShape == "circle" || self.cropShape == "oval" {
                try image.pngData()?.write(to: url)
            } else {
                try image.jpegData(compressionQuality: 1.0)?.write(to: url)
            }
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
