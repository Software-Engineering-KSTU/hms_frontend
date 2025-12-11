// fileName: CustomAppBar.dart
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';

// --- НАЧАЛО: УПРОЩЕННЫЕ ЗАГЛУШКИ ДЛЯ АВТОРИЗАЦИИ И РОЛИ ---
// !!! В РЕАЛЬНОМ ПРИЛОЖЕНИИ ЭТИ ЗНАЧЕНИЯ ДОЛЖНЫ БРАТЬСЯ ИЗ AuthModel !!!

// Имитация статуса авторизации
const bool isUserAuthenticated = true; // false = Гость, true = Авторизован

// Имитация роли (для определения, какую панель показать, если авторизован)
// Возможные значения: 'PATIENT', 'DOCTOR', 'ADMIN'
const String currentUserRole = 'DOCTOR';
// --- КОНЕЦ: УПРОЩЕННЫЕ ЗАГЛУШКИ ---


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

          // Основная навигация (Главная, Контакты и т.д.)
          const ToggleButtonsGroup(),

          // Разделитель, который сдвинет следующий элемент вправо
          const Spacer(flex: 5),

          // --- НОВЫЙ БЛОК: КНОПКИ, ЗАВИСЯЩИЕ ОТ АВТОРИЗАЦИИ И РОЛИ ---
          const RoleSpecificButtons(),
          // --- КОНЕЦ НОВОГО БЛОКА ---
        ],
      ),
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


// --- НОВЫЙ ВИДЖЕТ: КНОПКИ, ЗАВИСЯЩИЕ ОТ РОЛИ ---
class RoleSpecificButtons extends StatelessWidget {
  const RoleSpecificButtons({super.key});

  @override
  Widget build(BuildContext context) {
    // Если пользователь не авторизован, ничего не показываем
    if (!isUserAuthenticated) {
      return const SizedBox.shrink();
    }

    List<Widget> buttons = [];

    // 1. Динамическая кнопка Панели (Доктор/Админ)
    if (currentUserRole == 'DOCTOR') {
      // Кнопка для Доктора
      buttons.add(_buildPanelButton(context, "Мои записи", '/doctor/dashboard'));
    } else if (currentUserRole == 'ADMIN') {
      // Кнопка для Админа
      buttons.add(_buildPanelButton(context, "Админ панель", '/admin/dashboard'));
      // Админу также нужна кнопка "Запись к врачу"
      buttons.add(_buildPanelButton(context, "Запись к врачу", '/patient/doctors'));
    } else if (currentUserRole == 'PATIENT') {
      // Кнопка для Пациента
      buttons.add(_buildPanelButton(context, "Запись к врачу", '/patient/doctors'));
    }


    // 2. Кнопка "Профиль" (доступна всем авторизованным)
    buttons.add(_buildProfileButton(context));

    return Row(
      mainAxisSize: MainAxisSize.min, // Занимаем только нужное место
      children: buttons,
    );
  }

  // Вспомогательный метод для создания кнопок панели
  Widget _buildPanelButton(BuildContext context, String title, String path) {
    // Если это кнопка "Админ панель", делаем ее красной
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

  // Вспомогательный метод для создания кнопки "Профиль"
  Widget _buildProfileButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        // TODO: context.go('/profile'); // Будущий маршрут
      },
      child: const Text(
        "Профиль",
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
// --- КОНЕЦ НОВОГО ВИДЖЕТА ---


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
    // Кнопка "Запись к врачу" здесь не нужна, так как она будет отображаться
    // динамически в RoleSpecificButtons или как призыв к действию в контенте.
    // Оставляем только статичные разделы.
    // 'Запись к врачу'
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
          targetPath = '/departments'; // Отделений (Нужно будет создать маршрут)
          break;
        case 2:
          targetPath = '/contacts';
          break; // Контакты
        default:
          return;
      }

      context.go(targetPath);
    });
    // ----------------------------------------------------
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_buttonTitles.length, (index) {
          final bool isActive = index == _selectedIndex;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
              // В _ToggleButtonsGroupState, в TextButton:
                onPressed: () {
                  _selectButton(index);
                  switch (index) {
                    case 0: context.go('/'); break;  // Главная → /
                    case 1: context.go('/'); break;  // Отделения (добавьте роут, если нужно)
                    case 2: context.go('/'); break;  // Контакты
                    case 3: context.go('/'); break;  // Запись к врачу → регистрация
                  }
                },
//
              style: TextButton.styleFrom(
                backgroundColor: isActive
                    ? Colors.blue.shade100
                    : Colors.transparent,
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
          ),
        );
      }),
    );
  }
}