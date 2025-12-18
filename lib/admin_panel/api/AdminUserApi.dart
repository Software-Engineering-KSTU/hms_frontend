import 'package:dio/dio.dart';
import 'package:hmsweb/http/HttpRequest.dart';
import 'package:hmsweb/admin_panel/dto/UserDto.dart';
import 'package:hmsweb/admin_panel/dto/DoctorRequestDto.dart';
import 'package:hmsweb/auth/dto/AuthDto.dart';

class AdminUserApi extends HttpRequest {

  /// Получение списка всех пользователей
  Future<List<UserDto>> getAllUsers() async {
    try {
      // Вернули /api
      final response = await dioHttpRequest.get('/api/users');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => UserDto.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  /// Регистрация нового доктора
  Future<AuthDto> registerDoctor(DoctorRequestDto dto) async {
    try {
      // Вернули /api
      final response = await dioHttpRequest.post(
        '/api/auth/doctor-register',
        data: dto.toJson(),
      );

      if (response.statusCode == 200) {
        return AuthDto.fromJson(response.data);
      } else {
        throw Exception('Failed to register doctor');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  Future<void> deleteUser(int userId) async {
    try {
      // Вернули /api
      await dioHttpRequest.delete('/api/admin/users/$userId');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }
}