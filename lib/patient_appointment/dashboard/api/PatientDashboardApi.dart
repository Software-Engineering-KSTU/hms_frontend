import 'package:dio/dio.dart';
import 'package:hmsweb/http/HttpRequest.dart';
import 'package:hmsweb/patient_appointment/dashboard/dto/PatientAppointmentDoctorDto.dart';

class PatientDashboardApi extends HttpRequest {

  Future<Response> fetchDoctorAppointments({
    required String doctorId,
    required String date,
  }) {
    return dioHttpRequest.post('api/appointments/slots/current-day', data: {
      'date': date,
      'doctorId': int.tryParse(doctorId),
    });
  }

  Future<Response> postPatientAppointment(
      PatientAppointmentDoctorDto patientAppointment,
      ) {
    return dioHttpRequest.post('api/appointments/register', data: {
      'doctorId': int.tryParse(patientAppointment.doctorId),
      'date': patientAppointment.date,
      'time': patientAppointment.time,
      'symptomsDescribedByPatient': patientAppointment.symptomsDescription,
      'selfTreatmentMethodsTaken': patientAppointment.selfTreatmentMethodsTaken,
    });
  }

  Future<Response> fetchDoctors() {
    return dioHttpRequest.get('api/appointments/doctors');
  }
}