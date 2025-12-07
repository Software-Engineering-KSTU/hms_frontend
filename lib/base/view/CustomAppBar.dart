import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          TextButton(
            onPressed: () {
              context.go('/');
            },
            child: const Text(
                "HMS",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
              )

          ),

          const SizedBox(width: 24),

          const ToggleButtonsGroup(),

          const Spacer(flex: 5),
        ],
      ),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ToggleButtonsGroup extends StatefulWidget {
  const ToggleButtonsGroup({super.key});

  @override
  State<ToggleButtonsGroup> createState() => _ToggleButtonsGroupState();
}

class _ToggleButtonsGroupState extends State<ToggleButtonsGroup> {
  int _selectedIndex = 0;
  final List<String> _buttonTitles = [
    'Главная',
    'Отделения',
    'Контакты',
    'Запись к врачу'
  ];

  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final String targetPath;
      switch (index) {
        case 0:
          targetPath = '/';
          break; // Главная → /
        case 1:
          targetPath = '/departments'; // Отделений
          break;
        case 2:
          targetPath = '/contacts';
          break; // Контакты
        case 3:
          targetPath = '/patient/doctors';
          break; // Запись к врачу
        default:
          return;
      }

      // Используем go для сброса стека при навигации между основными разделами
      context.go(targetPath);
    });
    // ----------------------------------------------------
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Left align in the AppBar title Row
      children: List.generate(_buttonTitles.length, (index) {
        final bool isActive = index == _selectedIndex;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextButton(
            // Вызываем только метод выбора, который включает setState и отложенную навигацию
            onPressed: () => _selectButton(index),
            style: TextButton.styleFrom(
              backgroundColor: isActive ? Colors.blue.shade100 : Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              _buttonTitles[index],
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