import 'package:hmsweb/base/BaseScreenModel.dart';
// import 'package:hmsweb/doctor_appointment/dashboard/ui/view/StatusRegistration.dart';
import 'package:hmsweb/patient_appointment/dashboard/ui/view/StatusRegistration.dart';

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
    final date = getDateFromDateTime(currentDate);

    status.addAll(await setDoctorAppointments(idDoctor, date));
  }

  Future<Map<String, StatusRegistration>> setDoctorAppointments(
    String doctorId,
    String date,
  ) async {
    return _rep.getDoctorAppointments(doctorId: doctorId, date: date);
  }

  void fillAllWithBusyStatus() {

    final List<String> times = [
      "08:00",
      "08:20",
      "08:40",
      "09:00",
      "09:20",
      "09:40",
      "10:00",
      "10:20",
      "10:40",
      "11:00",
      "11:20",
      "11:40",
      "12:00",
      "12:20",
      "12:40",
      "13:00",
      "13:20",
      "13:40",
    ];

    for (var time in times) {
      status[time] = StatusRegistration.busy;
    }

  }

  Future<void> setDoctorAppointmentsUi(DateTime currentDate) async {
    isLoading = true;

    if(currentDate.isBefore(DateTime.now())) {
      fillAllWithBusyStatus();
    } else {
      status.clear();
      status.addAll(
        await setDoctorAppointments(idDoctor, getDateFromDateTime(currentDate)),
      );
    }

    isLoading = false;
    notifyListeners();
  }

  bool isNotBusyOrMine(String time) {
    if (status[time] == StatusRegistration.busy) return false;
    if (status[time] == StatusRegistration.mine) return false;

    return true;
  }

  void setMineStatusRegistration(String time) async {
    final patientAppointment = PatientAppointmentDoctorDto(
      doctorId: idDoctor,
      date: getDate(dataTime: selectedDay ?? DateTime.now()),
      time: time,
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
