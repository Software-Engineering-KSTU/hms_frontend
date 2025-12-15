import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart'; // <--- Импорт провайдера
import 'package:hmsweb/auth/AuthModel.dart'; // <--- Импорт модели

// --- ИМИТАЦИЯ СОСТОЯНИЯ УДАЛЕНА. Теперь состояние берется из AuthModel. ---
// const bool isUserAuthenticated = false;
// const String currentUserRole = 'PATIENT';
// ---------------------------------------------------------------------------

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          // Логотип ведет на главную
          TextButton(
            onPressed: () => context.go('/'),
            child: const Text(
              "HMS",
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const SizedBox(width: 24),

          // --- 1. ГЛАВНОЕ МЕНЮ (Слева) ---
          const ToggleButtonsGroup(),

          const Spacer(),

          // --- 2. КНОПКИ ПРОФИЛЯ/ВХОДА (Справа) ---
          const RoleSpecificButtons(),
        ],
      ),
      centerTitle: false,
      backgroundColor: Colors.white,
      elevation: 1,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class RoleSpecificButtons extends StatelessWidget {
  const RoleSpecificButtons({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Consumer прослушивает AuthModel и перерисовывает себя при notifyListeners()
    return Consumer<AuthModel>(
      builder: (context, authModel, child) {
        final bool isAuthenticated = authModel.isAuthenticated;

        // Временно используем заглушку для роли, пока ты не добавил ее в AuthModel.
        // Когда добавишь, замени 'PATIENT' на authModel.userRole!
        const String currentUserRole = 'PATIENT';

        List<Widget> buttons = [];

        if (isAuthenticated) {
          // Если пользователь вошел

          if (currentUserRole == 'DOCTOR') {
            buttons.add(_buildPanelButton(context, "Мои записи", '/doctor/dashboard'));
          } else if (currentUserRole == 'ADMIN') {
            buttons.add(_buildPanelButton(context, "Админ панель", '/admin/dashboard'));
          }

          // Кнопка Профиль
          buttons.add(_buildProfileButton(context, "Профиль", () => context.go('/profile')));

          // Кнопка Выхода (Иконка)
          buttons.add(
            IconButton(
              icon: const Icon(Icons.logout, size: 20, color: Colors.grey),
              onPressed: () async {
                await authModel.logout(); // Вызываем метод выхода
                context.go('/login'); // Переходим на страницу входа
              },
              tooltip: 'Выход',
            ),
          );

        } else {
          // Если гость -> Кнопка Войти
          buttons.add(_buildProfileButton(context, "Войти", () => context.go('/login')));
        }

        return Row(mainAxisSize: MainAxisSize.min, children: buttons);
      },
    );
  }

  Widget _buildPanelButton(BuildContext context, String title, String path) {
    final isDanger = title.contains("Админ");
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: TextButton(
        onPressed: () => context.go(path),
        child: Text(
          title,
          style: TextStyle(
            color: isDanger ? Colors.red : Colors.blue.shade800,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileButton(BuildContext context, String label, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        label,
        style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.normal),
      ),
    );
  }
}

class ToggleButtonsGroup extends StatefulWidget {
  const ToggleButtonsGroup({super.key});

  @override
  State<ToggleButtonsGroup> createState() => _ToggleButtonsGroupState();
}

class _ToggleButtonsGroupState extends State<ToggleButtonsGroup> {
  int _selectedIndex = 0;

  // --- ИЗМЕНЕНИЕ: Добавили "Запись к врачу" сюда ---
  final List<Map<String, dynamic>> _menuItems = [
    {'title': 'Главная', 'path': '/'},
    {'title': 'Запись к врачу', 'path': '/patient/doctors'}, // <--- ВСЕГДА АКТИВНА
    {'title': 'Отделения', 'path': '/departments'},
    {'title': 'Контакты', 'path': '/contacts'},
  ];

  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
    context.go(_menuItems[index]['path'] as String);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(_menuItems.length, (index) {
        final bool isActive = index == _selectedIndex;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextButton(
            onPressed: () => _selectButton(index),
            style: TextButton.styleFrom(
              backgroundColor: isActive ? Colors.blue.shade100 : Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              _menuItems[index]['title'] as String,
              style: TextStyle(
                color: isActive ? Colors.blue.shade800 : Colors.black87,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }),
    );
  }
}