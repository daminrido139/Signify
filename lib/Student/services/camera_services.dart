import 'dart:convert';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as im;
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

class CameraServices {
  static Uint8List frontCameraConversion(CameraImage image) {
    final int width = image.width;
    final int height = image.height;

    // Create an Image buffer to hold the RGB values
    im.Image imgRGB = im.Image(width: height, height: width);

    // Get the YUV planes
    final Plane yPlane = image.planes[0]; // Y plane
    final Plane uPlane = image.planes[1]; // U plane
    final Plane vPlane = image.planes[2]; // V plane

    final int yRowStride = yPlane.bytesPerRow;
    final int uvRowStride = uPlane.bytesPerRow;
    final int uvPixelStride = uPlane.bytesPerPixel!;

    for (int y = 0; y < width; y++) {
      for (int x = 0; x < height; x++) {
        // Y value for the current pixel
        final int yIndex = x * yRowStride + y;
        final int yValue = yPlane.bytes[yIndex];

        // UV indices are quarter resolution for chroma
        final int uvIndex = (x ~/ 2) * uvRowStride + (y ~/ 2) * uvPixelStride;
        final int uValue = uPlane.bytes[uvIndex];
        final int vValue = vPlane.bytes[uvIndex];

        // Convert YUV to RGB
        int r = (yValue + 1.402 * (vValue - 128)).toInt();
        int g = (yValue - 0.344136 * (uValue - 128) - 0.714136 * (vValue - 128))
            .toInt();
        int b = (yValue + 1.772 * (uValue - 128)).toInt();

        // Clamp RGB values to [0, 255]
        r = r.clamp(0, 255);
        g = g.clamp(0, 255);
        b = b.clamp(0, 255);

        // Set pixel color in the image buffer
        imgRGB.setPixel(
            height - x - 1, width - y - 1, im.ColorInt32.rgb(r, g, b));
      }
    }
    final pngBytes = Uint8List.fromList(im.encodePng(imgRGB));
    // showDialog(
    //     context: context,
    //     builder: (context) => Dialog(child: Image.memory(pngBytes)));

    return pngBytes;
  }

  static Uint8List backCameraConversion(CameraImage image) {
    final int width = image.width;
    final int height = image.height;

    // Create an Image buffer to hold the RGB values
    im.Image imgRGB = im.Image(width: height, height: width);

    // Get the YUV planes
    final Plane yPlane = image.planes[0]; // Y plane
    final Plane uPlane = image.planes[1]; // U plane
    final Plane vPlane = image.planes[2]; // V plane

    final int yRowStride = yPlane.bytesPerRow;
    final int uvRowStride = uPlane.bytesPerRow;
    final int uvPixelStride = uPlane.bytesPerPixel!;

    for (int y = 0; y < width; y++) {
      for (int x = 0; x < height; x++) {
        // Y value for the current pixel
        final int yIndex = x * yRowStride + y;
        final int yValue = yPlane.bytes[yIndex];

        // UV indices are quarter resolution for chroma
        final int uvIndex = (x ~/ 2) * uvRowStride + (y ~/ 2) * uvPixelStride;
        final int uValue = uPlane.bytes[uvIndex];
        final int vValue = vPlane.bytes[uvIndex];

        // Convert YUV to RGB
        int r = (yValue + 1.402 * (vValue - 128)).toInt();
        int g = (yValue - 0.344136 * (uValue - 128) - 0.714136 * (vValue - 128))
            .toInt();
        int b = (yValue + 1.772 * (uValue - 128)).toInt();

        // Clamp RGB values to [0, 255]
        r = r.clamp(0, 255);
        g = g.clamp(0, 255);
        b = b.clamp(0, 255);

        // Set pixel color in the image buffer
        imgRGB.setPixel(height - x - 1, y, im.ColorInt32.rgb(r, g, b));
      }
    }
    final pngBytes = Uint8List.fromList(im.encodePng(imgRGB));
    // showDialog(
    //     context: context,
    //     builder: (context) => Dialog(child: Image.memory(pngBytes)));

    return pngBytes;
  }

  static Future<String> predictGesture(List<dynamic> args) async {
    final List<CameraImage> images = args[0];
    final CameraLensDirection lensDir = args[1];
    final callback = (lensDir == CameraLensDirection.front)
        ? frontCameraConversion
        : backCameraConversion;
    String res = '';
    final Uri url = Uri.parse('http://192.168.51.1:10000/upload');

    var request = http.MultipartRequest("POST", url);

    for (int i = 0; i < images.length; i++) {
      var multipartFile = http.MultipartFile.fromBytes(
        'file$i', // Unique name for each file
        callback(images[i]),
        filename: 'image$i.jpg', // Unique filename for each image
        contentType:
            MediaType('image', 'jpeg'), // Adjust according to your image type
      );
      request.files.add(multipartFile);
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      List<String> temp = [];
      for (String lbl
          in jsonDecode(await response.stream.bytesToString())['res']) {
        if (temp.isEmpty || temp[temp.length - 1] != lbl && lbl != "none") {
          temp.add(lbl);
        }
      }
      res = temp.join(' ');
    } else {}
    return res;
  }
}
