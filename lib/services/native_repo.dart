import 'package:flutter/services.dart';

class NativeRepo {
  static const platform = MethodChannel("native-repo");

  static Future<String> processImage(
    List<Uint8List> bytesList,
    int height,
    int width,
  ) async {
    String res = 'dummy';
    try {
      res = await platform.invokeMethod('processImage', {
        "byteList": bytesList,
        "height": height,
        "width": width,
      });
    } catch (_) {
      // error
    }
    return res;
  }
}
