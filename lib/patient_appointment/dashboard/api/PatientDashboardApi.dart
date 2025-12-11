// post current day or other for init
// convert json to Map<String, StatusRegistration>

// make convert  Map<String, StatusRegistration> to json if was selected time of day
// then post new data to backend

// add new task for http code
// setting sign in and up

import 'package:dio/dio.dart';
import 'package:hmsweb/http/HttpRequest.dart';
import 'package:hmsweb/patient_appointment/dashboard/dto/PatientAppointmentDoctorDto.dart';

class PatientDashboardApi extends HttpRequest {

  Future<Response> fetchDoctorAppointments( {
    required String doctorId,
    required String date,
  }) {
    return dioHttpRequest.post('api/appointments/slots/current-day', data: {
      'date': date,
      'doctorId': doctorId,
    });
  }

  Future<Response> postPatientAppointment(
    PatientAppointmentDoctorDto patientAppointment,
  ) {
    return dioHttpRequest.post('api/appointments/register', data: {
      'doctorId': patientAppointment.doctorId,
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
