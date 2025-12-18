import 'package:flutter/material.dart';
import 'package:hmsweb/base/BaseScreen.dart';
import 'package:table_calendar/table_calendar.dart';

// Импорты ваших диалогов и модели
import 'package:hmsweb/doctor_dashboard/ui/view/PatientInfoDialog.dart';
import 'package:hmsweb/doctor_dashboard/ui/view/VisitCreationDialog.dart';
import 'package:hmsweb/doctor_dashboard/ui/DoctorDashboardScreenModel.dart';

class DoctorDashboardScreen extends StatefulWidget {
  const DoctorDashboardScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState
    extends BaseScreen<DoctorDashboardScreen, DoctorDashboardScreenModel> {

  @override
  DoctorDashboardScreenModel createViewModel() => DoctorDashboardScreenModel();

  @override
  Widget buildBody(BuildContext context, DoctorDashboardScreenModel viewModel) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Мое расписание", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. КАЛЕНДАРЬ ---
            _buildCalendar(viewModel),

            const SizedBox(height: 30),

            const Text(
              "Записи на день",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // --- 2. СЕТКА СЛОТОВ ---
            if (viewModel.isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: CircularProgressIndicator(color: Color(0xFF1976D2)),
                ),
              )
            else if (viewModel.times.isEmpty)
              const Text("Нет доступных слотов")
            else
              Wrap(
                spacing: 12,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: viewModel.times.map((time) {
                  return _buildTimeSlot(context, viewModel, time);
                }).toList(),
              ),

            const SizedBox(height: 30),

            // --- 3. ЛЕГЕНДА ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _legendItem(const Color(0xFF4CAF50), "Свободно"),
                const SizedBox(width: 20),
                _legendItem(const Color(0xFF1976D2), "Занято (Пациент)"),
              ],
            )
          ],
        ),
      ),
    );
  }

  // --- ЛОГИКА ОТРИСОВКИ СЛОТА ---
  Widget _buildTimeSlot(BuildContext context, DoctorDashboardScreenModel viewModel, String time) {
    // Проверяем, есть ли запись на это время
    final bool isBooked = viewModel.hasAppointment(time);

    // Выбираем цвет: Синий (занято) / Зеленый (свободно)
    final Color bgColor = isBooked ? const Color(0xFF1976D2) : const Color(0xFF4CAF50);

    return InkWell(
      onTap: () {
        if (isBooked) {
          // Получаем данные о записи
          final appointment = viewModel.appointments[time];
          if (appointment != null) {
            // Открываем диалог с инфо о пациенте
            showDialog(
              context: context,
              builder: (context) => PatientInfoDialog(
                appointment: appointment,
                // ЛОГИКА КНОПКИ "НАЗНАЧИТЬ":
                onPrescribe: () async {
                  // 1. Открываем форму ввода диагноза
                  final result = await showDialog(
                    context: context,
                    builder: (context) => VisitCreationDialog(
                      doctorId: 1,
                      patientId: appointment.patient.id,
                    ),
                  );

                  // 2. Если врач нажал "Сохранить", отправляем данные
                  if (result != null && context.mounted) {
                    await viewModel.createVisit(context, result);
                  }
                },
              ),
            );
          }
        } else {
          // Слот свободен
          print("Слот $time свободен");
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: bgColor.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          time,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // --- КАЛЕНДАРЬ ---
  Widget _buildCalendar(DoctorDashboardScreenModel viewModel) {
    return Container(
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
          setState(() {
            viewModel.focusedDay = focused;
            viewModel.selectedDay = selected;
          });
          viewModel.onDaySelected(selected, focused);
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
    );
  }

  // --- ЭЛЕМЕНТ ЛЕГЕНДЫ ---
  Widget _legendItem(Color color, String text) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}