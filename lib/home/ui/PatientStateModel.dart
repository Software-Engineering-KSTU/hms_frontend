import 'package:hmsweb/base/BaseScreenModel.dart';
import 'package:hmsweb/home/dto/patient_state_dto.dart';
import 'package:hmsweb/home/rep/patient_state_repository.dart';

class PatientStateModel extends BaseScreenModel {
  @override
  Future<void> onInitialization() async {
    await load();
  }

  final PatientStateRepository _repository;
  final String _patientId;

  PatientStateModel()
      : _repository = MockPatientStateRepository(),
        _patientId = '001';//НАВРЕМЯ

  PatientStateDto? patient;
  String? error;
  bool isLoading = false;

  Future<void> load() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      patient = await _repository.getPatientState(_patientId);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
    }
  }
}
