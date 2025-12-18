import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hmsweb/admin_panel/ui/models/AdminDoctorResumeModel.dart';
import 'package:hmsweb/admin_panel/ui/view/AdminEditResumeScreen.dart';

class AdminDoctorResumeScreen extends StatelessWidget {
  final int userId;

  const AdminDoctorResumeScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AdminDoctorResumeModel(userId: userId),
      child: const _ResumeContent(),
    );
  }
}

class _ResumeContent extends StatelessWidget {
  const _ResumeContent();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AdminDoctorResumeModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Резюме врача (Админ)",
          style: TextStyle(color: Color(0xFF212121), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF212121)),
        actions: [
          // Показываем кнопку редактирования ТОЛЬКО если резюме существует
          if (model.resume != null)
            IconButton(
              icon: const Icon(Icons.edit, color: Color(0xFF1976D2)),
              tooltip: "Редактировать",
              onPressed: () => _navigateToEdit(context, model),
            ),

          if (model.resume != null)
            IconButton(
              icon: const Icon(Icons.delete_forever, color: Color(0xFFE53935)),
              tooltip: "Удалить резюме",
              onPressed: () => _confirmDelete(context, model),
            ),
        ],
      ),
      body: model.isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF1976D2)))
          : model.resume == null
          ? _buildEmptyState(context, model) // <-- Здесь теперь будет кнопка создания
          : _buildResumeView(context, model),
    );
  }

  // --- ИСПРАВЛЕННЫЙ МЕТОД ПУСТОГО СОСТОЯНИЯ ---
  Widget _buildEmptyState(BuildContext context, AdminDoctorResumeModel model) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.description_outlined, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 20),
          const Text(
            "Резюме не найдено",
            style: TextStyle(fontSize: 18, color: Color(0xFF757575)),
          ),
          const SizedBox(height: 10),

          // Показываем ошибку, если она есть
          if (model.errorMessage != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                model.errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
            ),

          const SizedBox(height: 30),

          // --- НОВАЯ КНОПКА СОЗДАНИЯ ---
          ElevatedButton.icon(
            onPressed: () {
              if (model.doctorId == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Ошибка: ID врача не определен. Невозможно создать резюме.")),
                );
                return;
              }
              // Переходим к созданию (existingResume: null)
              _navigateToEdit(context, model);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1976D2),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.add_circle_outline, color: Colors.white),
            label: const Text(
              "Создать резюме",
              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResumeView(BuildContext context, AdminDoctorResumeModel model) {
    final resume = model.resume!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Карточка с фото
          Center(
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipOval(
                child: resume.photoUrl != null && resume.photoUrl!.isNotEmpty
                    ? CachedNetworkImage(
                  imageUrl: resume.photoUrl!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.person, size: 80, color: Colors.grey),
                )
                    : const Icon(Icons.person, size: 80, color: Colors.grey),
              ),
            ),
          ),

          const SizedBox(height: 30),

          _buildInfoCard("Квалификация", resume.stage, Icons.workspace_premium),
          _buildInfoCard("Стаж работы", "${resume.experienceYears} лет", Icons.history),
          _buildInfoCard("Образование", resume.education, Icons.school),
          _buildInfoCard("Сертификаты", resume.certificates, Icons.card_membership),

          const SizedBox(height: 20),
          const Text(
            "О себе",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF212121)),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10),
              ],
            ),
            child: Text(
              resume.description,
              style: const TextStyle(fontSize: 16, height: 1.5, color: Color(0xFF424242)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: const Color(0xFF1976D2), size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 12, color: Color(0xFF757575)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF212121)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Вспомогательный метод навигации
  Future<void> _navigateToEdit(BuildContext context, AdminDoctorResumeModel model) async {
    final bool? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdminEditResumeScreen(
          doctorId: model.doctorId!,
          existingResume: model.resume, // Если null, откроется форма создания
        ),
      ),
    );

    if (result == true) {
      model.fetchResume();
    }
  }

  void _confirmDelete(BuildContext context, AdminDoctorResumeModel model) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Удалить резюме?"),
        content: const Text("Это действие удалит информацию о враче, но оставит учетную запись."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Отмена")),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await model.deleteResume();
            },
            child: const Text("Удалить", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}