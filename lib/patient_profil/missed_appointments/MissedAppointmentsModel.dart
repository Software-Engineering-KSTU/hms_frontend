import 'package:hmsweb/base/BaseScreenModel.dart';

class MissedAppointmentUI {
  final DateTime dateTime;
  final String doctor;

  MissedAppointmentUI({
    required this.dateTime,
    required this.doctor,
  });
}

class MissedAppointmentsModel extends BaseScreenModel {
  final List<MissedAppointmentUI> missed = [
    MissedAppointmentUI(
      dateTime: DateTime(2024, 4, 10, 11, 0),
      doctor: "Петрова Е.С.",
    ),
  ];

  @override
  Future<void> onInitialization() async {}
}
