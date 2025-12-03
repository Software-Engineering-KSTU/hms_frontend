import 'package:dio/dio.dart';  // Если используете dio, как в HomeApi
import 'package:hmsweb/http/HttpRequest.dart';

class AuthApi extends HttpRequest {

  Future<Response> patientRegister({
    required String username,
    required String email,
    required String password,
    required String phoneNumber,
    required String address,
    required String dateOfBirth,
  }) async {

    return await dioHttpRequest.post('api/auth/patient-register', data: {
      'username': username,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'address': address,
      'dateOfBirth': dateOfBirth,
    });
  }

  Future<Response> login({
    required String username,
    required String password,
  }) async {
    return await dioHttpRequest.post(
      'api/auth/login',
      data: {
        'username': username,
        'password': password
      },
    );
  }

  Future<Response> refreshToken(String refreshToken) async {
    return await postRequest('api/auth/refresh-token', headers: {
      'Authorization': 'Bearer $refreshToken',
    });
  }
}
