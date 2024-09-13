package com.example.signify

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.ImageFormat
import android.graphics.Matrix
import android.graphics.Rect
import android.graphics.YuvImage
import android.media.Image
import com.google.mediapipe.framework.image.BitmapImageBuilder
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream
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
                val plane = call.arguments as ByteArray

                val response = processImage(plane)
                result.success(response)
            } else {
                result.notImplemented()
            }
        }
    }

//
//    fun byteArrayToBitMap(bytesList: List<ByteArray>,
//                       height: Int,
//                       width: Int,
//                       rotation: Int): Bitmap {
//
//        // NV21 is a plane of 8 bit Y values followed by interleaved  Cb Cr
//        val ib = ByteBuffer.allocate(height * width * 2)
//        val y = ByteBuffer.wrap(bytesList[0])
//        val cr = ByteBuffer.wrap(bytesList[1])
//        val cb =ByteBuffer.wrap(bytesList[2])
//        ib.put(y)
//        ib.put(cb)
//        ib.put(cr)
//        val yuvImage = YuvImage(
//            ib.array(),
//            ImageFormat.NV21, width, height, null
//        )
//        val out = ByteArrayOutputStream()
//        yuvImage.compressToJpeg(
//            Rect(
//                0, 0,
//                width, height
//            ), 50, out
//        )
//        val imageBytes = out.toByteArray()
//        val bm = BitmapFactory.decodeByteArray(imageBytes, 0, imageBytes.size)
//        var bitmap = bm
//
//        // On android the camera rotation and the screen rotation
//        // are off by 90 degrees, so if you are capturing an image
//        // in "portrait" orientation, you'll need to rotate the image.
//        if (rotation.toFloat() != 0f) {
//            val matrix = Matrix()
//            matrix.postRotate(rotation.toFloat())
//            val scaledBitmap = Bitmap.createScaledBitmap(
//                bm,
//                bm.width, bm.height, true
//            )
//            bitmap = Bitmap.createBitmap(
//                scaledBitmap, 0, 0,
//                scaledBitmap.width, scaledBitmap.height, matrix, true
//            )
//        }
//        return bitmap
//    }


//    @Throws(IOException::class)
//    fun byteArrayToBitMap(
//        bytesList: List<ByteArray>,
//        imageHeight: Int,
//        imageWidth: Int,
//        rotation: Int
//    ): Bitmap {
//        val Y = ByteBuffer.wrap(bytesList[0])
//        val U = ByteBuffer.wrap(bytesList[1])
//        val V = ByteBuffer.wrap(bytesList[2])
//
//        val Yb = Y.remaining()
//        val Ub = U.remaining()
//        val Vb = V.remaining()
//
//        val data = ByteArray(Yb + Ub + Vb)
//
//        Y.get(data, 0, Yb)
//        V.get(data, Yb, Vb)
//        U.get(data, Yb + Vb, Ub)
//
//        var bitmapRaw = Bitmap.createBitmap(imageWidth, imageHeight, Bitmap.Config.ARGB_8888)
//        val bmData = renderScriptNV21ToRGBA888(
//            activity.applicationContext,
//            imageWidth,
//            imageHeight,
//            data
//        )
//        bmData.copyTo(bitmapRaw)
//
//        val matrix = Matrix()
//        matrix.postRotate(rotation.toFloat())
//        bitmapRaw = Bitmap.createBitmap(
//            bitmapRaw, 0, 0, bitmapRaw.width, bitmapRaw.height, matrix, true
//        )
//
//        return bitmapRaw
//    }
//
//    fun renderScriptNV21ToRGBA888(
//        context: Context,
//        width: Int,
//        height: Int,
//        nv21: ByteArray
//    ): Allocation {
//        // https://stackoverflow.com/a/36409748
//        val rs = RenderScript.create(context)
//        val yuvToRgbIntrinsic = ScriptIntrinsicYuvToRGB.create(rs, Element.U8_4(rs))
//
//        val yuvType = Type.Builder(rs, Element.U8(rs)).setX(nv21.size)
//        val `in` = Allocation.createTyped(rs, yuvType.create(), Allocation.USAGE_SCRIPT)
//
//        val rgbaType = Type.Builder(rs, Element.RGBA_8888(rs)).setX(width).setY(height)
//        val out = Allocation.createTyped(rs, rgbaType.create(), Allocation.USAGE_SCRIPT)
//
//        `in`.copyFrom(nv21)
//
//        yuvToRgbIntrinsic.setInput(`in`)
//        yuvToRgbIntrinsic.forEach(out)
//        return out
//    }

    private fun processImage(byteArray: ByteArray): String {
        val bitmap = BitmapFactory.decodeByteArray(byteArray, 0, byteArray.size)
        val image = bitmap.let {
            BitmapImageBuilder(it).build()
        }
        return gestObj.recognizeImage(image)
    }
}
