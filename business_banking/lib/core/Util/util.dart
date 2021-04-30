import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class UtilMethod {
  static Future<String> imgFileTobase64(String path) async {
    File imgFile = File(path);

    Uint8List byteFile = await imgFile.readAsBytes();
    return base64.encode(byteFile);
  }
}
