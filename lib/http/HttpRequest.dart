// fileName: lib/http/HttpRequest.dart
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:hmsweb/navigation/Navigation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// --- ДОБАВЛЯЕМ ИМПОРТ ---
import 'package:hmsweb/GlobalStorage.dart';

final Dio dioHttpRequest = Dio(
  BaseOptions(
    baseUrl: 'http://localhost:8080/',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ),
);

// --- УДАЛЯЕМ СТРОКУ НИЖЕ (она создавала конфликт) ---
// final flutterStorage = FlutterSecureStorage(); <--- УДАЛЕНО

void setUpDioHttpRequest() {
  dioHttpRequest.interceptors.add(AuthInterceptor());

  dioHttpRequest.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  );
}

//todo deprecated
class HttpRequest {
  late final Dio dio;

  HttpRequest({String? baseUrl})
      : dio = Dio(
    BaseOptions(
      baseUrl: baseUrl ?? 'http://127.0.0.1:8080/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  ) {
    dio.interceptors.add(AuthInterceptor());

    dio.interceptors.add(
      LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }

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

  }
}

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    // Теперь здесь используется переменная из GlobalStorage.dart
    final token = await flutterStorage.read(key: 'accessToken');

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {

    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {

      if (rootNavigatorKey.currentContext != null) {
        final context = rootNavigatorKey.currentContext!;

        context.go('/login');
      }

      return handler.next(err);
    }

    if (err.response?.statusCode == 500) {
      if (rootNavigatorKey.currentContext != null) {
        final context = rootNavigatorKey.currentContext!;

        context.go('/oops');
      }

      return handler.next(err);
    }

    super.onError(err, handler);
  }
}