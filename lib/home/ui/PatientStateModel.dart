import 'package:hmsweb/base/BaseScreenModel.dart';
import 'package:hmsweb/home/dto/patient_state_dto.dart';
import 'package:hmsweb/home/rep/user_repository.dart';
import 'package:hmsweb/home/dto/user_dto.dart';

class PatientStateModel extends BaseScreenModel {
  final _userRepository = UserRepository();
  final int _userId = 1; // ID пользователя из БД

  PatientStateDto? patient;
  UserDto? user;

  bool isLoading = false;
  String? error;

  @override
  Future<void> onInitialization() async {
    await load();
  }

  Future<void> load() async {
    try {
      isLoading = true;
      notifyListeners();

      // 1. Загружаем данные пользователя
      user = await _userRepository.getUser(_userId);

      // 2. Преобразуем UserDto -> временный PatientStateDto
      patient = PatientStateDto(
        id: user!.id.toString(),
        fullName: user!.username,
        age: 0,
        diagnosis: "Нет данных",
        ward: "-",
        status: "-",
        temperature: 0,
        pulse: 0,
        pressureSys: 0,
        pressureDia: 0,
        spo2: 0,
      );

      isLoading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }
}
