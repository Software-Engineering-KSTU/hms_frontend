import 'package:hmsweb/doctor_dashboard/api/DoctorDashboardApi.dart';
import 'package:hmsweb/doctor_dashboard/dto/DoctorAppointmentDto.dart';

class DoctorDashboardRep {
  final _api = DoctorDashboardApi();

  Future<Map<String, DoctorAppointmentDto>> getDailyAppointments(String date) async {
    final response = await _api.fetchAppointmentsByDate(date);

    // Проверка, что пришли данные, а не null (на всякий случай)
    if (response.data == null) {
      return {};
    }

    final List<dynamic> jsonList = response.data;

    // Преобразуем JSON в список DTO
    final List<DoctorAppointmentDto> appointments = jsonList
        .map((e) => DoctorAppointmentDto.fromJson(e as Map<String, dynamic>))
        .toList();

    final Map<String, DoctorAppointmentDto> result = {};

    for (var appointment in appointments) {
      // Парсим время из dateTime
      final String timeKey = getTime(appointment.dateTime);
      result[timeKey] = appointment;
    }

    return result;
  }

  String getTime(String iso) {
    try {
      DateTime dt = DateTime.parse(iso);
      String time = "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
      return time;
    } catch (e) {
      return "00:00"; // Fallback на случай ошибки парсинга
    }
  }
}