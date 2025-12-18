import 'package:hmsweb/patient_appointment/dashboard/ui/view/StatusRegistration.dart';
import 'package:hmsweb/patient_appointment/dashboard/api/PatientDashboardApi.dart';
import 'package:hmsweb/patient_appointment/dashboard/dto/DoctorInfoDto.dart';
import 'package:intl/intl.dart';
import 'package:hmsweb/patient_appointment/dashboard/dto/PatientAppointmentDoctorDto.dart'
    show PatientAppointmentDoctorDto;

class PatientDashboardRep {
  final _api = PatientDashboardApi();

  Future<Map<String, StatusRegistration>> getDoctorAppointments({
    required String doctorId,
    required String date,
  }) async {
    try {
      final response = await _api.fetchDoctorAppointments(
        doctorId: doctorId,
        date: date,
      );

      if (response.data == null || response.data is! List) {
        print('Error: Response data is not a List');
        return {};
      }

      final List<dynamic> jsonList = response.data;
      final Map<String, StatusRegistration> result = {};

      for (var element in jsonList) {
        if (element is! Map<String, dynamic>) continue;

        if (element['dateTime'] == null) {
          print('Warning: Skipping appointment with null dateTime (ID: ${element['id']})');
          continue;
        }

        try {
          StatusRegistration status;
          final busyStatus = element['busyStatus'] as String?;

          if (busyStatus == 'other') {
            status = StatusRegistration.busy;
          } else if (busyStatus == 'mine') {
            status = StatusRegistration.mine;
          } else {
            status = StatusRegistration.free;
          }

          final String timeKey = getTime(element['dateTime']);

          result[timeKey] = status;
        } catch (e) {
          print('Error parsing appointment item: $e');
        }
      }

      return result;
    } catch (e) {
      print('Global error fetching appointments: $e');
      return {};
    }
  }

  Future<bool> postPatientAppointment(
      PatientAppointmentDoctorDto patientAppointment,
      ) async {
    try {
      // 1. Реально вызываем API
      final response = await _api.postPatientAppointment(patientAppointment);

      // 2. Проверяем статус ответа (200 OK)
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        print('Error posting appointment: Status ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error posting appointment: $e');
      return false;
    }
  }

  Future<List<DoctorInfoDto>> fetchDoctors() async {
    try {
      final response = await _api.fetchDoctors();

      if (response.data == null || response.data is! List) {
        return [];
      }

      final List<dynamic> jsonList = response.data;
      final List<DoctorInfoDto> validDoctors = [];

      for (var e in jsonList) {
        try {
          if (e is Map<String, dynamic>) {
            validDoctors.add(DoctorInfoDto.fromJson(e));
          }
        } catch (error) {
          print('Skipping invalid doctor data: $error');
        }
      }

      return validDoctors;
    } catch (e) {
      print('Error fetching doctors: $e');
      return [];
    }
  }
}

String getTime(String iso) {
  DateTime dt = DateTime.parse(iso);
  String time =
      "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
  return time;
}

String getDate({required DateTime dataTime}) {
  DateTime result = DateTime(dataTime.year, dataTime.month, dataTime.day);
  final formatted = DateFormat('yyyy-MM-dd').format(result);
  return formatted;
}

String getDateFromDateTime(DateTime dateTime) {
  final year = dateTime.year.toString();
  final month = dateTime.month.toString().padLeft(2, '0');
  final day = dateTime.day.toString().padLeft(2, '0');
  return '$year-$month-$day';
}