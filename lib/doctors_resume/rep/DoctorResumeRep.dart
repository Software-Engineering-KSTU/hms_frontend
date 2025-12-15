import 'package:hmsweb/doctors_resume/api/DoctorResumeApi.dart';
import 'package:hmsweb/doctors_resume/dto/DoctorResumeDto.dart';
import 'package:hmsweb/patient_appointment/dashboard/dto/DoctorInfoDto.dart';

class DoctorResumeRep {
  final _api = DoctorsResumeApi();

  Future<DoctorResumeDto> getDoctorResume(String idDoctor) async {
    final response = await _api.fetchDoctorResume(idDoctor);

    return DoctorResumeDto.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<DoctorInfoDto> getDoctorById(String idDoctor) async {
    final response = await _api.fetchDoctorById(idDoctor);

    return DoctorInfoDto.fromJson(
      response.data as Map<String, dynamic>,
    );

  }

}