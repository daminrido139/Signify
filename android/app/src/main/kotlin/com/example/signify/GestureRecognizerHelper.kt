package com.example.signify
import com.google.mediapipe.framework.image.BitmapImageBuilder
import com.google.mediapipe.framework.image.MPImage
import com.google.mediapipe.tasks.core.BaseOptions
import com.google.mediapipe.tasks.core.Delegate
import com.google.mediapipe.tasks.vision.core.RunningMode
import com.google.mediapipe.tasks.vision.gesturerecognizer.GestureRecognizer
import com.google.mediapipe.tasks.vision.gesturerecognizer.GestureRecognizerResult
import android.content.Context

class GestureRecognizerHelper(

    val context: Context,
){
    private var gestureRecognizer: GestureRecognizer? = null
    var myerror = "default man"
    init {
        setupGestureRecognizer()
    }

    fun setupGestureRecognizer() {
        // Set general recognition options, including number of used threads
        val baseOptionBuilder = BaseOptions.builder()
        baseOptionBuilder.setDelegate(Delegate.CPU)
        baseOptionBuilder.setModelAssetPath("sign_ml.task")

        try {
            val baseOptions = baseOptionBuilder.build()
            val optionsBuilder =
                GestureRecognizer.GestureRecognizerOptions.builder()
                    .setBaseOptions(baseOptions)
                    .setMinHandDetectionConfidence(0.5f)
                    .setMinTrackingConfidence(0.5f)
                    .setMinHandPresenceConfidence(0.5f)
                    .setRunningMode(RunningMode.IMAGE)
            val options = optionsBuilder.build()
            gestureRecognizer =
                GestureRecognizer.createFromOptions(context, options)
        } catch (e: IllegalStateException) {
            myerror = e.toString()
        } catch (e: RuntimeException) {
            myerror = e.toString()
        }
    }

     fun recognizeImage(image: MPImage): String {


        // Inference time is the difference between the system time at the
        // start and finish of the process

        // Convert the input Bitmap object to an MPImage object to run inference

        // Run gesture recognizer using MediaPipe Gesture Recognizer API
        val result = gestureRecognizer?.recognize(image)
        if (result==null){
            return myerror
        }
        return result.gestures().toString()

        // If gestureRecognizer?.recognize() returns null, this is likely an error. Returning null
        // to indicate this.

    }
}