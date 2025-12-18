import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Панель администратора",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF212121),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Быстрый доступ к управлению клиникой",
              style: TextStyle(fontSize: 16, color: Color(0xFF757575)),
            ),
            const SizedBox(height: 30),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: MediaQuery.of(context).size.width > 900 ? 4 : 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.3,
              children: [
                _AdminMenuCard(
                  title: "Пользователи",
                  subtitle: "Врачи и пациенты",
                  icon: Icons.people_alt_outlined,
                  color: const Color(0xFF1976D2),
                  onTap: () => context.push('/admin/users'),
                ),
                _AdminMenuCard(
                  title: "Добавить врача",
                  subtitle: "Регистрация специалиста",
                  icon: Icons.person_add_alt_1_outlined,
                  color: const Color(0xFF43A047),
                  onTap: () => context.push('/admin/create-doctor'),
                ),
                _AdminMenuCard(
                  title: "Статистика",
                  subtitle: "Записи и визиты",
                  icon: Icons.bar_chart_rounded,
                  color: const Color(0xFFFB8C00),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Раздел в разработке")),
                    );
                  },
                ),
                _AdminMenuCard(
                  title: "Настройки",
                  subtitle: "Системные параметры",
                  icon: Icons.settings_outlined,
                  color: const Color(0xFF757575),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Раздел в разработке")),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AdminMenuCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _AdminMenuCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 32, color: color),
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF757575),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}