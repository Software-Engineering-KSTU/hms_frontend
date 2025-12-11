import 'package:dio/dio.dart';
import 'package:hmsweb/http/HttpRequest.dart';

class DoctorDashboardApi extends HttpRequest {

  // Получаем записи текущего залогиненного доктора на конкретную дату
  Future<Response> fetchAppointmentsByDate(String date) {
    // date должна быть в формате yyyy-MM-dd
    return dioHttpRequest.get('api/appointments/doctor/current-date/$date');
  }
}