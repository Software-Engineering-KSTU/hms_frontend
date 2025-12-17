import 'package:freezed_annotation/freezed_annotation.dart';

part 'DoctorRequestDto.freezed.dart';
part 'DoctorRequestDto.g.dart';

@freezed
class DoctorRequestDto with _$DoctorRequestDto {
  const factory DoctorRequestDto({
    required String username,
    required String email,
    required String password,
    required String specialization,
    required String phoneNumber,
    // Используем String для даты (формат yyyy-MM-dd), так как это проще для передачи в JSON
    @JsonKey(name: 'dateOfBirth') required String dateOfBirth,
  }) = _DoctorRequestDto;

  factory DoctorRequestDto.fromJson(Map<String, dynamic> json) => _$DoctorRequestDtoFromJson(json);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}