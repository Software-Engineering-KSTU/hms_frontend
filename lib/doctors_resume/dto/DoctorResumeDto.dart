import 'package:freezed_annotation/freezed_annotation.dart';

part 'DoctorResumeDto.freezed.dart';
part 'DoctorResumeDto.g.dart';

@freezed
abstract class DoctorResumeDto with _$DoctorResumeDto {

  const factory DoctorResumeDto ({
    required int id,
    required int doctorId,
    required String stage,
    required int experienceYears,
    required String education,
    required String certificates,
    required String photoUrl,
    required String description,
}) = _DoctorResumeDto;

  factory DoctorResumeDto.fromJson(Map<String, dynamic> json) =>
      _$DoctorResumeDtoFromJson(json);

}