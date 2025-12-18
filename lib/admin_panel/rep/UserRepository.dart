import 'package:hmsweb/admin_panel/api/AdminDoctorApi.dart';
import 'package:hmsweb/admin_panel/api/AdminUserApi.dart';

import '../dto/UserDto.dart';
import '../dto/DoctorRequestDto.dart';
import '../../auth/dto/AuthDto.dart';

class UserRepository {
  final AdminUserApi _api = AdminUserApi();

  Future<List<UserDto>> fetchAllUsers() async {
    try {
      return await _api.getAllUsers();
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthDto> registerDoctor(DoctorRequestDto dto) async {
    try {
      return await _api.registerDoctor(dto);
    } catch (e) {
      rethrow;
    }
  }

  // --- ДОБАВЛЕННЫЙ МЕТОД ---
  Future<void> deleteUser(int userId) async {
    try {
      // Вам нужно будет добавить метод deleteUser в AdminUserApi.dart
      // который делает DELETE запрос на /admin/users/{id}
      await _api.deleteUser(userId);
    } catch (e) {
      rethrow;
    }
  }
}