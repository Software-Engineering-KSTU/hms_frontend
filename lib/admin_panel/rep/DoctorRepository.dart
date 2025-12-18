import 'package:hmsweb/admin_panel/api/AdminDoctorApi.dart';
import 'package:hmsweb/doctors_resume/dto/DoctorResumeDto.dart';

class DoctorRepository {
  final AdminDoctorApi _api = AdminDoctorApi();

  Future<DoctorResumeDto> getResume(int doctorId) async {
    try {
      return await _api.getResume(doctorId);
    } catch (e) {
      rethrow;
    }
  }

  Future<DoctorResumeDto> createResume(int doctorId, DoctorResumeDto dto) async {
    try {
      return await _api.createResume(doctorId, dto);
    } catch (e) {
      rethrow;
    }
  }

  Future<DoctorResumeDto> updateResume(int doctorId, DoctorResumeDto dto) async {
    try {
      return await _api.updateResume(doctorId, dto);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadPhoto(int doctorId, String filePath) async {
    try {
      return await _api.uploadPhoto(doctorId, filePath);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePhoto(int doctorId) async {
    try {
      await _api.deletePhoto(doctorId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteResume(int doctorId) async {
    try {
      await _api.deleteResume(doctorId);
    } catch (e) {
      rethrow;
    }
  }

  // --- ИСПРАВЛЕННЫЙ МЕТОД ПОИСКА ---
  Future<int?> findDoctorIdByUserId(int userId) async {
    try {
      // 1. Получаем список всех врачей
      final doctorsList = await _api.getAllDoctorsRaw();

      // 2. Ищем совпадение по User ID внутри JSON
      // Ожидаем структуру: { "id": 5, "user": { "id": 105, ... } }
      for (var doc in doctorsList) {
        if (doc is Map<String, dynamic>) {
          // Вариант 1: Вложенный объект user
          final userObj = doc['user'];
          if (userObj != null && userObj is Map && userObj['id'] == userId) {
            return doc['id'] as int;
          }

          // Вариант 2: Плоский JSON (если userId прямо в корне)
          if (doc['userId'] == userId) {
            return doc['id'] as int;
          }
        }
      }
      return null; // Врач не найден
    } catch (e) {
      print("Ошибка поиска ID врача: $e");
      return null;
    }
  }
}