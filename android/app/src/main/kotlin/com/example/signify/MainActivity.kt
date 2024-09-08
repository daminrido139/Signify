package com.example.signify
import io.flutter.embedding.android.FlutterActivity
import android.graphics.BitmapFactory
import com.google.mediapipe.framework.image.BitmapImageBuilder
import com.google.mediapipe.framework.image.MPImage
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.nio.ByteBuffer
/////////////////////////////


class MainActivity: FlutterActivity(){
    private val CHANNEL = "native-repo"
//    private  var gestObj = GestureRecognizerHelper(this)
    private val gestObj by lazy { GestureRecognizerHelper(applicationContext) }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "processImage") {
                val byteArray = call.arguments as ByteArray
                val response = processImage(byteArray)
                result.success(response)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun processImage(byteArray: ByteArray): String {
        val bitmap = BitmapFactory.decodeByteArray(byteArray, 0, byteArray.size)
        val image = bitmap?.let {
            BitmapImageBuilder(it).build()
        }
        if (image==null){
            return ""
        }
        val result = gestObj.recognizeImage(image)
        return result
    }
}
