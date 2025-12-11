import 'package:flutter/material.dart';
import 'package:hmsweb/doctor_dashboard/dto/DoctorAppointmentDto.dart';

class PatientInfoDialog extends StatelessWidget {
  final DoctorAppointmentDto appointment;

  const PatientInfoDialog({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Пациент: ${appointment.patient.username}"),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _infoRow("Телефон:", appointment.patient.phoneNumber),
            const Divider(),
            _infoRow("Симптомы:", appointment.symptomsDescribedByPatient ?? "Не указано"),
            const SizedBox(height: 10),
            _infoRow("Самолечение:", appointment.selfTreatmentMethodsTaken ?? "Нет"),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Закрыть"),
        ),
      ],
    );
  }

  Widget _infoRow(String label, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(content, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}