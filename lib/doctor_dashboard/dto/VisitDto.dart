import 'package:freezed_annotation/freezed_annotation.dart';

part 'VisitDto.freezed.dart';
part 'VisitDto.g.dart';

@freezed
abstract class VisitDto with _$VisitDto {
  const factory VisitDto({
    int? id, // Nullable, так как при создании ID еще нет
    required int doctorId,
    required int patientId,
    required String visitDate, // ISO формат даты (LocalDateTime из Java)

    String? symptoms, // Симптомы
    String? diagnosis, // Диагноз
    String? lifeAnamnesis, // Анамнез жизни
    String? diseaseAnamnesis, // Анамнез болезни
    String? initialExamination, // Первичный осмотр
    String? stateDynamics, // Динамика состояния
    String? labResults, // Лаб. результаты
    String? instrumentalResults, // Инструментальные результаты
    String? recommendations, // Рекомендации

    String? medications, // Лекарства
    String? dosage, // Дозировка

    String? dischargeDate, // Дата выписки
    int? treatmentDurationDays, // Длительность лечения
  }) = _VisitDto;

  factory VisitDto.fromJson(Map<String, dynamic> json) =>
      _$VisitDtoFromJson(json);
}