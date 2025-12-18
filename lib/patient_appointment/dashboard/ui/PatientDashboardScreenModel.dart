import 'package:flutter/foundation.dart';
import 'package:hmsweb/base/BaseScreenModel.dart';
import 'package:hmsweb/patient_appointment/dashboard/ui/view/StatusRegistration.dart';
import 'package:hmsweb/patient_appointment/dashboard/rep/PatientDashboardRep.dart';
import '../dto/PatientAppointmentDoctorDto.dart';

class PatientDashboardScreenModel extends BaseScreenModel {

  PatientDashboardScreenModel({required this.idDoctor}) {
    // Включаем загрузку сразу при создании
    isLoading = true;
    // Запускаем инициализацию автоматически
    _autoStartInit();
  }

  // --- КЭШ (Хранит данные для дат, чтобы не грузить их повторно) ---
  final Map<String, Map<String, StatusRegistration>> _cache = {};

  final String idDoctor;
  String symptomsDescription = "";
  String selfTreatmentMethodsTaken = "";

  final _rep = PatientDashboardRep();

  // Текущие отображаемые статусы
  final Map<String, StatusRegistration> status = {};

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  final List<String> times = [
    "08:00", "08:20", "08:40", "09:00",
    "09:20", "09:40", "10:00", "10:20",
    "10:40", "11:00", "11:20", "11:40",
    "12:00", "12:20", "12:40", "13:00",
    "13:20", "13:40",
  ];

  // Этот метод запустится сам из конструктора
  void _autoStartInit() async {
    print("===> CONSTRUCTOR: Модель создана. Ждем сборки UI...");
    await Future.delayed(Duration.zero);
    print("===> CONSTRUCTOR: Запускаем onInitialization...");
    await onInitialization();
  }

  @override
  Future<void> onInitialization() async {
    print("===> 1. START: onInitialization начал работу");

    try {
      final now = DateTime.now();
      // Чистая дата сегодня (без времени)
      final todayClean = DateTime(now.year, now.month, now.day);

      selectedDay = todayClean;
      print("===> 2. DATE: Выбрана дата: $todayClean");

      // Грузим данные
      await _loadDataAndApplyLogic(todayClean);

    } catch (e) {
      print("===> ERROR in onInitialization: $e");
    } finally {
      print("===> FINISH: Инициализация завершена. Выключаем Loader.");
      isLoading = false;
      notifyListeners();
    }
  }

  // Метод вызывается UI при смене даты в календаре
  Future<void> setDoctorAppointmentsUi(DateTime dateInput) async {
    print("===> UI CHANGE: Смена даты на $dateInput");
    isLoading = true;
    notifyListeners();

    try {
      final dateClean = DateTime(dateInput.year, dateInput.month, dateInput.day);
      await _loadDataAndApplyLogic(dateClean);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Единая логика загрузки с КЭШИРОВАНИЕМ
  Future<void> _loadDataAndApplyLogic(DateTime dateClean) async {
    status.clear();
    final now = DateTime.now();
    final todayClean = DateTime(now.year, now.month, now.day);

    // Получаем строковое представление даты для ключа кэша и API
    final dateString = getDateFromDateTime(dateClean);

    // 1. ПРОВЕРКА: Если дата в прошлом
    if (dateClean.isBefore(todayClean)) {
      print("===> LOGIC: Прошлое. Блокируем.");
      _fillAllBusy();
      return;
    }

    // 2. ПРОВЕРКА КЭША: Если данные уже есть в памяти
    if (_cache.containsKey(dateString)) {
      print("===> CACHE HIT: Данные найдены в памяти для $dateString!");

      // Берем данные из кэша
      status.addAll(_cache[dateString]!);

      // Если это СЕГОДНЯ, нужно всё равно применить фильтр времени (время идет вперед)
      if (dateClean.isAtSameMomentAs(todayClean)) {
        print("===> LOGIC: Это сегодня (из кэша). Обновляем фильтр времени.");
        _applyTimeFilter(now);
      }

      // Выходим, сеть не трогаем
      return;
    }

    // 3. ЗАГРУЗКА ИЗ СЕТИ (Если в кэше нет)
    print("===> NETWORK: Данных нет в кэше. Запрос doctorId=$idDoctor, date=$dateString");

    final backendData = await _rep.getDoctorAppointments(
      doctorId: idDoctor,
      date: dateString,
    );

    print("===> NETWORK: Пришло записей: ${backendData.length}");

    // 4. СОХРАНЯЕМ В КЭШ
    _cache[dateString] = backendData;

    // Обновляем текущий статус
    status.addAll(backendData);

    // 5. Фильтр времени для сегодняшнего дня
    if (dateClean.isAtSameMomentAs(todayClean)) {
      print("===> LOGIC: Сегодня. Фильтруем время.");
      _applyTimeFilter(now);
    }
  }

  void _fillAllBusy() {
    for (var time in times) {
      status[time] = StatusRegistration.busy;
    }
  }

  void _applyTimeFilter(DateTime now) {
    for (var timeStr in times) {
      try {
        final parts = timeStr.split(':');
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        final slotTime = DateTime(now.year, now.month, now.day, hour, minute);

        // Если время слота прошло
        if (slotTime.isBefore(now)) {
          // Если это НЕ моя запись, помечаем как "занято"
          if (status[timeStr] != StatusRegistration.mine) {
            status[timeStr] = StatusRegistration.busy;
          }
        }
      } catch (e) { /* ignore */ }
    }
  }

  bool isNotBusyOrMine(String time) {
    if (status[time] == StatusRegistration.busy) return false;
    if (status[time] == StatusRegistration.mine) return false;
    return true;
  }

  Future<void> setMineStatusRegistration(String time) async {
    final dateToSend = selectedDay ?? DateTime.now();
    final patientAppointment = PatientAppointmentDoctorDto(
      doctorId: idDoctor,
      date: getDate(dataTime: dateToSend),
      time: time,
      symptomsDescription: symptomsDescription,
      selfTreatmentMethodsTaken: selfTreatmentMethodsTaken,
    );

    final result = await _rep.postPatientAppointment(patientAppointment);

    if (result) {
      // 1. Обновляем текущий UI
      status[time] = StatusRegistration.mine;

      // 2. ОБНОВЛЯЕМ КЭШ (чтобы при возврате на этот день запись осталась)
      final dateKey = getDateFromDateTime(dateToSend);
      if (_cache.containsKey(dateKey)) {
        // Обновляем конкретный слот в сохраненной карте
        _cache[dateKey]![time] = StatusRegistration.mine;
        print("===> CACHE UPDATE: Обновили запись в кэше для $dateKey");
      }

      notifyListeners();
    }
  }
}