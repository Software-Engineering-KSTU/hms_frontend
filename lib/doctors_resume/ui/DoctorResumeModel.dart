import 'package:hmsweb/base/BaseScreenModel.dart';
import 'package:hmsweb/doctors_resume/dto/DoctorResumeDto.dart';
import 'package:hmsweb/doctors_resume/rep/DoctorResumeRep.dart';

import '../../patient_appointment/dashboard/dto/DoctorInfoDto.dart';

class DoctorResumeModel extends BaseScreenModel {
  final String idDoctor;

  DoctorResumeModel({required this.idDoctor});

  final _rep = DoctorResumeRep();

  late final DoctorResumeDto doctorResume;
  late final DoctorInfoDto doctorInfo;

  @override
  Future<void> onInitialization() async {
    doctorResume = await _rep.getDoctorResume(idDoctor);
    doctorInfo = await _rep.getDoctorById(idDoctor);
  }
}
