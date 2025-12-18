// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DoctorResumeDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DoctorResumeDto _$DoctorResumeDtoFromJson(Map<String, dynamic> json) =>
    _DoctorResumeDto(
      id: (json['id'] as num).toInt(),
      doctorId: (json['doctorId'] as num).toInt(),
      stage: json['stage'] as String,
      experienceYears: (json['experienceYears'] as num).toInt(),
      education: json['education'] as String,
      certificates: json['certificates'] as String,
      photoUrl: json['photoUrl'] as String?,
      description: json['description'] as String,
    );

Map<String, dynamic> _$DoctorResumeDtoToJson(_DoctorResumeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctorId': instance.doctorId,
      'stage': instance.stage,
      'experienceYears': instance.experienceYears,
      'education': instance.education,
      'certificates': instance.certificates,
      'photoUrl': instance.photoUrl,
      'description': instance.description,
    };
