import 'package:flutter/services.dart';

class NativeRepo {
  static const platform = MethodChannel("native-repo");

  static Future<String> processImage(
    Uint8List byteArray,
  ) async {
    String res = 'dummy';
    try {
      res = await platform.invokeMethod('processImage', byteArray);
    } catch (_) {
      // error
    }
    return res;
  }
}
