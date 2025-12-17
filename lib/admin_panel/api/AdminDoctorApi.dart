import 'package:dio/dio.dart';
import '../../http/HttpRequest.dart';
// Используем DTO из модуля резюме, чтобы не дублировать код,
// либо из admin_panel/dto, если вы решили его скопировать.
// Предполагаю, что мы переиспользуем существующий:
import '../../doctors_resume/dto/DoctorResumeDto.dart';

class AdminDoctorApi extends HttpRequest {

  /// Получить резюме врача по ID
  /// GET /api/doctor-resume/{doctorId}
  Future<DoctorResumeDto> getResume(int doctorId) async {
    try {
      final response = await dioHttpRequest.get('/api/doctor-resume/$doctorId');
      return DoctorResumeDto.fromJson(response.data);
    } on DioException catch (e) {
      // Если резюме нет (404), можно вернуть null или выбросить ошибку,
      // в зависимости от того, как хотите обрабатывать это в UI
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  /// Создать резюме для врача
  /// POST /api/doctor-resume?doctorId={id}
  /// Обратите внимание: в контроллере doctorId передается как @RequestParam
  Future<DoctorResumeDto> createResume(int doctorId, DoctorResumeDto dto) async {
    try {
      final response = await dioHttpRequest.post(
        '/api/doctor-resume',
        queryParameters: {'doctorId': doctorId},
        data: dto.toJson(),
      );
      return DoctorResumeDto.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  /// Обновить резюме врача
  /// PUT /api/doctor-resume/{doctorId}
  Future<DoctorResumeDto> updateResume(int doctorId, DoctorResumeDto dto) async {
    try {
      final response = await dioHttpRequest.put(
        '/api/doctor-resume/$doctorId',
        data: dto.toJson(),
      );
      return DoctorResumeDto.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  /// Загрузить фото врача
  /// POST /api/doctor-resume/{doctorId}/photo
  Future<String> uploadPhoto(int doctorId, String filePath) async {
    try {
      // Формируем Multipart запрос
      String fileName = filePath.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(filePath, filename: fileName),
      });

      final response = await dioHttpRequest.post(
        '/api/doctor-resume/$doctorId/photo',
        data: formData,
      );

      // Бэкенд возвращает String (URL)
      return response.data.toString();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  /// Удалить фото врача
  /// DELETE /api/doctor-resume/{doctorId}/photo
  Future<void> deletePhoto(int doctorId) async {
    try {
      await dioHttpRequest.delete('/api/doctor-resume/$doctorId/photo');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }
}