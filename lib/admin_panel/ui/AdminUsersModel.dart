import 'package:hmsweb/base/BaseScreenModel.dart'; // <--- Обязательно этот импорт
import '../dto/UserDto.dart';
import '../rep/UserRepository.dart';

// Наследуемся от BaseScreenModel, а не от ChangeNotifier
class AdminUsersModel extends BaseScreenModel {
  final UserRepository _repository = UserRepository();

  List<UserDto> users = [];

  // Переопределяем поле ошибки, чтобы мы могли писать в него (в BaseScreenModel оно только для чтения)
  @override
  String? errorMessage;

  // Этот метод обязателен для BaseScreenModel.
  // Он вызывается автоматически при открытии экрана.
  @override
  Future<void> onInitialization() async {
    await fetchUsers(isRefresh: false);
  }

  Future<void> fetchUsers({bool isRefresh = true}) async {
    // Если это ручное обновление (pull-to-refresh или кнопка), ставим загрузку вручную
    if (isRefresh) {
      isLoading = true; // Используем сеттер из BaseScreenModel
      errorMessage = null;
    }

    try {
      users = await _repository.fetchAllUsers();
    } catch (e) {
      errorMessage = "Ошибка загрузки: ${e.toString()}";

      // Если ошибка произошла при первичной инициализации, пробрасываем её,
      // чтобы BaseScreenModel перевел экран в состояние "Ошибка"
      if (!isRefresh) rethrow;
    } finally {
      if (isRefresh) {
        isLoading = false;
        notifyListeners();
      }
    }
  }
}