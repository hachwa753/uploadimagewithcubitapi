import 'package:dio/dio.dart';
import 'package:imageuploadapi/core/network/dio_client.dart';

class DioSource {
  final DioClient dioClient;
  DioSource(this.dioClient);

  //post request
  Future<Response> post(
    String url, {
    Map<String, dynamic>? data,
    FormData? formData,
  }) async {
    return await dioClient.client.post(url, data: formData ?? data);
  }
}
