import 'package:hmsweb/auth/api/AuthApi.dart';
import 'package:hmsweb/auth/dto/AuthDto.dart';
import 'package:dio/dio.dart';
import 'package:hmsweb/http/HttpRequest.dart';

class AuthRep {
  final _api = AuthApi();

  Future<AuthDto> patientRegister({
    required String username,
    required String email,
    required String password,
    required String phoneNumber,
    required String address,
    required String dateOfBirth,
  }) async {

    try {
      final response = await _api.patientRegister(
        username: username,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        address: address,
        dateOfBirth: dateOfBirth,
      );

      final data = response.data as Map<String, dynamic>;
      final authDto = AuthDto.fromJson(data);

      await _saveTokens(authDto);
      return authDto;

    } on DioException catch (e) {
      print("SERVER ERROR → ${e.response?.data}");
      print("STATUS CODE → ${e.response?.statusCode}");
      print("DIO MESSAGE → ${e.message}");
      rethrow;
    }
  }

  Future<AuthDto> login({
    required String username,
    required String password,
  }) async {

    try {
      final response = await _api.login(username: username, password: password);

      final data = response.data as Map<String, dynamic>;
      final authDto = AuthDto.fromJson(data);

      await _saveTokens(authDto);
      return authDto;

    } on DioException catch (e) {
      print("SERVER ERROR → ${e.response?.data}");
      print("STATUS CODE → ${e.response?.statusCode}");
      rethrow;
    }
  }

  Future<AuthDto> refreshToken() async {
    final refreshToken = await flutterStorage.read(key: 'refreshToken');
    if (refreshToken == null) throw Exception('Нет токена обновления');

    try {
      final response = await _api.refreshToken(refreshToken);

      print("REFRESH RESPONSE → ${response.data}");

      final data = response.data as Map<String, dynamic>;
      final authDto = AuthDto.fromJson(data);

      await _saveTokens(authDto);
      return authDto;

    } on DioException catch (e) {
      print("REFRESH ERROR → ${e.response?.data}");
      print("STATUS CODE → ${e.response?.statusCode}");
      rethrow;
    }
  }

  Future<void> _saveTokens(AuthDto authDto) async {
    await flutterStorage.write(key: 'accessToken', value: authDto.accessToken);
    await flutterStorage.write(key: 'refreshToken', value: authDto.refreshToken);
  }
}
