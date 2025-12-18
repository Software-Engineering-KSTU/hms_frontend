import 'package:flutter/material.dart';
import 'package:hmsweb/base/BaseScreen.dart';
import 'package:hmsweb/patient_appointment/dashboard/ui/view/PatientTimeSlotsWidget.dart';
import 'package:hmsweb/patient_appointment/dashboard/ui/view/BookTimeDialog.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hmsweb/patient_appointment/dashboard/ui/view/StatusRegistration.dart';
import 'PatientDashboardScreenModel.dart';

class PatientDashboardScreen extends StatefulWidget {
  // ДОБАВИЛИ: Принимаем ID врача при переходе на экран
  final String doctorId;

  const PatientDashboardScreen({
    super.key,
    required this.doctorId
  });

  @override
  State<StatefulWidget> createState() {
    return PatientDashboardScreenState();
  }
}

class PatientDashboardScreenState
    extends BaseScreen<PatientDashboardScreen, PatientDashboardScreenModel> {

  // --- ВАЖНО: СОЗДАЕМ МОДЕЛЬ ЗДЕСЬ ---
  // Если ваш BaseScreen требует метод createViewModel, он должен выглядеть так:
  @override
  PatientDashboardScreenModel createViewModel() {
    return PatientDashboardScreenModel(idDoctor: widget.doctorId);
  }
  // Если BaseScreen работает по-другому, убедитесь, что вы создаете
  // модель именно с widget.doctorId
  // -------------------------------------

  void _showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        backgroundColor: isError ? const Color(0xFFE53935) : const Color(0xFF43A047),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(20),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context, PatientDashboardScreenModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Запись к врачу", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- КАЛЕНДАРЬ ---
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: TableCalendar(
                firstDay: DateTime.utc(2025, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: viewModel.focusedDay,
                selectedDayPredicate: (day) => isSameDay(viewModel.selectedDay, day),
                onDaySelected: (selected, focused) {
                  // Обновляем календарь визуально
                  setState(() {
                    viewModel.focusedDay = focused;
                    viewModel.selectedDay = selected; // Важно обновить и здесь для UI
                  });
                  // Запрашиваем данные у модели
                  viewModel.setDoctorAppointmentsUi(selected);
                },
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  leftChevronIcon: Icon(Icons.chevron_left, color: Color(0xFF1976D2)),
                  rightChevronIcon: Icon(Icons.chevron_right, color: Color(0xFF1976D2)),
                ),
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(color: const Color(0xFFE3F2FD), shape: BoxShape.circle),
                  todayTextStyle: const TextStyle(color: Color(0xFF1976D2), fontWeight: FontWeight.bold),
                  selectedDecoration: const BoxDecoration(color: Color(0xFF1976D2), shape: BoxShape.circle),
                  selectedTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // --- ИНДИКАТОР ЗАГРУЗКИ ---
            if (viewModel.isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(color: Color(0xFF1976D2)),
                ),
              )
            // --- СЛОТЫ ---
            else
              TimeSlotsWidget(
                status: viewModel.status,
                onTimeSelected: (String time) async {
                  if (viewModel.isNotBusyOrMine(time)) {
                    final AppointmentData? inputData = await showDialog<AppointmentData>(
                      context: context,
                      builder: (context) {
                        return BookTimeInputDialog(
                          title: "Запись на $time",
                          content: "Опишите симптомы и методы самолечения.",
                          acceptText: 'Подтвердить запись',
                        );
                      },
                    );

                    if (inputData != null) {
                      viewModel.symptomsDescription = inputData.symptomsDescription;
                      viewModel.selfTreatmentMethodsTaken = inputData.selfTreatmentMethodsTaken;
                      await viewModel.setMineStatusRegistration(time);

                      if (mounted) {
                        _showSnackBar(context, "Вы успешно записаны на $time");
                      }
                    }
                  } else {
                    if (viewModel.status[time] == StatusRegistration.mine) {
                      _showSnackBar(context, "Это ваша запись", isError: false);
                    } else {
                      _showSnackBar(context, "Это время уже занято", isError: true);
                    }
                  }
                },
              ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}