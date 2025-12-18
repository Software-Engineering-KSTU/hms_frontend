// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DoctorAppointmentDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DoctorAppointmentDto _$DoctorAppointmentDtoFromJson(
  Map<String, dynamic> json,
) => _DoctorAppointmentDto(
  id: (json['id'] as num).toInt(),
  patient: PatientDto.fromJson(json['patient'] as Map<String, dynamic>),
  dateTime: json['dateTime'] as String,
  status: json['status'] as String?,
  symptomsDescribedByPatient: json['symptomsDescribedByPatient'] as String?,
  selfTreatmentMethodsTaken: json['selfTreatmentMethodsTaken'] as String?,
);

Map<String, dynamic> _$DoctorAppointmentDtoToJson(
  _DoctorAppointmentDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'patient': instance.patient,
  'dateTime': instance.dateTime,
  'status': instance.status,
  'symptomsDescribedByPatient': instance.symptomsDescribedByPatient,
  'selfTreatmentMethodsTaken': instance.selfTreatmentMethodsTaken,
};
