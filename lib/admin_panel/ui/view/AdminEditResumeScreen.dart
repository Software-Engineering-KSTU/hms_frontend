import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
          TextButton(
            onPressed: model.isLoading
                ? null
                : () async {
              final success = await model.saveResume();
              if (success && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Сохранено"), backgroundColor: Colors.green),
                );
                Navigator.pop(context, true);
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
                child: Text(model.errorMessage!, style: const TextStyle(color: Colors.red)),
              ),

            // --- ФОТО И КНОПКА ЗАГРУЗКИ ---
            Center(
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300)),
                    child: ClipOval(
                      child: model.currentPhotoUrl != null && model.currentPhotoUrl!.isNotEmpty
                          ? CachedNetworkImage(
                        imageUrl: model.currentPhotoUrl!,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => const Icon(Icons.person, size: 60, color: Colors.grey),
                      )
                          : const Icon(Icons.person_add, size: 40, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: () => model.pickAndUploadPhoto(), // <--- РАБОТАЮЩАЯ КНОПКА
                    icon: const Icon(Icons.upload_file),
                    label: const Text("Загрузить фото"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            _buildField("Квалификация", model.stageController),
            _buildField("Стаж (лет)", model.experienceController, isNumber: true),
            _buildField("Образование", model.educationController, maxLines: 3),
            _buildField("Сертификаты", model.certificatesController, maxLines: 3),
            _buildField("О себе", model.descriptionController, maxLines: 5),
          ],
        ),
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}