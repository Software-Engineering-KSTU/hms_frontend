import 'package:flutter/material.dart'; // Для SnackBar
import 'package:hmsweb/base/BaseScreenModel.dart';
import 'package:hmsweb/doctor_dashboard/dto/DoctorAppointmentDto.dart';
import 'package:hmsweb/doctor_dashboard/dto/VisitDto.dart';
import 'package:hmsweb/doctor_dashboard/rep/DoctorDashboardRep.dart';

class DoctorDashboardScreenModel extends BaseScreenModel {
  final _rep = DoctorDashboardRep();

  final Map<String, DoctorAppointmentDto> appointments = {};

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  final List<String> times = [
    "08:00", "08:20", "08:40", "09:00",
    "09:20", "09:40", "10:00", "10:20",
    "10:40", "11:00", "11:20", "11:40",
    "12:00", "12:20", "12:40", "13:00",
    "13:20", "13:40",
  ];

  DoctorDashboardScreenModel() {
    isLoading = true;
    _autoInit();
  }

  void _autoInit() async {
    await Future.delayed(Duration.zero);
    await onInitialization();
  }

  @override
  Future<void> onInitialization() async {
    final now = DateTime.now();
    selectedDay = now;
    await updateAppointmentsForDate(now);
  }

  Future<void> updateAppointmentsForDate(DateTime date) async {
    isLoading = true;
    notifyListeners();

    try {
      final dateStr = getDateFromDateTime(date);
      print("===> DOCTOR: Загрузка расписания на $dateStr");

      final newAppointments = await _rep.getDailyAppointments(dateStr);

      appointments.clear();
      appointments.addAll(newAppointments);
    } catch (e) {
      print("!!! Ошибка загрузки расписания: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // --- НОВЫЙ МЕТОД: Создание назначения ---
  Future<void> createVisit(BuildContext context, VisitDto visitDto) async {
    isLoading = true;
    notifyListeners();

    try {
      print("===> DOCTOR: Отправка назначения: ${visitDto.diagnosis}");
      final result = await _rep.createVisit(visitDto);

      if (result != null) {
        // Успех
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Назначение успешно сохранено!"), backgroundColor: Colors.green),
          );
        }
      } else {
        // Ошибка (репозиторий вернул null)
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Ошибка сохранения назначения"), backgroundColor: Colors.red),
          );
        }
      }
    } catch (e) {
      print("Error creating visit: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay = selected;
    focusedDay = focused;
    updateAppointmentsForDate(selected);
  }

  bool hasAppointment(String time) {
    return appointments.containsKey(time);
  }

  String getDateFromDateTime(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}