import 'package:flutter/services.dart';

class NativeRepo {
  static const platform = MethodChannel("native-repo");

  Future<void> passImageToKotlin(Uint8List imageData) async {
    try {
      await platform.invokeMethod('image', imageData);
    } catch (_) {
      // error
    }
  }
}
