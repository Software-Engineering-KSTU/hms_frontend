// import 'package:hmsweb/base/BaseScreenModel.dart';
// import 'package:hmsweb/doctors_resume/dto/DoctorResumeDto.dart';
// import 'package:hmsweb/doctors_resume/rep/DoctorResumeRep.dart';
//
// import '../../patient_appointment/dashboard/dto/DoctorInfoDto.dart';
//
// class DoctorResumeModel extends BaseScreenModel {
//   final String idDoctor;
//
//   DoctorResumeModel({required this.idDoctor});
//
//   final _rep = DoctorResumeRep();
//
//   late final DoctorResumeDto doctorResume;
//   late final DoctorInfoDto doctorInfo;
//
//   @override
//   Future<void> onInitialization() async {
//     doctorResume = await _rep.getDoctorResume(idDoctor);
//     doctorInfo = await _rep.getDoctorById(idDoctor);
//   }
// }


import 'package:hmsweb/base/BaseScreenModel.dart';
import 'package:hmsweb/doctors_resume/dto/DoctorResumeDto.dart';
import 'package:hmsweb/doctors_resume/rep/DoctorResumeRep.dart';
import '../../patient_appointment/dashboard/dto/DoctorInfoDto.dart';

class DoctorResumeModel extends BaseScreenModel {
  final String idDoctor;

  DoctorResumeModel({required this.idDoctor});

  final _rep = DoctorResumeRep();

  // 1. Убираем late, ставим ? (может быть null)
  DoctorResumeDto? doctorResume;
  DoctorInfoDto? doctorInfo;

  @override
  Future<void> onInitialization() async {
    try {
      // Пытаемся получить инфо о враче
      doctorInfo = await _rep.getDoctorById(idDoctor);
    } catch (e) {
      print("Ошибка при загрузке инфо врача: $e");
    }

    try {
      // Пытаемся получить резюме. Если бэк вернет ошибку, мы попадем в catch
      doctorResume = await _rep.getDoctorResume(idDoctor);
    } catch (e) {
      print("Резюме не найдено или ошибка сети: $e");
      doctorResume = null; // Явно оставляем null
    }
  }
}