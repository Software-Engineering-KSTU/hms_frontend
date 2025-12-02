import 'package:dio/dio.dart';

class HttpRequest {

  static final _options = BaseOptions(
    baseUrl: 'http://localhost:8080/',
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 3),
  );

  final dio = Dio(_options);

    // Полезно добавить LogInterceptor для отладки
    dio.interceptors.add(LogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  // Методы для запросов
  Future<Response> getRequest(String endpoint) async {
    return await dio.get(endpoint);
  }

  Future<Response> postRequest(
      String endpoint, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? headers,
      }) async {
    return await dio.post(
      endpoint,
      data: data,
      options: Options(headers: headers),
    );
  Future<Response> postRequest(String endpoint, {dynamic data}) async {
    return await dio.post(endpoint, data: data);
  }
}
// ------------------------------------------------------------------

class AuthInterceptor extends Interceptor {
  final String token;

  AuthInterceptor(this.token);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // В DioInterceptor токен добавляется корректно
    options.headers['Authorization'] = 'Bearer $token';
    super.onRequest(options, handler);
  }
}

class Test extends HttpRequest {

  Future<void> getTest() {
    return getRequest('api/departments');
  }

}