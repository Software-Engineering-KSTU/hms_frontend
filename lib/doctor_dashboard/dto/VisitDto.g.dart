// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VisitDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VisitDto _$VisitDtoFromJson(Map<String, dynamic> json) => _VisitDto(
  id: (json['id'] as num?)?.toInt(),
  doctorId: (json['doctorId'] as num).toInt(),
  patientId: (json['patientId'] as num).toInt(),
  visitDate: json['visitDate'] as String,
  symptoms: json['symptoms'] as String?,
  diagnosis: json['diagnosis'] as String?,
  lifeAnamnesis: json['lifeAnamnesis'] as String?,
  diseaseAnamnesis: json['diseaseAnamnesis'] as String?,
  initialExamination: json['initialExamination'] as String?,
  stateDynamics: json['stateDynamics'] as String?,
  labResults: json['labResults'] as String?,
  instrumentalResults: json['instrumentalResults'] as String?,
  recommendations: json['recommendations'] as String?,
  medications: json['medications'] as String?,
  dosage: json['dosage'] as String?,
  dischargeDate: json['dischargeDate'] as String?,
  treatmentDurationDays: (json['treatmentDurationDays'] as num?)?.toInt(),
);

Map<String, dynamic> _$VisitDtoToJson(_VisitDto instance) => <String, dynamic>{
  'id': instance.id,
  'doctorId': instance.doctorId,
  'patientId': instance.patientId,
  'visitDate': instance.visitDate,
  'symptoms': instance.symptoms,
  'diagnosis': instance.diagnosis,
  'lifeAnamnesis': instance.lifeAnamnesis,
  'diseaseAnamnesis': instance.diseaseAnamnesis,
  'initialExamination': instance.initialExamination,
  'stateDynamics': instance.stateDynamics,
  'labResults': instance.labResults,
  'instrumentalResults': instance.instrumentalResults,
  'recommendations': instance.recommendations,
  'medications': instance.medications,
  'dosage': instance.dosage,
  'dischargeDate': instance.dischargeDate,
  'treatmentDurationDays': instance.treatmentDurationDays,
};
