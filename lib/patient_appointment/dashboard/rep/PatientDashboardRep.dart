import 'package:hmsweb/doctor_appointment/dashboard/ui/view/StatusRegistration.dart';
import 'package:hmsweb/patient_appointment/dashboard/api/PatientDashboardApi.dart';
import 'package:hmsweb/patient_appointment/dashboard/dto/DoctorInfoDto.dart';
import 'package:hmsweb/patient_appointment/dashboard/dto/PatientAppointmentDoctorDto.dart'
    show PatientAppointmentDoctorDto;

class PatientDashboardRep {
  final _api = PatientDashboardApi();

  Future<Map<String, StatusRegistration>> getDoctorAppointments({
    required String doctorId,
    required String date,
  }) async {
    final response = await _api.fetchDoctorAppointments(
      doctorId: doctorId,
      date: date,
    );

    final List<Map<String, dynamic>> jsonList = (response.data as List<dynamic>)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    final Map<String, StatusRegistration> result = {};

    for (var element in jsonList) {
      StatusRegistration status;
      if (element['busyStatus'] == 'other') {
        status = StatusRegistration.busy;
      } else if (element['busyStatus'] == 'mine') {
        status = StatusRegistration.mine;
      } else {
        status = StatusRegistration.free;
      }

      final String timeKey = getTime(element['dateTime']);

      result[timeKey] = status;
    }

    return result;
  }

  Future<bool> postPatientAppointment(
    PatientAppointmentDoctorDto patientAppointment,
  ) async {
    final patientAppointmentWithFormat = PatientAppointmentDoctorDto(
      doctorId: patientAppointment.doctorId,
      date: patientAppointment.date,
      symptomsDescription: patientAppointment.symptomsDescription,
      selfTreatmentMethodsTaken: patientAppointment.selfTreatmentMethodsTaken,
    );

    try {
      final response = await _api.postPatientAppointment(
        patientAppointmentWithFormat,
      );

      if (response.statusCode != null &&
          (response.statusCode! >= 200 && response.statusCode! < 300)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Ошибка при записи на прием: $e');
      return false;
    }
  }

  Future<List<DoctorInfoDto>> fetchDoctors() async {
    final response = await _api.fetchDoctors();

    final List<dynamic> jsonList = response.data;

    return jsonList
        .map((e) => DoctorInfoDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

String getTime(String iso) {
  DateTime dt = DateTime.parse(iso);

  String time =
      "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";

  return time;
}

String getDateBackendFormat({
  required DateTime dataTime,
  required String time,
}) {
  int hour = int.parse(time.split(":")[0]);
  int minute = int.parse(time.split(":")[1]);

  DateTime result = DateTime(
    dataTime.year,
    dataTime.month,
    dataTime.day,
    hour,
    minute,
  );

  String iso = "${result.toIso8601String()}Z";

  return iso;
}

String getDateFromBaseDateTime(DateTime dateTime) {
  final year = dateTime.year.toString();
  final month = dateTime.month.toString().padLeft(2, '0');
  final day = dateTime.day.toString().padLeft(2, '0');

  return '$year-$month-$day';
}
