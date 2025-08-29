import 'dart:convert';
import 'dart:typed_data';

class ImageUtils {
  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }
}