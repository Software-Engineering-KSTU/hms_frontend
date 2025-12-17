import '../api/AdminDoctorApi.dart';
// Импортируем существующий DTO из модуля резюме
import '../../doctors_resume/dto/DoctorResumeDto.dart';

class DoctorRepository {
  final AdminDoctorApi _api = AdminDoctorApi();

  /// Получить резюме
  Future<DoctorResumeDto> getResume(int doctorId) async {
    try {
      return await _api.getResume(doctorId);
    } catch (e) {
      rethrow;
    }
  }

  /// Создать резюме
  Future<DoctorResumeDto> createResume(int doctorId, DoctorResumeDto dto) async {
    try {
      return await _api.createResume(doctorId, dto);
    } catch (e) {
      rethrow;
    }
  }

  /// Обновить резюме
  Future<DoctorResumeDto> updateResume(int doctorId, DoctorResumeDto dto) async {
    try {
      return await _api.updateResume(doctorId, dto);
    } catch (e) {
      rethrow;
    }
  }

  /// Загрузить фото
  Future<String> uploadPhoto(int doctorId, String filePath) async {
    try {
      return await _api.uploadPhoto(doctorId, filePath);
    } catch (e) {
      rethrow;
    }
  }

  /// Удалить фото
  Future<void> deletePhoto(int doctorId) async {
    try {
      await _api.deletePhoto(doctorId);
    } catch (e) {
      rethrow;
    }
  }
}