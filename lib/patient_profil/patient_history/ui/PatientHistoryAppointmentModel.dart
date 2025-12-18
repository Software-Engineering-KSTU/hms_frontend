import 'package:hmsweb/base/BaseScreenModel.dart';

/// ❗ UI-модель (заглушка)
/// ❗ Без логики, без API
class PatientHistoryAppointmentModel extends BaseScreenModel {
  final List<PatientAppointmentUI> appointments = [
    PatientAppointmentUI(
      dateTime: DateTime(2024, 5, 20, 14, 30),
      patientState: "Состояние стабильное",
      treatment: "Назначены обезболивающие препараты",
      doctorName: "Иванов Иван Иванович",
    ),
    PatientAppointmentUI(
      dateTime: DateTime(2024, 5, 18, 10, 0),
      patientState: "Жалобы на боль в спине",
      treatment: "Физиотерапия, массаж",
      doctorName: "Петрова Елена Сергеевна",
    ),
  ];

  @override
  Future<void> onInitialization() async {
    // ❗ Заглушка
    // В будущем здесь будет API
    return;
  }
}

/// UI-заглушка записи
class PatientAppointmentUI {
  final DateTime dateTime;
  final String patientState;
  final String treatment;
  final String doctorName;

  PatientAppointmentUI({
    required this.dateTime,
    required this.patientState,
    required this.treatment,
    required this.doctorName,
  });
}
