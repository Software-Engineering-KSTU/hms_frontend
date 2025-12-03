import 'package:hmsweb/base/BaseScreenModel.dart';
import 'package:hmsweb/doctor_appointment/dashboard/ui/view/StatusRegistration.dart';
import 'package:hmsweb/patient_appointment/dashboard/rep/PatientDashboardRep.dart';

import '../dto/PatientAppointmentDoctorDto.dart';

class PatientDashboardScreenModel extends BaseScreenModel {
  PatientDashboardScreenModel({required this.idDoctor});

  final String idDoctor;
  String symptomsDescription = "";
  String selfTreatmentMethodsTaken = "";

  final _rep = PatientDashboardRep();

  final Map<String, StatusRegistration> status = {};

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  @override
  Future<void> onInitialization() async {
    final currentDate = DateTime.now();
    final date = getDateFromBaseDateTime(currentDate);

    final doctorAppointment = await _rep.getDoctorAppointments(
      doctorId: idDoctor,
      date: date,
    );

    status.addAll(doctorAppointment);
  }

  bool isNotBusyOrMine(String time) {
    if (status[time] == StatusRegistration.busy) return false;
    if (status[time] == StatusRegistration.mine) return false;

    return true;
  }

  void setMineStatusRegistration(String time) async {
    final patientAppointment = PatientAppointmentDoctorDto(
      doctorId: idDoctor,
      date: getDateBackendFormat(
        dataTime: selectedDay ?? DateTime.now(),
        time: time,
      ),
      symptomsDescription: symptomsDescription,
      selfTreatmentMethodsTaken: selfTreatmentMethodsTaken,
    );

    final result = await _rep.postPatientAppointment(patientAppointment);

    if (!result) return; //todo throw error

    if (!status.containsKey(time)) {
      status[time] = StatusRegistration.mine;
    }

    status[time] = StatusRegistration.mine;
    notifyListeners();
  }
}
