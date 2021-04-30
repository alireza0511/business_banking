import 'dart:io';

import 'package:flutter/services.dart';

class TestUtil {
  static Future<String> getImgFilePathFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/images/$path');

    final myDir = Directory(
        '/storage/emulated/0/Android/data/com.huntington.business_banking/files/Pictures/');
    var isThere = await myDir.exists();
    if (isThere) return myDir.path;
    final file = File(
        '/storage/emulated/0/Android/data/com.huntington.business_banking/files/Pictures/$path');

    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file.path;
  }
}
