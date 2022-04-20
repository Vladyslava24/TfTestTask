package com.totalfit.mobile.android

import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.annotation.NonNull
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File
import android.view.WindowManager
import android.os.Bundle
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingBackgroundService;
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback

class MainActivity : FlutterActivity(), PluginRegistrantCallback {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        FlutterFirebaseMessagingBackgroundService.setPluginRegistrant(this)
        window.setBackgroundDrawable(null)
        window.clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
    }

    override fun registerWith(registry: PluginRegistry?) {}

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "channel:${BuildConfig.APPLICATION_ID}/share").setMethodCallHandler { call, result ->
            onShareMethodInvoked(call, result)
        }
    }

    private fun onShareMethodInvoked(methodCall: MethodCall, result: MethodChannel.Result) {
        if (methodCall.method == "shareFile") {
            require(methodCall.arguments is String) { "String argument expected" }
            // Android does not support showing the share sheet at a particular point on screen.
            shareFile(methodCall.arguments as String, activity)
            result.success(true)
        } else {
            result.notImplemented()
        }
    }

    private fun shareFile(path: String, context: Context) {
        val imageFile = File(path)
        val contentUri: Uri = FileProvider.getUriForFile(context, "${BuildConfig.APPLICATION_ID}.fileprovider", imageFile)
        val shareIntent = Intent(Intent.ACTION_SEND)
        shareIntent.type = "image/jpg"
        shareIntent.putExtra(Intent.EXTRA_STREAM, contentUri)
        context.startActivity(Intent.createChooser(shareIntent, "Share Workout results using"))
    }
}