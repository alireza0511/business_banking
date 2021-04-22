import 'dart:convert';
import 'dart:typed_data';

import 'package:clean_framework/clean_framework.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerPlugin extends ExternalDependency {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<PickedFile?> cameraImgFile() async {
    try {
      var imgFile = await _onImageActionListener();

      return imgFile;
    } catch (e) {
      return null;
    }
  }

  Future<String> cameraImgBase64() async {
    try {
      var imgFile = await _onImageActionListener();
      if (imgFile != null) {
        Uint8List byteFile = await imgFile.readAsBytes();
        return base64.encode(byteFile);
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  Future<PickedFile?> _onImageActionListener(
      {ImageSource source = ImageSource.camera,
      int imageQuality = 100,
      double? maxHeight,
      double? maxWidth}) async {
    try {
      final pickedFile = await _picker.getImage(
          source: source,
          imageQuality: imageQuality,
          maxHeight: maxHeight,
          maxWidth: maxWidth);
      return pickedFile;
    } catch (e) {
      return null;
    }
  }
}
