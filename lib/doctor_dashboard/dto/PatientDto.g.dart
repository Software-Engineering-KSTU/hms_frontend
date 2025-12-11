// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PatientDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PatientDto _$PatientDtoFromJson(Map<String, dynamic> json) => _PatientDto(
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  phoneNumber: json['phoneNumber'] as String,
  address: json['address'] as String?,
  birthDate: json['birthDate'] as String?,
);

Map<String, dynamic> _$PatientDtoToJson(_PatientDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      'birthDate': instance.birthDate,
    };
