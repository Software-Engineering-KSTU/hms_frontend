import 'package:hmsweb/base/BaseScreenModel.dart';

class MyAppointmentUI {
  final DateTime dateTime;
  final String doctor;

  MyAppointmentUI({
    required this.dateTime,
    required this.doctor,
  });
}

class MyAppointmentsModel extends BaseScreenModel {
  final List<MyAppointmentUI> appointments = [
    MyAppointmentUI(
      dateTime: DateTime(2024, 5, 25, 14, 30),
      doctor: "Иванов И.И.",
    ),
  ];

  @override
  Future<void> onInitialization() async {}
}
