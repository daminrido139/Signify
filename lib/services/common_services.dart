import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as imglib;

class CommonServices {
  // Function to convert CameraImage in YUV420_888 to Image widget
  static Uint8List? convertYUV420toImage(CameraImage image) {
    try {
      final int width = image.width;
      final int height = image.height;

      // Create Image buffer using the image package
      var img = imglib.Image(width: width, height: height);

      // Convert YUV to RGB
      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          // Y plane
          final int uvIndex = (y ~/ 2) * (width ~/ 2) + (x ~/ 2);

          final int yIndex = y * width + x;
          final int yValue = image.planes[0].bytes[yIndex];

          final int uValue = image.planes[1].bytes[uvIndex] - 128;
          final int vValue = image.planes[2].bytes[uvIndex] - 128;

          // Convert YUV to RGB
          final int r = (yValue + 1.370705 * vValue).clamp(0, 255).toInt();
          final int g = (yValue - 0.337633 * uValue - 0.698001 * vValue)
              .clamp(0, 255)
              .toInt();
          final int b = (yValue + 1.732446 * uValue).clamp(0, 255).toInt();

          // Set pixel color
          img.setPixel(x, y, imglib.ColorUint8.rgb(r, g, b));
        }
      }

      // Encode the image to PNG format using the image package
      imglib.PngEncoder pngEncoder = imglib.PngEncoder(
        level: 0,
        filter: imglib.PngFilter.none,
      );
      List<int> png = pngEncoder.encode(img);

      // Convert List<int> to Uint8List
      Uint8List pngBytes = Uint8List.fromList(png);
      print("${pngBytes.toString().substring(0, 8)}🙂🙂🙂🙂🙂🙂🙂🙂🙂🙂🙂");

      // Return as Image widget
      return pngBytes;
    } catch (e) {
      return null;
    }
  }
}
