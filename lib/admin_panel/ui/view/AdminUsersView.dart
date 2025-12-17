import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../dto/UserDto.dart';
import '../AdminUsersModel.dart';
import '../../ui/models/CreateDoctorView.dart';

// Основные цвета стиля Clean Medical
class MedicalColors {
  static const Color primaryBlue = Color(0xFF1976D2);
  static const Color background = Color(0xFFF5F7FA);
  static const Color textDark = Color(0xFF212121);
  static const Color textGrey = Color(0xFF757575);
  static const Color white = Colors.white;
}

class AdminUsersView extends StatelessWidget {
  const AdminUsersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ВАЖНО: Мы удалили ChangeNotifierProvider здесь,
    // потому что он уже создан в Navigation.dart.
    // Мы сразу получаем доступ к модели через context.watch.
    final model = context.watch<AdminUsersModel>();

    return Scaffold(
      backgroundColor: MedicalColors.background,
      appBar: AppBar(
        title: const Text(
          'Управление пользователями',
          style: TextStyle(color: MedicalColors.textDark, fontWeight: FontWeight.bold),
        ),
        backgroundColor: MedicalColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: MedicalColors.textDark),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => model.fetchUsers(isRefresh: true),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // Переходим на экран создания
          // CreateDoctorView не управляется роутером, поэтому создается локально
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateDoctorView()),
          );

          // Если вернулись с true (значит создали врача), обновляем список
          if (result == true) {
            model.fetchUsers(isRefresh: true);
          }
        },
        backgroundColor: MedicalColors.primaryBlue,
        icon: const Icon(Icons.add),
        label: const Text("Добавить врача"),
      ),
      body: model.isLoading
          ? const Center(child: CircularProgressIndicator(color: MedicalColors.primaryBlue))
          : model.errorMessage != null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(model.errorMessage!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => model.fetchUsers(isRefresh: true),
              child: const Text("Повторить"),
            )
          ],
        ),
      )
          : RefreshIndicator(
        onRefresh: () => model.fetchUsers(isRefresh: true),
        color: MedicalColors.primaryBlue,
        child: ListView.separated(
          padding: const EdgeInsets.all(16.0),
          itemCount: model.users.length,
          separatorBuilder: (ctx, index) => const SizedBox(height: 12),
          itemBuilder: (ctx, index) {
            final user = model.users[index];
            return _UserCard(user: user);
          },
        ),
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final UserDto user;

  const _UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MedicalColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Аватар / Иконка
                CircleAvatar(
                  radius: 24,
                  backgroundColor: MedicalColors.primaryBlue.withOpacity(0.1),
                  child: Text(
                    user.username.isNotEmpty ? user.username[0].toUpperCase() : '?',
                    style: const TextStyle(
                      color: MedicalColors.primaryBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Данные пользователя
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.username,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: MedicalColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email,
                        style: const TextStyle(
                          fontSize: 14,
                          color: MedicalColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                // Бейдж роли
                _RoleBadge(role: user.role),
              ],
            ),
          ),
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
        text = 'Админ';
        break;
      case 'DOCTOR':
        bgColor = const Color(0xFFE3F2FD); // Light Blue
        textColor = const Color(0xFF1976D2); // Medical Blue
        text = 'Врач';
        break;
      default:
        bgColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        text = 'Пациент';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}