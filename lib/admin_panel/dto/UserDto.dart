import 'package:freezed_annotation/freezed_annotation.dart';

part 'UserDto.freezed.dart';
part 'UserDto.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required int id,
    required String username,
    required String email,
    required String role,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}