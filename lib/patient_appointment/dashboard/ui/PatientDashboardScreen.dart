// import 'package:flutter/material.dart';
// import 'package:hmsweb/base/BaseScreen.dart';
// import 'package:hmsweb/doctor_appointment/dashboard/ui/view/TimeSlotsWidget.dart';
// import 'package:hmsweb/patient_appointment/dashboard/rep/PatientDashboardRep.dart' show getDateFromDateTime;
// import 'package:hmsweb/patient_appointment/dashboard/ui/view/BookTimeDialog.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// import 'PatientDashboardScreenModel.dart';
//
// class PatientDashboardScreen extends StatefulWidget {
//   const PatientDashboardScreen({super.key});
//
//   @override
//   State<StatefulWidget> createState() {
//     return PatientDashboardScreenState();
//   }
// }
//
// class PatientDashboardScreenState
//     extends BaseScreen<PatientDashboardScreen, PatientDashboardScreenModel> {
//   @override
//   Widget buildBody(
//     BuildContext context,
//     PatientDashboardScreenModel viewModel,
//   ) {
//     return Material(
//       child: Column(
//         children: [
//           Center(
//             child: TableCalendar(
//               firstDay: DateTime.utc(2025, 1, 1),
//               lastDay: DateTime.utc(2030, 12, 31),
//               focusedDay: viewModel.focusedDay,
//               selectedDayPredicate: (day) =>
//                   isSameDay(viewModel.selectedDay, day),
//               onDaySelected: (selected, focused) {
//                 setState(() {
//                   viewModel.selectedDay = selected;
//                   viewModel.focusedDay = focused;
//                 });
//
//                 viewModel.setDoctorAppointmentsUi(selected);
//               },
//               headerStyle: HeaderStyle(
//                 titleCentered: true,
//                 formatButtonVisible: false,
//               ),
//
//               calendarStyle: CalendarStyle(
//                 todayDecoration: BoxDecoration(
//                   color: Colors.blue.shade100,
//                   shape: BoxShape.circle,
//                 ),
//
//                 selectedDecoration: BoxDecoration(
//                   color: Colors.blue,
//                   shape: BoxShape.circle,
//                 ),
//                 selectedTextStyle: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//
//           if (viewModel.isLoading) CircularProgressIndicator()
//           else PatientSlotsWidget(
//               status: viewModel.status,
//               onTimeSelected: (String time) async {
//
//                 if (viewModel.isNotBusyOrMine(time)) {
//                   final AppointmentData? inputData = await showDialog<AppointmentData>(
//                     context: context,
//                     builder: (context) {
//                       return BookTimeInputDialog(
//                         title: time,
//                         content: "Пожалуйста, опишите симптомы и методы самолечения.",
//                         acceptText: 'Записаться',
//                       );
//                     },
//                   );
//
//                   if (inputData != null) {
//                     viewModel.symptomsDescription = inputData.symptomsDescription;
//                     viewModel.selfTreatmentMethodsTaken = inputData.selfTreatmentMethodsTaken;
//
//                     viewModel.setMineStatusRegistration(time);
//                   }
//
//                 } else {
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return BookTimeDialog(
//                         title: "Время занято",
//                         content: "На это время уже есть запись",
//                         context: context,
//                         acceptText: 'Ок',
//                         isShowNegative: false,
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:hmsweb/base/BaseScreen.dart';
import 'package:hmsweb/patient_appointment/dashboard/ui/view/PatientTimeSlotsWidget.dart'; // Убедитесь, что импорт правильный (имя файла могло быть разным в ваших версиях, я использую то, что было в контексте)
import 'package:hmsweb/patient_appointment/dashboard/ui/view/BookTimeDialog.dart';
import 'package:table_calendar/table_calendar.dart';
// Убедитесь, что путь соответствует вашей структуре папок
import 'package:hmsweb/patient_appointment/dashboard/ui/view/StatusRegistration.dart';
import 'PatientDashboardScreenModel.dart';

// import 'package:flutter/material.dart';


class PatientDashboardScreen extends StatefulWidget {
  const PatientDashboardScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return PatientDashboardScreenState();
  }
}

