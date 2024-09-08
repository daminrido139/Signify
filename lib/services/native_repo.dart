import 'package:flutter/services.dart';

class NativeRepo {
  static const platform = MethodChannel("native-repo");

  static Future<String> processImage(Uint8List imageData) async {
    String res = 'dummy';
    try {
      res = await platform.invokeMethod('processImage', imageData);
    } catch (_) {
      // error
    }
    return res;
  }
}
