import 'package:flutter/material.dart';
import 'package:hmsweb/doctor_dashboard/dto/VisitDto.dart';

class VisitCreationDialog extends StatefulWidget {
  final int doctorId;
  final int patientId;

  const VisitCreationDialog({
    super.key,
    required this.doctorId,
    required this.patientId,
  });

  @override
  State<VisitCreationDialog> createState() => _VisitCreationDialogState();
}

class _VisitCreationDialogState extends State<VisitCreationDialog> {
  final _formKey = GlobalKey<FormState>();

  // Контроллеры для полей (соответствуют VisitDto)
  final _diagnosisController = TextEditingController();
  final _symptomsController = TextEditingController();
  final _recommendationsController = TextEditingController();
  final _medicationsController = TextEditingController();
  final _dosageController = TextEditingController();

  @override
  void dispose() {
    _diagnosisController.dispose();
    _symptomsController.dispose();
    _recommendationsController.dispose();
    _medicationsController.dispose();
    _dosageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Назначение лечения"),
      content: SizedBox(
        width: 500, // Ширина диалога
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSectionTitle("Диагноз и Симптомы"),
                _buildTextField(_diagnosisController, "Диагноз (Обязательно)", isRequired: true),
                const SizedBox(height: 10),
                _buildTextField(_symptomsController, "Жалобы / Симптомы", maxLines: 2),

                const SizedBox(height: 20),
                _buildSectionTitle("Лечение"),
                _buildTextField(_medicationsController, "Лекарства"),
                const SizedBox(height: 10),
                _buildTextField(_dosageController, "Дозировка / Режим приема"),

                const SizedBox(height: 20),
                _buildSectionTitle("Рекомендации"),
                _buildTextField(_recommendationsController, "Дополнительные рекомендации", maxLines: 3),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Отмена", style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1976D2),
            foregroundColor: Colors.white,
          ),
          onPressed: _submit,
          child: const Text("Сохранить назначение"),
        ),
      ],
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Создаем DTO для отправки
      final visitDto = VisitDto(
        doctorId: widget.doctorId,
        patientId: widget.patientId,
        // Текущее время в формате ISO (как LocalDateTime в Java)
        visitDate: DateTime.now().toIso8601String(),

        diagnosis: _diagnosisController.text,
        symptoms: _symptomsController.text,
        recommendations: _recommendationsController.text,
        medications: _medicationsController.text,
        dosage: _dosageController.text,

        // Остальные поля можно добавить по необходимости
      );

      // Возвращаем DTO обратно в вызвавший экран
      Navigator.pop(context, visitDto);
    }
  }

  Widget _buildTextField(TextEditingController controller, String label, {int maxLines = 1, bool isRequired = false}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
      validator: (value) {
        if (isRequired && (value == null || value.isEmpty)) {
          return 'Это поле обязательно';
        }
        return null;
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1976D2)),
        ),
      ),
    );
  }
}