package com.example.signify
import io.flutter.embedding.android.FlutterActivity
import android.graphics.BitmapFactory
import com.google.mediapipe.framework.image.BitmapImageBuilder
import com.google.mediapipe.framework.image.MPImage
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.nio.ByteBuffer
import java.io.IOException        // For IOException
import android.graphics.Bitmap    // For Bitmap
import android.graphics.Matrix    // For Matrix
import android.renderscript.Allocation    // For Allocation
import android.renderscript.RenderScript  // For RenderScript
import android.renderscript.Type          // For Type
import android.renderscript.Element       //// For Element
import android.content.Context
import android.renderscript.ScriptIntrinsicYuvToRGB
/////////////////////////////


class MainActivity: FlutterActivity(){
    private val CHANNEL = "native-repo"
//    private  var gestObj = GestureRecognizerHelper(this)
    private val gestObj by lazy { GestureRecognizerHelper(applicationContext) }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "processImage") {
                val planes = call.arguments as HashMap<String,Any>

                val response = processImage(byteArrayToBitMap(planes["byteList"] as List<ByteArray>,planes["height"] as Int,planes["width"] as Int,90))
                result.success(response)
            } else {
                result.notImplemented()
            }
        }
    }


    @Throws(IOException::class)
    fun byteArrayToBitMap(
        bytesList: List<ByteArray>,
        imageHeight: Int,
        imageWidth: Int,
        rotation: Int
    ): Bitmap {
        val Y = ByteBuffer.wrap(bytesList[0])
        val U = ByteBuffer.wrap(bytesList[1])
        val V = ByteBuffer.wrap(bytesList[2])

        val Yb = Y.remaining()
        val Ub = U.remaining()
        val Vb = V.remaining()

        val data = ByteArray(Yb + Ub + Vb)

        Y.get(data, 0, Yb)
        V.get(data, Yb, Vb)
        U.get(data, Yb + Vb, Ub)

        var bitmapRaw = Bitmap.createBitmap(imageWidth, imageHeight, Bitmap.Config.ARGB_8888)
        val bmData = renderScriptNV21ToRGBA888(
            activity.applicationContext,
            imageWidth,
            imageHeight,
            data
        )
        bmData.copyTo(bitmapRaw)

        val matrix = Matrix()
        matrix.postRotate(rotation.toFloat())
        bitmapRaw = Bitmap.createBitmap(
            bitmapRaw, 0, 0, bitmapRaw.width, bitmapRaw.height, matrix, true
        )

        return bitmapRaw
    }

    fun renderScriptNV21ToRGBA888(
        context: Context,
        width: Int,
        height: Int,
        nv21: ByteArray
    ): Allocation {
        // https://stackoverflow.com/a/36409748
        val rs = RenderScript.create(context)
        val yuvToRgbIntrinsic = ScriptIntrinsicYuvToRGB.create(rs, Element.U8_4(rs))

        val yuvType = Type.Builder(rs, Element.U8(rs)).setX(nv21.size)
        val `in` = Allocation.createTyped(rs, yuvType.create(), Allocation.USAGE_SCRIPT)

        val rgbaType = Type.Builder(rs, Element.RGBA_8888(rs)).setX(width).setY(height)
        val out = Allocation.createTyped(rs, rgbaType.create(), Allocation.USAGE_SCRIPT)

        `in`.copyFrom(nv21)

        yuvToRgbIntrinsic.setInput(`in`)
        yuvToRgbIntrinsic.forEach(out)
        return out
    }

    private fun processImage(bitmap: Bitmap): String {
//        val bitmap = BitmapFactory.decodeByteArray(byteArray, 0, byteArray.size)
        val image = bitmap.let {
            BitmapImageBuilder(it).build()
        }
        if (image==null){
            return ""
        }
        val result = gestObj.recognizeImage(image)
        return result
    }
}
