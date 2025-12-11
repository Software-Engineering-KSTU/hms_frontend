import 'package:freezed_annotation/freezed_annotation.dart';

part 'PatientDto.freezed.dart';
part 'PatientDto.g.dart';

@freezed
abstract class PatientDto with _$PatientDto {
  const factory PatientDto({
    required int id,
    required String username,
    required String phoneNumber,
    String? address,
    String? birthDate,
  }) = _PatientDto;

  factory PatientDto.fromJson(Map<String, dynamic> json) =>
      _$PatientDtoFromJson(json);
}