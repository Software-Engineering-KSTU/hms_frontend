import 'package:hmsweb/base/BaseScreenModel.dart';
import 'package:hmsweb/patient_appointment/dashboard/dto/DoctorInfoDto.dart';
import '../../rep/PatientDashboardRep.dart';

class DoctorListScreenModel extends BaseScreenModel {

  final _rep = PatientDashboardRep();
  final List<DoctorInfoDto> doctors = [];

  // --- ВАЖНО: Запускаем загрузку сразу при создании модели ---
  DoctorListScreenModel() {
    _loadDoctors();
  }

  @override
  Future<void> onInitialization() async {
    // Можно оставить пустым, так как загрузка уже пошла в конструкторе
  }

  Future<void> _loadDoctors() async {
    isLoading = true;
    notifyListeners(); // Сообщаем UI: "Покажи загрузку"

    try {
      doctors.clear();
      final loadedDoctors = await _rep.fetchDoctors();
      doctors.addAll(loadedDoctors);
    } catch (e) {
      print("Ошибка в модели при загрузке врачей: $e");
    } finally {
      isLoading = false;
      notifyListeners(); // Сообщаем UI: "Данные готовы, покажи список"
    }
  }
}