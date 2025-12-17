import '../api/AdminUserApi.dart';
import '../dto/UserDto.dart';
import '../dto/DoctorRequestDto.dart';
import '../../auth/dto/AuthDto.dart';

class UserRepository {
  final AdminUserApi _api = AdminUserApi();

  /// Получить всех пользователей
  Future<List<UserDto>> fetchAllUsers() async {
    try {
      return await _api.getAllUsers();
    } catch (e) {
      // Здесь можно логировать ошибку или обрабатывать специфичные исключения
      rethrow;
    }
  }

  /// Зарегистрировать врача
  Future<AuthDto> registerDoctor(DoctorRequestDto dto) async {
    try {
      return await _api.registerDoctor(dto);
    } catch (e) {
      rethrow;
    }
  }
}