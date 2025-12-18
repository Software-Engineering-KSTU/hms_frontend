import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hmsweb/doctors_resume/dto/DoctorResumeDto.dart';
import 'package:hmsweb/admin_panel/ui/models/AdminEditResumeModel.dart';

class AdminEditResumeScreen extends StatelessWidget {
  final int doctorId;
  final DoctorResumeDto? existingResume;

  const AdminEditResumeScreen({
    super.key,
    required this.doctorId,
    this.existingResume,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AdminEditResumeModel(doctorId: doctorId, initialData: existingResume),
      child: const _EditContent(),
    );
  }
}

class _EditContent extends StatelessWidget {
  const _EditContent();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AdminEditResumeModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          model.initialData == null ? "Создать резюме" : "Редактировать резюме",
          style: const TextStyle(color: Color(0xFF212121), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF212121)),
        actions: [
          // Кнопка Сохранить в шапке
          TextButton(
            onPressed: model.isLoading
                ? null
                : () async {
              final success = await model.saveResume();
              if (success && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Изменения сохранены"), backgroundColor: Colors.green),
                );
                Navigator.pop(context, true); // Возвращаем true, чтобы обновить предыдущий экран
              }
            },
            child: const Text("Сохранить", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: model.isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF1976D2)))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (model.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(model.errorMessage!, style: TextStyle(color: Colors.red.shade800)),
                ),
              ),

            _buildSectionTitle("Основная информация"),
            const SizedBox(height: 16),
            _buildField("Квалификация / Степень", model.stageController, maxLines: 1),
            _buildField("Стаж (лет)", model.experienceController, isNumber: true),

            const SizedBox(height: 24),
            _buildSectionTitle("Образование и навыки"),
            const SizedBox(height: 16),
            _buildField("Образование (ВУЗ, год)", model.educationController, maxLines: 3),
            _buildField("Сертификаты", model.certificatesController, maxLines: 3),

            const SizedBox(height: 24),
            _buildSectionTitle("Подробное описание"),
            const SizedBox(height: 16),
            _buildField("О себе, методы лечения", model.descriptionController, maxLines: 6),

            const SizedBox(height: 30),
            // Кнопка загрузки фото (пока заглушка визуальная)
            OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Функция загрузки фото в разработке")),
                );
              },
              icon: const Icon(Icons.upload_file),
              label: const Text("Загрузить новое фото"),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF1976D2),
                side: const BorderSide(color: Color(0xFF1976D2)),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1976D2),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, {int maxLines = 1, bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          alignLabelWithHint: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF1976D2), width: 2),
          ),
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}