import 'dart:io';

import 'package:dio/dio.dart';
import 'package:imageuploadapi/feature/data/datasource/dio_source.dart';

class CloudinaryDatasource {
  final DioSource dioSource;
  final String cloudName;
  final String uploadPreset;

  CloudinaryDatasource({
    required this.dioSource,
    required this.cloudName,
    required this.uploadPreset,
  });

  Future<String> uploadImage(File image) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(image.path),
      'upload_preset': uploadPreset,
    });
    final res = await dioSource.post(
      "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
      formData: formData,
    );
    return res.data['secure_url'];
  }
}
