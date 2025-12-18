import 'package:hmsweb/base/BaseScreenModel.dart';
import 'package:hmsweb/doctors_resume/dto/DoctorResumeDto.dart';
import 'package:hmsweb/admin_panel/rep/DoctorRepository.dart';

class AdminDoctorResumeModel extends BaseScreenModel {
  final int userId;

  // --- ИСПРАВЛЕНИЕ 1: Запускаем загрузку сразу при создании модели ---
  AdminDoctorResumeModel({required this.userId}) {
    fetchResume();
  }

  final DoctorRepository _repository = DoctorRepository();

  DoctorResumeDto? resume;
  int? doctorId;

  @override
  String? errorMessage;

  @override
  Future<void> onInitialization() async {
    // Можно оставить пустым или убрать, так как мы вызываем в конструкторе
  }

  Future<void> fetchResume() async {
    // Защита от повторного запуска
    if (isLoading) return;

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // --- ИСПРАВЛЕНИЕ 2: Ищем реальный ID врача (иначе будет 404) ---
      doctorId = await _repository.findDoctorIdByUserId(userId);

      if (doctorId == null) {
        // Если ID врача не найден, мы не можем создать резюме.
        // Но чтобы экран не завис, просто выключаем загрузку.
        // Кнопка создания не сработает (выдаст ошибку в UI), и это правильно.
        errorMessage = "Врач не найден в базе данных (User ID: $userId)";
        return;
      }

      // Пытаемся загрузить резюме
      resume = await _repository.getResume(doctorId!);

    } catch (e) {
      // Если ошибка 404 (резюме нет) - это нормально, оставляем null
      if (e.toString().contains("404") || e.toString().contains("not found")) {
        resume = null;
      } else {
        errorMessage = "Не удалось загрузить данные: $e";
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteResume() async {
    if (doctorId == null) return;

    isLoading = true;
    notifyListeners();

    try {
      await _repository.deleteResume(doctorId!);
      resume = null;
    } catch (e) {
      errorMessage = "Ошибка удаления: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}