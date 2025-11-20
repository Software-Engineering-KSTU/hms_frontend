import '../dto/patient_state_dto.dart';

abstract class PatientStateRepository {
  Future<PatientStateDto> getPatientState(String patientId);
}

class MockPatientStateRepository implements PatientStateRepository {
  @override
  Future<PatientStateDto> getPatientState(String patientId) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return PatientStateDto.mock();
  }
}
