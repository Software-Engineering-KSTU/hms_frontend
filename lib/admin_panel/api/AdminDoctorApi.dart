import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // Для compute
import '../../http/HttpRequest.dart';
import '../../doctors_resume/dto/DoctorResumeDto.dart';

// --- ФУНКЦИЯ-ПАРСЕР ДЛЯ СПИСКА ВРАЧЕЙ ---
List<dynamic> _parseDoctorsRaw(dynamic data) {
  return data as List<dynamic>;
}

class AdminDoctorApi extends HttpRequest {

  Future<DoctorResumeDto> getResume(int doctorId) async {
    try {
      final response = await dioHttpRequest.get('/api/doctor-resume/$doctorId');
      // Одиночные объекты можно парсить в главном потоке, это быстро
      return DoctorResumeDto.fromJson(response.data);
    } on DioException catch (e) {
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

  // --- ОПТИМИЗИРОВАННЫЙ МЕТОД ---
  Future<List<dynamic>> getAllDoctorsRaw() async {
    try {
      final response = await dioHttpRequest.get('/api/appointments/doctors');
      // Переносим обработку в фон, чтобы не фризить UI при поиске ID
      return await compute(_parseDoctorsRaw, response.data);
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}