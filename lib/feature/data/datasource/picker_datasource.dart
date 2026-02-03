import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PickerDatasource {
  final ImagePicker picker;

  PickerDatasource(this.picker);

  Future<File?> pickFromGallery() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    } else {
      return null;
    }
  }

  Future<File?> pickFromCamera() async {
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      return File(image.path);
    } else {
      return null;
    }
  }
}
