import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hmsweb/admin_panel/ui/models/AdminDoctorResumeModel.dart';
import 'package:hmsweb/admin_panel/ui/view/AdminEditResumeScreen.dart';
import 'package:hmsweb/doctors_resume/dto/DoctorResumeDto.dart';

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
          if (model.resume != null) ...[
            IconButton(
              icon: const Icon(Icons.edit, color: Color(0xFF1976D2)),
              tooltip: "Редактировать",
              onPressed: () => _navigateToEdit(context, model),
            ),
            IconButton(
              icon: const Icon(Icons.delete_forever, color: Color(0xFFE53935)),
              tooltip: "Удалить резюме",
              onPressed: () => _confirmDelete(context, model),
            ),
          ]
        ],
      ),
      body: Builder(
        builder: (context) {
          if (model.isLoading) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF1976D2)));
          }

          if (model.resume == null) {
            return _buildEmptyState(context, model);
          }

          return _buildResumeView(context, model.resume!);
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AdminDoctorResumeModel model) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.description_outlined, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 20),
          const Text("Резюме не найдено", style: TextStyle(fontSize: 18, color: Color(0xFF757575))),
          const SizedBox(height: 10),
          if (model.errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(model.errorMessage!, style: const TextStyle(color: Colors.red)),
            ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              if (model.doctorId == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Ошибка: ID врача не определен.")),
                );
                return;
              }
              _navigateToEdit(context, model);
            },
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text("Создать резюме", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1976D2)),
          ),
        ],
      ),
    );
  }

  Widget _buildResumeView(BuildContext context, DoctorResumeDto resume) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Center(
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
              child: ClipOval(
                child: resume.photoUrl != null && resume.photoUrl!.isNotEmpty
                    ? CachedNetworkImage(
                  imageUrl: resume.photoUrl!,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) => const Icon(Icons.person, size: 80, color: Colors.grey),
                )
                    : const Icon(Icons.person, size: 80, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildInfoCard("Квалификация", resume.stage, Icons.workspace_premium),
          _buildInfoCard("Стаж", "${resume.experienceYears} лет", Icons.history),
          _buildInfoCard("Образование", resume.education, Icons.school),
          _buildInfoCard("Сертификаты", resume.certificates, Icons.card_membership),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("О себе", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(resume.description),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
      child: ListTile(
        leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: const Color(0xFF1976D2))),
        title: Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
      ),
    );
  }

  Future<void> _navigateToEdit(BuildContext context, AdminDoctorResumeModel model) async {
    final bool? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdminEditResumeScreen(
          doctorId: model.doctorId!,
          existingResume: model.resume,
        ),
      ),
    );
    if (result == true) model.fetchResume();
  }

  void _confirmDelete(BuildContext context, AdminDoctorResumeModel model) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Удалить?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Нет")),
          TextButton(onPressed: () async { Navigator.pop(ctx); await model.deleteResume(); }, child: const Text("Да", style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
}