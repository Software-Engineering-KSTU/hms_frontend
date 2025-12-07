import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // В AppBar лучше использовать FlexibleSpaceBar или просто Row для гибкости
    return AppBar(
      title: Row(
        // Используем Expanded вместо Spacer для лучшего контроля в AppBar
        children: [
          // Title не должен быть обернут в Title(color:...), используйте просто Text
          const Text(
            "HMS",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),

          const SizedBox(width: 24), // Небольшой отступ

          const ToggleButtonsGroup(),

          // Spacer для того, чтобы сдвинуть кнопки влево, если нужно
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

    // ----------------------------------------------------
    // FIX: Навигацию нужно отложить до завершения текущего кадра
    // ----------------------------------------------------
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // Проверяем, что виджет все еще в дереве (mounted) перед навигацией
      if (!mounted) return;

      final String targetPath;
      switch (index) {
        case 0:
          targetPath = '/';
          break; // Главная → /
        case 1:
          targetPath = '/departments'; // Предполагаемый роут для отделений
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