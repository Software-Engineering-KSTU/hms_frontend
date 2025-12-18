// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DoctorRequestDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DoctorRequestDto _$DoctorRequestDtoFromJson(Map<String, dynamic> json) =>
    _DoctorRequestDto(
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      specialization: json['specialization'] as String,
      phoneNumber: json['phoneNumber'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
    );

Map<String, dynamic> _$DoctorRequestDtoToJson(_DoctorRequestDto instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'specialization': instance.specialization,
      'phoneNumber': instance.phoneNumber,
      'dateOfBirth': instance.dateOfBirth,
    };
