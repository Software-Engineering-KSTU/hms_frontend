import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // Обязательно для compute
import '../../http/HttpRequest.dart';
import '../dto/UserDto.dart';
import '../dto/DoctorRequestDto.dart';
import '../../auth/dto/AuthDto.dart';

// --- ФУНКЦИЯ-ПАРСЕР (Должна быть вне класса) ---
// Это работает в отдельном изоляте и не тормозит UI
List<UserDto> _parseUsers(List<dynamic> data) {
  return data.map((json) => UserDto.fromJson(json)).toList();
}

class AdminUserApi extends HttpRequest {

  Future<List<UserDto>> getAllUsers() async {
    try {
      final response = await dioHttpRequest.get('/api/users');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        // ИСПОЛЬЗУЕМ COMPUTE ДЛЯ ПАРСИНГА
        // Это уберет фризы при загрузке списка
        return await compute(_parseUsers, data);

      } else {
        throw Exception('Failed to load users');
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<AuthDto> registerDoctor(DoctorRequestDto dto) async {
    try {
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
      await dioHttpRequest.delete('/api/admin/users/$userId');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }
}