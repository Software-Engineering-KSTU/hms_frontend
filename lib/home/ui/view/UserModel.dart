import 'package:hmsweb/base/BaseScreenModel.dart';
import '../../rep/user_repository.dart';
import '../../dto/user_dto.dart';

class UserModel extends BaseScreenModel {
  final _repository = UserRepository();

  UserDto? user;
  bool isLoading = false;
  String? error;

  @override
  Future<void> onInitialization() async {
    loadUser(1); // ID пользователя
  }

  Future<void> loadUser(int id) async {
    try {
      isLoading = true;
      notifyListeners();

      user = await _repository.getUser(id);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }
}
