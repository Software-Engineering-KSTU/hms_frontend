// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserDto _$UserDtoFromJson(Map<String, dynamic> json) => _UserDto(
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  email: json['email'] as String,
  role: json['role'] as String,
);

Map<String, dynamic> _$UserDtoToJson(_UserDto instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'email': instance.email,
  'role': instance.role,
};
