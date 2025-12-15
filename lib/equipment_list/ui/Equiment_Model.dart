import 'package:flutter/material.dart';
// Убедитесь, что этот импорт соответствует вашему пути к BaseScreenModel
import 'package:hmsweb/base/BaseScreenModel.dart';

class EquipmentViewModel extends BaseScreenModel {
  // Список отделений, который может быть загружен асинхронно
  final List<String> _departments = [
    "Хирургическое отделение",
    "Терапевтическое отделение",
    "Педиатрия",
    "Кардиология",
    "Неврология",
  ];

  // Список оборудования
  List<Map<String, dynamic>> _equipment = [];

  String _selectedDepartment = "Хирургическое отделение";
  bool _isGrid = false;

  // Геттеры для доступа к данным
  List<String> get departments => _departments;
  List<Map<String, dynamic>> get equipment => _equipment;
  String get selectedDepartment => _selectedDepartment;
  bool get isGrid => _isGrid;

  // Сеттеры, вызывающие notifyListeners()
  set selectedDepartment(String value) {
    _selectedDepartment = value;
    // В реальном приложении здесь может быть вызов для загрузки
    // оборудования для нового отделения.
    notifyListeners();
  }

  set isGrid(bool value) {
    _isGrid = value;
    notifyListeners();
  }

  // Логика получения цвета статуса
  Color getStatusColor(String status) {
    switch (status) {
      case "Исправен":
        return Colors.green;
      case "Неисправен":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Инициализация, которая будет вызвана через BaseScreenModel.initialize()
  @override
  Future<void> onInitialization() async {
    // Имитация асинхронной загрузки данных
    // Если вам не нужна асинхронная загрузка, можете убрать Future.delayed
    await Future.delayed(const Duration(milliseconds: 500));

    // Инициализация списка оборудования
    _equipment = [
      {
        "icon": Icons.monitor_heart, // кардиомонитор
        "name": "Кардиомонитор",
        "count": 4,
        "livecount": 2,
        "status": "Исправен"
      },
      {
        "icon": Icons.wifi_tethering, // узи
        "name": "Аппарат УЗИ",
        "count": 2,
        "livecount": 2,
        "status": "Исправен"
      },
      {
        "icon": Icons.local_hospital, // дефибриллятор
        "name": "Дефибриллятор",
        "count": 1,
        "livecount": 0,
        "status": "Неисправен"
      },
      {
        "icon": Icons.camera, // эндоскоп
        "name": "Эндоскоп",
        "count": 3,
        "livecount": 3,
        "status": "Исправен"
      },
    ];
  }
}