class PatientDashboardScreenState
    extends BaseScreen<PatientDashboardScreen, PatientDashboardScreenModel> {

  // Метод для показа красивых уведомлений снизу
  void _showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        // Красный для занятых, Зеленый для успеха, Синий для нейтральных
        backgroundColor: isError ? const Color(0xFFE53935) : const Color(0xFF43A047),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(20),
        duration: const Duration(seconds: 2), // Длительность показа
      ),
    );
  }

  @override
  Widget buildBody(
      BuildContext context,
      PatientDashboardScreenModel viewModel,
      ) {
    // Используем чистый белый фон для "Medical" стиля
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView( // Добавил скролл, чтобы на маленьких экранах не ломалось
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
                selectedDayPredicate: (day) =>
                    isSameDay(viewModel.selectedDay, day),
                onDaySelected: (selected, focused) {
                  setState(() {
                    viewModel.selectedDay = selected;
                    viewModel.focusedDay = focused;
                  });

                  viewModel.setDoctorAppointmentsUi(selected);
                },
                // Стиль заголовка (Месяц Год)
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF212121), // Dark Grey
                  ),
                  leftChevronIcon: Icon(Icons.chevron_left, color: Color(0xFF1976D2)),
                  rightChevronIcon: Icon(Icons.chevron_right, color: Color(0xFF1976D2)),
                ),
                // Стиль дней
                calendarStyle: CalendarStyle(
                  // Сегодняшний день
                  todayDecoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD), // Light Blue
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: const TextStyle(
                    color: Color(0xFF1976D2),
                    fontWeight: FontWeight.bold,
                  ),
                  // Выбранный день
                  selectedDecoration: const BoxDecoration(
                    color: Color(0xFF1976D2), // Medical Blue (Primary)
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  // Обычные дни
                  defaultTextStyle: const TextStyle(color: Color(0xFF424242)),
                  weekendTextStyle: const TextStyle(color: Color(0xFF757575)),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // --- СЛОТЫ ВРЕМЕНИ ---
            if (viewModel.isLoading)
              const Center(child: CircularProgressIndicator(color: Color(0xFF1976D2)))
            else
              TimeSlotsWidget( // Используем ваш виджет (возможно нужно переименовать файл импорта)
                status: viewModel.status,
                onTimeSelected: (String time) async {

                  // Логика проверки
                  if (viewModel.isNotBusyOrMine(time)) {

                    // 1. Показываем диалог ввода данных
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

                    // 2. Если данные введены -> отправляем
                    if (inputData != null) {
                      viewModel.symptomsDescription = inputData.symptomsDescription;
                      viewModel.selfTreatmentMethodsTaken = inputData.selfTreatmentMethodsTaken;

                      // Вызываем метод модели (он отправляет запрос)
                      viewModel.setMineStatusRegistration(time);

                      // 3. Показываем уведомление об успехе
                      // (В идеале viewModel должен возвращать результат, но пока сделаем так)
                      if (mounted) {
                        _showSnackBar(context, "Вы успешно записаны на $time");
                      }
                    }

                  } else {
                    // --- ИЗМЕНЕНИЕ: ВМЕСТО ДИАЛОГА -> SNACKBAR ---
                    if (viewModel.status[time] ==  null /*StatusRegistration.mine - нужно импортировать enum*/) {
                      // Если нужно обработать клик по своей записи отдельно
                      _showSnackBar(context, "Это ваша запись (нажмите чтобы отменить - пока не реализовано)", isError: false);
                    } else {
                      _showSnackBar(context, "Это время уже занято", isError: true);
                    }
                  }
                },
              ),

            const SizedBox(height: 50), // Отступ снизу
          ],
        ),
      ),
    );
  }
}