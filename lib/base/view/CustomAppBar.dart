import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:hmsweb/auth/AuthModel.dart';
import 'package:hmsweb/auth/dto/AuthDialogs.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          TextButton(
            onPressed: () => context.go('/'),
            child: const Text(
              "HMS",
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const SizedBox(width: 24),

          const ToggleButtonsGroup(),

          const Spacer(),

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
    return Consumer<AuthModel>(
      builder: (context, authModel, child) {
        final bool isAuthenticated = authModel.isAuthenticated;
        final String currentUserRole = authModel.role ?? 'GUEST';

        List<Widget> buttons = [];

        if (isAuthenticated) {

          if (currentUserRole == 'DOCTOR') {
            buttons.add(_buildPanelButton(context, "Мои записи", '/doctor/dashboard'));
          } else if (currentUserRole == 'ADMIN') {
            buttons.add(_buildPanelButton(context, "Админ панель", '/admin/dashboard'));
          }

          buttons.add(_buildProfileButton(context, "Профиль", () => context.go('/profile')));

          buttons.add(
            IconButton(
              icon: const Icon(Icons.logout, size: 20, color: Colors.grey),
              onPressed: () async {
                await authModel.logout();
                context.go('/');
              },
              tooltip: 'Выход',
            ),
          );

        } else {
          buttons.add(_buildProfileButton(context, "Войти", () => showLoginDialog(context)));
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

  final List<Map<String, dynamic>> _menuItems = [
    {'title': 'Главная', 'path': '/'},
    {'title': 'Запись к врачу', 'path': '/patient/doctors'},
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