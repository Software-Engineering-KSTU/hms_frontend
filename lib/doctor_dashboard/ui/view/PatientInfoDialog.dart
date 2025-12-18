import 'package:flutter/material.dart';
import 'package:hmsweb/doctor_dashboard/dto/DoctorAppointmentDto.dart';

class PatientInfoDialog extends StatelessWidget {
  final DoctorAppointmentDto appointment;
  // Callback функция: вызывается, когда врач нажимает "Назначить"
  final VoidCallback? onPrescribe;

  const PatientInfoDialog({
    super.key,
    required this.appointment,
    this.onPrescribe,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.person, color: Color(0xFF1976D2)),
          const SizedBox(width: 10),
          Expanded(child: Text(appointment.patient.username ?? "Пациент")),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _infoRow("Телефон:", appointment.patient.phoneNumber),
            const Divider(),
            _infoRow("Дата рождения:", appointment.patient.birthDate ?? "Не указано"),
            const SizedBox(height: 10),
            _infoRow("Жалобы пациента:", appointment.symptomsDescribedByPatient ?? "Не указано"),
            const SizedBox(height: 10),
            _infoRow("Самолечение:", appointment.selfTreatmentMethodsTaken ?? "Нет"),
          ],
        ),
      ),
      actions: [
        // Кнопка "Закрыть"
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Закрыть", style: TextStyle(color: Colors.grey)),
        ),

        // --- НОВАЯ КНОПКА: НАЗНАЧИТЬ ---
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1976D2),
            foregroundColor: Colors.white,
          ),
          icon: const Icon(Icons.edit_note, size: 18),
          label: const Text("Назначить лечение"),
          onPressed: () {
            // Закрываем инфо-диалог и вызываем callback для открытия формы
            Navigator.pop(context);
            onPrescribe?.call();
          },
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
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(content, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}