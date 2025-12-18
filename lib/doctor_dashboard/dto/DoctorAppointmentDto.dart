import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hmsweb/doctor_dashboard/dto/PatientDto.dart';

part 'DoctorAppointmentDto.freezed.dart';
part 'DoctorAppointmentDto.g.dart';

@freezed
abstract class DoctorAppointmentDto with _$DoctorAppointmentDto {
  const factory DoctorAppointmentDto({
    required int id,
    required PatientDto patient,
    required String dateTime,
    String? status,
    String? symptomsDescribedByPatient,
    String? selfTreatmentMethodsTaken,
  }) = _DoctorAppointmentDto;

  factory DoctorAppointmentDto.fromJson(Map<String, dynamic> json) =>
      _$DoctorAppointmentDtoFromJson(json);
}