import 'package:hmsweb/base/BaseScreenModel.dart';

class PatientProfileModel extends BaseScreenModel {
  final String fullName = "Иванов Иван Иванович";
  final String birthDate = "01.01.1990";
  final String avatar = "assets/images/doctor.jpg";

  @override
  Future<void> onInitialization() async {}
}
