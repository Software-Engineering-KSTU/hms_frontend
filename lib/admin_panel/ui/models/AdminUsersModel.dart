import 'package:hmsweb/base/BaseScreenModel.dart';
import 'package:hmsweb/admin_panel/dto/UserDto.dart';
import 'package:hmsweb/admin_panel/rep/UserRepository.dart';

class AdminUsersModel extends BaseScreenModel {
  final UserRepository _repository = UserRepository();

  List<UserDto> users = [];

  @override
  String? errorMessage;

  // --- ИСПРАВЛЕНИЕ: ЗАПУСКАЕМ ЗАГРУЗКУ В КОНСТРУКТОРЕ ---
  AdminUsersModel() {
    fetchUsers(isRefresh: true);
  }

  @override
  Future<void> onInitialization() async {
    // Этот метод оставим для совместимости, но основная работа теперь в конструкторе
    await fetchUsers(isRefresh: false);
  }

  Future<void> fetchUsers({bool isRefresh = true}) async {
    // Если мы уже грузим, не запускаем повторно (защита от двойных вызовов)
    if (isLoading) return;

    if (isRefresh) {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
    }

    try {
      users = await _repository.fetchAllUsers();

      // Сортировка
      users.sort((a, b) {
        if (a.role == 'ADMIN') return -1;
        if (b.role == 'ADMIN') return 1;
        if (a.role == 'DOCTOR') return -1;
        if (b.role == 'DOCTOR') return 1;
        return 0;
      });

    } catch (e) {
      errorMessage = "Ошибка загрузки: ${e.toString()}";
      // Очищаем список при ошибке, чтобы не показывать старые данные
      users = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteUser(int userId) async {
    isLoading = true;
    notifyListeners();

    try {
      await _repository.deleteUser(userId);
      users.removeWhere((u) => u.id == userId);
    } catch (e) {
      errorMessage = "Не удалось удалить пользователя: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}