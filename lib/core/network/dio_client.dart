import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  DioClient({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              connectTimeout: Duration(seconds: 20),
              receiveTimeout: Duration(seconds: 20),
              responseType: ResponseType.json,
            ),
          ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          print('Request: ${options.method} ${options.uri}');
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          print('Response [${response.statusCode}]: ${response.data}');
          return handler.next(response);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) {
          print('Error: ${error.message}');
          return handler.next(error);
        },
      ),
    );
  }
  Dio get client => _dio;
}
