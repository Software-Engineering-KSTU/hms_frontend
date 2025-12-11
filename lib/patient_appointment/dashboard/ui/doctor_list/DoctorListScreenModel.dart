import 'package:hmsweb/base/BaseScreenModel.dart';
import 'package:hmsweb/patient_appointment/dashboard/dto/DoctorInfoDto.dart';

import '../../rep/PatientDashboardRep.dart';

class DoctorListScreenModel extends BaseScreenModel {

  final _rep = PatientDashboardRep();
  final List<DoctorInfoDto> doctors = [];

  @override
  Future<void> onInitialization() async {
    doctors.addAll(await _rep.fetchDoctors());
  }

}