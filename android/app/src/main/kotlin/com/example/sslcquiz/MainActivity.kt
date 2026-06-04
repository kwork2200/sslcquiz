package com.example.sslcquiz

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "native_pdf"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "generateTamilPdf") {
                val data = call.arguments as Map<String, Any>
                val path = TamilPdfGenerator.generate(this, data)
                result.success(path)
            } else {
                result.notImplemented()
            }
        }
    }
}
