import 'package:dio/dio.dart';
import 'package:hmsweb/http/HttpRequest.dart';

class DoctorsResumeApi {

  Future<Response> fetchDoctorResume(String idDoctor) async {
    return dioHttpRequest.get('api/doctor-resume/$idDoctor');
  }

  Future<Response> fetchDoctorById(String idDoctor) async {
    return dioHttpRequest.get('api/appointments/doctor/$idDoctor');
  }
}

