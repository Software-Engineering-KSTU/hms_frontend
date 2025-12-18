import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../dto/UserDto.dart';
import '../models/AdminUsersModel.dart';

class AdminUsersView extends StatelessWidget {
  const AdminUsersView({super.key});

  @override
  Widget build(BuildContext context) {
    // УБРАЛИ watch отсюда. Теперь build вызывается один раз.
    // final model = context.watch<AdminUsersModel>();

    // Получаем read для методов (нажатия кнопок), это не вызывает перерисовку
    final modelRead = context.read<AdminUsersModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Управление пользователями',
          style: TextStyle(color: Color(0xFF212121), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF212121)),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFF1976D2)),
            onPressed: () => modelRead.fetchUsers(isRefresh: true),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/admin/create-doctor'),
        backgroundColor: const Color(0xFF1976D2),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Добавить врача", style: TextStyle(color: Colors.white)),
      ),
      // Consumer следит за изменениями модели ТОЛЬКО в этой части дерева
      body: Consumer<AdminUsersModel>(
        builder: (context, model, child) {
          if (model.isLoading) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF1976D2)));
          }

          if (model.errorMessage != null) {
            return Center(child: Text(model.errorMessage!, style: const TextStyle(color: Colors.red)));
          }

          if (model.users.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text("Список пользователей пуст", style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: model.users.length,
            separatorBuilder: (ctx, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final user = model.users[index];
              return _UserCard(
                user: user, // Передаем объект
                // Важно: onDelete вызываем через modelRead, чтобы не дергать watch лишний раз
                onDelete: () => _confirmDelete(context, modelRead, user),
                onViewResume: () {
                  context.push('/admin/resume/${user.id}');
                },
              );
            },
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, AdminUsersModel model, UserDto user) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Удалить пользователя?"),
        content: Text("Вы уверены, что хотите удалить ${user.username} (ID: ${user.id})?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Отмена", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await model.deleteUser(user.id);
            },
            child: const Text("Удалить", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

// Карточку оставляем почти без изменений, она легкая
class _UserCard extends StatelessWidget {
  final UserDto user;
  final VoidCallback onDelete;
  final VoidCallback onViewResume;

  const _UserCard({
    required this.user,
    required this.onDelete,
    required this.onViewResume,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDoctor = user.role == 'DOCTOR';
    final bool isAdmin = user.role == 'ADMIN';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isDoctor ? const Color(0xFFE3F2FD) : (isAdmin ? Colors.red.shade50 : Colors.green.shade50),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isAdmin ? Icons.admin_panel_settings : (isDoctor ? Icons.medical_services : Icons.person),
                color: isDoctor ? const Color(0xFF1976D2) : (isAdmin ? Colors.red : Colors.green),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.username,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF212121)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "ID: ${user.id} • ${user.email}",
                    style: const TextStyle(fontSize: 13, color: Color(0xFF757575)),
                  ),
                  const SizedBox(height: 6),
                  _RoleBadge(role: user.role),
                ],
              ),
            ),
            if (isDoctor)
              IconButton(
                icon: const Icon(Icons.description_outlined, color: Color(0xFF1976D2)),
                tooltip: "Резюме врача",
                onPressed: onViewResume,
              ),
            if (!isAdmin)
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Color(0xFFE53935)),
                tooltip: "Удалить",
                onPressed: onDelete,
              ),
          ],
        ),
      ),
    );
  }
}

class _RoleBadge extends StatelessWidget {
  final String role;
  const _RoleBadge({required this.role});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    String text;

    switch (role) {
      case 'ADMIN':
        bgColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red;
        text = 'Администратор';
        break;
      case 'DOCTOR':
        bgColor = const Color(0xFFE3F2FD);
        textColor = const Color(0xFF1976D2);
        text = 'Врач';
        break;
      default:
        bgColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        text = 'Пациент';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8)),
      child: Text(text, style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}