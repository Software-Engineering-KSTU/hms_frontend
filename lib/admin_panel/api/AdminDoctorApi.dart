import 'package:dio/dio.dart';
import '../../http/HttpRequest.dart';
// Используем DTO из модуля резюме
import '../../doctors_resume/dto/DoctorResumeDto.dart';

class AdminDoctorApi extends HttpRequest {

  Future<DoctorResumeDto> getResume(int doctorId) async {
    try {
      final response = await dioHttpRequest.get('/api/doctor-resume/$doctorId');
      return DoctorResumeDto.fromJson(response.data);
    } on DioException catch (e) {
      // Если резюме нет (404), пробрасываем ошибку, модель её обработает
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }


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


  Future<String> uploadPhoto(int doctorId, String filePath) async {
    try {
      String fileName = filePath.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(filePath, filename: fileName),
      });

      final response = await dioHttpRequest.post(
        '/api/doctor-resume/$doctorId/photo',
        data: formData,
      );

      return response.data.toString();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }


  Future<void> deletePhoto(int doctorId) async {
    try {
      await dioHttpRequest.delete('/api/doctor-resume/$doctorId/photo');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }


  Future<void> deleteResume(int doctorId) async {
    try {
      await dioHttpRequest.delete('/api/doctor-resume/$doctorId');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }


  Future<List<dynamic>> getAllDoctorsRaw() async {
    try {
      final response = await dioHttpRequest.get('/api/appointments/doctors');
      return response.data as List<dynamic>;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}