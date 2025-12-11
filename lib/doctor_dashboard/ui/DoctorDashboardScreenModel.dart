import 'package:hmsweb/base/BaseScreenModel.dart';
import 'package:hmsweb/doctor_dashboard/dto/DoctorAppointmentDto.dart';
import 'package:hmsweb/doctor_dashboard/rep/DoctorDashboardRep.dart';
import 'package:hmsweb/patient_appointment/dashboard/rep/PatientDashboardRep.dart' show getDateFromDateTime;

class DoctorDashboardScreenModel extends BaseScreenModel {
  final _rep = DoctorDashboardRep();

  // Храним записи: Ключ - время ("10:00"), Значение - данные записи
  final Map<String, DoctorAppointmentDto> appointments = {};

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay = DateTime.now();

  @override
  Future<void> onInitialization() async {
    await updateAppointmentsForDate(DateTime.now());
  }

  Future<void> updateAppointmentsForDate(DateTime date) async {
    isLoading = true;
    notifyListeners();

    try {
      final dateStr = getDateFromDateTime(date);
      final newAppointments = await _rep.getDailyAppointments(dateStr);

      appointments.clear();
      appointments.addAll(newAppointments);
    } catch (e) {
      print("Ошибка загрузки расписания врача: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  // Метод, вызываемый при смене дня в календаре
  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay = selected;
    focusedDay = focused;
    updateAppointmentsForDate(selected);
  }
}