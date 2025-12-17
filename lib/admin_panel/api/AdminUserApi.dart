import 'package:dio/dio.dart';
import '../../http/HttpRequest.dart';
import '../dto/UserDto.dart';
import '../dto/DoctorRequestDto.dart';
// Импортируем AuthDto, так как регистрация возвращает ответ авторизации
import '../../auth/dto/AuthDto.dart';

class AdminUserApi extends HttpRequest {

  /// Получение списка всех пользователей
  /// GET /api/users
  Future<List<UserDto>> getAllUsers() async {
    try {
      // Наследуемся от HttpRequest, поэтому используем dioHttpRequest
      final response = await dioHttpRequest.get('/api/users');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => UserDto.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } on DioException catch (e) {
      // Здесь можно добавить более детальную обработку ошибок
      throw Exception(e.message);
    }
  }

  /// Регистрация нового доктора
  /// POST /api/auth/doctor-register
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
}