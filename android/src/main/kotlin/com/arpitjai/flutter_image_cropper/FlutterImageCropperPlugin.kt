package com.arpitjai.flutter_image_cropper

import android.app.Activity
import android.content.Intent
import android.net.Uri
import com.yalantis.ucrop.UCrop
import com.yalantis.ucrop.model.AspectRatio
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import java.io.File

/** FlutterImageCropperPlugin */
class FlutterImageCropperPlugin : FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {
    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private var result: Result? = null
    private val CROP_IMAGE_REQUEST_CODE = 123


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_image_cropper")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "cropImage") {
            this.result = result
            val sourcePath = call.argument<String>("source_path")
            val aspectRatioX = call.argument<Double>("aspect_ratio_x")
            val aspectRatioY = call.argument<Double>("aspect_ratio_y")
            val aspectRatioPresets = call.argument<List<String>>("aspect_ratio_presets")
            val quality = call.argument<Int>("quality")

            val sourceUri = Uri.fromFile(File(sourcePath))
            val destinationFileName = "${System.currentTimeMillis()}.jpg"
            val destinationUri = Uri.fromFile(File(activity?.cacheDir, destinationFileName))

            val uCrop = UCrop.of(sourceUri, destinationUri)

            if (aspectRatioX != null && aspectRatioY != null) {
                uCrop.withAspectRatio(aspectRatioX.toFloat(), aspectRatioY.toFloat())
            }

            val options = UCrop.Options()
            options.setCompressionQuality(quality ?: 90)

            if (aspectRatioPresets != null) {
                val aspectRatios = mutableListOf<AspectRatio>()
                for (preset in aspectRatioPresets) {
                    when (preset) {
                        "original" -> aspectRatios.add(AspectRatio("Original", 0f, 0f))
                        "square" -> aspectRatios.add(AspectRatio("1:1", 1f, 1f))
                        "ratio3x4" -> aspectRatios.add(AspectRatio("3:4", 3f, 4f))
                        "ratio4x3" -> aspectRatios.add(AspectRatio("4:3", 4f, 3f))
                        "ratio9x16" -> aspectRatios.add(AspectRatio("9:16", 9f, 16f))
                        "ratio16x9" -> aspectRatios.add(AspectRatio("16:9", 16f, 9f))
                    }
                }
                options.setAspectRatioOptions(aspectRatios.size -1, *aspectRatios.toTypedArray())
            }

            uCrop.withOptions(options)

            activity?.let { uCrop.start(it, CROP_IMAGE_REQUEST_CODE) }

        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode == CROP_IMAGE_REQUEST_CODE) {
            if (resultCode == Activity.RESULT_OK) {
                val resultUri = UCrop.getOutput(data!!)
                result?.success(resultUri?.path)
            } else if (resultCode == UCrop.RESULT_ERROR) {
                val cropError = UCrop.getError(data!!)
                result?.error("CROP_ERROR", cropError?.message, null)
            } else {
                result?.success(null)
            }
            return true
        }
        return false
    }
}
