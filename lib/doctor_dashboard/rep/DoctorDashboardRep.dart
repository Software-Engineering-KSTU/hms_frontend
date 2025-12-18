import 'package:hmsweb/doctor_dashboard/api/DoctorDashboardApi.dart';
import 'package:hmsweb/doctor_dashboard/dto/DoctorAppointmentDto.dart';
import 'package:hmsweb/doctor_dashboard/dto/VisitDto.dart'; // Не забудьте импорт

class DoctorDashboardRep {
  final _api = DoctorDashboardApi();

  // ... (Ваш старый метод getDailyAppointments оставляем без изменений) ...
  Future<Map<String, DoctorAppointmentDto>> getDailyAppointments(String date) async {
    // ... ваш существующий код ...
    final response = await _api.fetchAppointmentsByDate(date);
    if (response.data == null) return {};

    final List<dynamic> jsonList = response.data;
    final List<DoctorAppointmentDto> appointments = jsonList
        .map((e) => DoctorAppointmentDto.fromJson(e as Map<String, dynamic>))
        .toList();

    final Map<String, DoctorAppointmentDto> result = {};
    for (var appointment in appointments) {
      final String timeKey = getTime(appointment.dateTime);
      result[timeKey] = appointment;
    }
    return result;
  }

  // --- НОВЫЕ МЕТОДЫ ---

  /// Создать запись приема (назначить лечение)
  Future<VisitDto?> createVisit(VisitDto dto) async {
    try {
      final response = await _api.createVisit(dto.toJson());
      if (response.statusCode == 200) {
        return VisitDto.fromJson(response.data);
      }
    } catch (e) {
      print("Ошибка при создании приема: $e");
    }
    return null;
  }

  /// Обновить запись приема
  Future<VisitDto?> updateVisit(int id, VisitDto dto) async {
    try {
      final response = await _api.updateVisit(id, dto.toJson());
      if (response.statusCode == 200) {
        return VisitDto.fromJson(response.data);
      }
    } catch (e) {
      print("Ошибка при обновлении приема: $e");
    }
    return null;
  }

  // Вспомогательный метод (уже был у вас)
  String getTime(String iso) {
    try {
      DateTime dt = DateTime.parse(iso);
      return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
    } catch (e) {
      return "00:00";
    }
  }
}