import 'package:dio/dio.dart';
import 'package:hmsweb/http/HttpRequest.dart';

class DoctorDashboardApi extends HttpRequest {

  // 1. Получаем расписание (уже было)
  Future<Response> fetchAppointmentsByDate(String date) {
    return dioHttpRequest.get('api/appointments/doctor/current-date/$date');
  }

  // --- НОВЫЕ МЕТОДЫ ДЛЯ ПРИЕМОВ (VISITS) ---

  // 2. Создать новый прием (назначение)
  // POST /visits
  Future<Response> createVisit(Map<String, dynamic> data) {
    return dioHttpRequest.post('visits', data: data);
  }

  // 3. Обновить существующий прием (добавить диагноз/лекарства)
  // PUT /visits/{id}
  Future<Response> updateVisit(int id, Map<String, dynamic> data) {
    return dioHttpRequest.put('visits/$id', data: data);
  }

  // 4. Получить конкретный прием по ID
  // GET /visits/{id}
  Future<Response> getVisitById(int id) {
    return dioHttpRequest.get('visits/$id');
  }
}