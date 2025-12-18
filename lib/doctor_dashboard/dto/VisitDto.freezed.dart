// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'VisitDto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VisitDto {

 int? get id;// Nullable, так как при создании ID еще нет
 int get doctorId; int get patientId; String get visitDate;// ISO формат даты (LocalDateTime из Java)
 String? get symptoms;// Симптомы
 String? get diagnosis;// Диагноз
 String? get lifeAnamnesis;// Анамнез жизни
 String? get diseaseAnamnesis;// Анамнез болезни
 String? get initialExamination;// Первичный осмотр
 String? get stateDynamics;// Динамика состояния
 String? get labResults;// Лаб. результаты
 String? get instrumentalResults;// Инструментальные результаты
 String? get recommendations;// Рекомендации
 String? get medications;// Лекарства
 String? get dosage;// Дозировка
 String? get dischargeDate;// Дата выписки
 int? get treatmentDurationDays;
/// Create a copy of VisitDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VisitDtoCopyWith<VisitDto> get copyWith => _$VisitDtoCopyWithImpl<VisitDto>(this as VisitDto, _$identity);

  /// Serializes this VisitDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VisitDto&&(identical(other.id, id) || other.id == id)&&(identical(other.doctorId, doctorId) || other.doctorId == doctorId)&&(identical(other.patientId, patientId) || other.patientId == patientId)&&(identical(other.visitDate, visitDate) || other.visitDate == visitDate)&&(identical(other.symptoms, symptoms) || other.symptoms == symptoms)&&(identical(other.diagnosis, diagnosis) || other.diagnosis == diagnosis)&&(identical(other.lifeAnamnesis, lifeAnamnesis) || other.lifeAnamnesis == lifeAnamnesis)&&(identical(other.diseaseAnamnesis, diseaseAnamnesis) || other.diseaseAnamnesis == diseaseAnamnesis)&&(identical(other.initialExamination, initialExamination) || other.initialExamination == initialExamination)&&(identical(other.stateDynamics, stateDynamics) || other.stateDynamics == stateDynamics)&&(identical(other.labResults, labResults) || other.labResults == labResults)&&(identical(other.instrumentalResults, instrumentalResults) || other.instrumentalResults == instrumentalResults)&&(identical(other.recommendations, recommendations) || other.recommendations == recommendations)&&(identical(other.medications, medications) || other.medications == medications)&&(identical(other.dosage, dosage) || other.dosage == dosage)&&(identical(other.dischargeDate, dischargeDate) || other.dischargeDate == dischargeDate)&&(identical(other.treatmentDurationDays, treatmentDurationDays) || other.treatmentDurationDays == treatmentDurationDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,doctorId,patientId,visitDate,symptoms,diagnosis,lifeAnamnesis,diseaseAnamnesis,initialExamination,stateDynamics,labResults,instrumentalResults,recommendations,medications,dosage,dischargeDate,treatmentDurationDays);

@override
String toString() {
  return 'VisitDto(id: $id, doctorId: $doctorId, patientId: $patientId, visitDate: $visitDate, symptoms: $symptoms, diagnosis: $diagnosis, lifeAnamnesis: $lifeAnamnesis, diseaseAnamnesis: $diseaseAnamnesis, initialExamination: $initialExamination, stateDynamics: $stateDynamics, labResults: $labResults, instrumentalResults: $instrumentalResults, recommendations: $recommendations, medications: $medications, dosage: $dosage, dischargeDate: $dischargeDate, treatmentDurationDays: $treatmentDurationDays)';
}


}

/// @nodoc
abstract mixin class $VisitDtoCopyWith<$Res>  {
  factory $VisitDtoCopyWith(VisitDto value, $Res Function(VisitDto) _then) = _$VisitDtoCopyWithImpl;
@useResult
$Res call({
 int? id, int doctorId, int patientId, String visitDate, String? symptoms, String? diagnosis, String? lifeAnamnesis, String? diseaseAnamnesis, String? initialExamination, String? stateDynamics, String? labResults, String? instrumentalResults, String? recommendations, String? medications, String? dosage, String? dischargeDate, int? treatmentDurationDays
});




}
/// @nodoc
class _$VisitDtoCopyWithImpl<$Res>
    implements $VisitDtoCopyWith<$Res> {
  _$VisitDtoCopyWithImpl(this._self, this._then);

  final VisitDto _self;
  final $Res Function(VisitDto) _then;

/// Create a copy of VisitDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? doctorId = null,Object? patientId = null,Object? visitDate = null,Object? symptoms = freezed,Object? diagnosis = freezed,Object? lifeAnamnesis = freezed,Object? diseaseAnamnesis = freezed,Object? initialExamination = freezed,Object? stateDynamics = freezed,Object? labResults = freezed,Object? instrumentalResults = freezed,Object? recommendations = freezed,Object? medications = freezed,Object? dosage = freezed,Object? dischargeDate = freezed,Object? treatmentDurationDays = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,doctorId: null == doctorId ? _self.doctorId : doctorId // ignore: cast_nullable_to_non_nullable
as int,patientId: null == patientId ? _self.patientId : patientId // ignore: cast_nullable_to_non_nullable
as int,visitDate: null == visitDate ? _self.visitDate : visitDate // ignore: cast_nullable_to_non_nullable
as String,symptoms: freezed == symptoms ? _self.symptoms : symptoms // ignore: cast_nullable_to_non_nullable
as String?,diagnosis: freezed == diagnosis ? _self.diagnosis : diagnosis // ignore: cast_nullable_to_non_nullable
as String?,lifeAnamnesis: freezed == lifeAnamnesis ? _self.lifeAnamnesis : lifeAnamnesis // ignore: cast_nullable_to_non_nullable
as String?,diseaseAnamnesis: freezed == diseaseAnamnesis ? _self.diseaseAnamnesis : diseaseAnamnesis // ignore: cast_nullable_to_non_nullable
as String?,initialExamination: freezed == initialExamination ? _self.initialExamination : initialExamination // ignore: cast_nullable_to_non_nullable
as String?,stateDynamics: freezed == stateDynamics ? _self.stateDynamics : stateDynamics // ignore: cast_nullable_to_non_nullable
as String?,labResults: freezed == labResults ? _self.labResults : labResults // ignore: cast_nullable_to_non_nullable
as String?,instrumentalResults: freezed == instrumentalResults ? _self.instrumentalResults : instrumentalResults // ignore: cast_nullable_to_non_nullable
as String?,recommendations: freezed == recommendations ? _self.recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as String?,medications: freezed == medications ? _self.medications : medications // ignore: cast_nullable_to_non_nullable
as String?,dosage: freezed == dosage ? _self.dosage : dosage // ignore: cast_nullable_to_non_nullable
as String?,dischargeDate: freezed == dischargeDate ? _self.dischargeDate : dischargeDate // ignore: cast_nullable_to_non_nullable
as String?,treatmentDurationDays: freezed == treatmentDurationDays ? _self.treatmentDurationDays : treatmentDurationDays // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [VisitDto].
extension VisitDtoPatterns on VisitDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VisitDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VisitDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VisitDto value)  $default,){
final _that = this;
switch (_that) {
case _VisitDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VisitDto value)?  $default,){
final _that = this;
switch (_that) {
case _VisitDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int doctorId,  int patientId,  String visitDate,  String? symptoms,  String? diagnosis,  String? lifeAnamnesis,  String? diseaseAnamnesis,  String? initialExamination,  String? stateDynamics,  String? labResults,  String? instrumentalResults,  String? recommendations,  String? medications,  String? dosage,  String? dischargeDate,  int? treatmentDurationDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VisitDto() when $default != null:
return $default(_that.id,_that.doctorId,_that.patientId,_that.visitDate,_that.symptoms,_that.diagnosis,_that.lifeAnamnesis,_that.diseaseAnamnesis,_that.initialExamination,_that.stateDynamics,_that.labResults,_that.instrumentalResults,_that.recommendations,_that.medications,_that.dosage,_that.dischargeDate,_that.treatmentDurationDays);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int doctorId,  int patientId,  String visitDate,  String? symptoms,  String? diagnosis,  String? lifeAnamnesis,  String? diseaseAnamnesis,  String? initialExamination,  String? stateDynamics,  String? labResults,  String? instrumentalResults,  String? recommendations,  String? medications,  String? dosage,  String? dischargeDate,  int? treatmentDurationDays)  $default,) {final _that = this;
switch (_that) {
case _VisitDto():
return $default(_that.id,_that.doctorId,_that.patientId,_that.visitDate,_that.symptoms,_that.diagnosis,_that.lifeAnamnesis,_that.diseaseAnamnesis,_that.initialExamination,_that.stateDynamics,_that.labResults,_that.instrumentalResults,_that.recommendations,_that.medications,_that.dosage,_that.dischargeDate,_that.treatmentDurationDays);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int doctorId,  int patientId,  String visitDate,  String? symptoms,  String? diagnosis,  String? lifeAnamnesis,  String? diseaseAnamnesis,  String? initialExamination,  String? stateDynamics,  String? labResults,  String? instrumentalResults,  String? recommendations,  String? medications,  String? dosage,  String? dischargeDate,  int? treatmentDurationDays)?  $default,) {final _that = this;
switch (_that) {
case _VisitDto() when $default != null:
return $default(_that.id,_that.doctorId,_that.patientId,_that.visitDate,_that.symptoms,_that.diagnosis,_that.lifeAnamnesis,_that.diseaseAnamnesis,_that.initialExamination,_that.stateDynamics,_that.labResults,_that.instrumentalResults,_that.recommendations,_that.medications,_that.dosage,_that.dischargeDate,_that.treatmentDurationDays);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VisitDto implements VisitDto {
  const _VisitDto({this.id, required this.doctorId, required this.patientId, required this.visitDate, this.symptoms, this.diagnosis, this.lifeAnamnesis, this.diseaseAnamnesis, this.initialExamination, this.stateDynamics, this.labResults, this.instrumentalResults, this.recommendations, this.medications, this.dosage, this.dischargeDate, this.treatmentDurationDays});
  factory _VisitDto.fromJson(Map<String, dynamic> json) => _$VisitDtoFromJson(json);

@override final  int? id;
// Nullable, так как при создании ID еще нет
@override final  int doctorId;
@override final  int patientId;
@override final  String visitDate;
// ISO формат даты (LocalDateTime из Java)
@override final  String? symptoms;
// Симптомы
@override final  String? diagnosis;
// Диагноз
@override final  String? lifeAnamnesis;
// Анамнез жизни
@override final  String? diseaseAnamnesis;
// Анамнез болезни
@override final  String? initialExamination;
// Первичный осмотр
@override final  String? stateDynamics;
// Динамика состояния
@override final  String? labResults;
// Лаб. результаты
@override final  String? instrumentalResults;
// Инструментальные результаты
@override final  String? recommendations;
// Рекомендации
@override final  String? medications;
// Лекарства
@override final  String? dosage;
// Дозировка
@override final  String? dischargeDate;
// Дата выписки
@override final  int? treatmentDurationDays;

/// Create a copy of VisitDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VisitDtoCopyWith<_VisitDto> get copyWith => __$VisitDtoCopyWithImpl<_VisitDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VisitDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VisitDto&&(identical(other.id, id) || other.id == id)&&(identical(other.doctorId, doctorId) || other.doctorId == doctorId)&&(identical(other.patientId, patientId) || other.patientId == patientId)&&(identical(other.visitDate, visitDate) || other.visitDate == visitDate)&&(identical(other.symptoms, symptoms) || other.symptoms == symptoms)&&(identical(other.diagnosis, diagnosis) || other.diagnosis == diagnosis)&&(identical(other.lifeAnamnesis, lifeAnamnesis) || other.lifeAnamnesis == lifeAnamnesis)&&(identical(other.diseaseAnamnesis, diseaseAnamnesis) || other.diseaseAnamnesis == diseaseAnamnesis)&&(identical(other.initialExamination, initialExamination) || other.initialExamination == initialExamination)&&(identical(other.stateDynamics, stateDynamics) || other.stateDynamics == stateDynamics)&&(identical(other.labResults, labResults) || other.labResults == labResults)&&(identical(other.instrumentalResults, instrumentalResults) || other.instrumentalResults == instrumentalResults)&&(identical(other.recommendations, recommendations) || other.recommendations == recommendations)&&(identical(other.medications, medications) || other.medications == medications)&&(identical(other.dosage, dosage) || other.dosage == dosage)&&(identical(other.dischargeDate, dischargeDate) || other.dischargeDate == dischargeDate)&&(identical(other.treatmentDurationDays, treatmentDurationDays) || other.treatmentDurationDays == treatmentDurationDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,doctorId,patientId,visitDate,symptoms,diagnosis,lifeAnamnesis,diseaseAnamnesis,initialExamination,stateDynamics,labResults,instrumentalResults,recommendations,medications,dosage,dischargeDate,treatmentDurationDays);

@override
String toString() {
  return 'VisitDto(id: $id, doctorId: $doctorId, patientId: $patientId, visitDate: $visitDate, symptoms: $symptoms, diagnosis: $diagnosis, lifeAnamnesis: $lifeAnamnesis, diseaseAnamnesis: $diseaseAnamnesis, initialExamination: $initialExamination, stateDynamics: $stateDynamics, labResults: $labResults, instrumentalResults: $instrumentalResults, recommendations: $recommendations, medications: $medications, dosage: $dosage, dischargeDate: $dischargeDate, treatmentDurationDays: $treatmentDurationDays)';
}


}

/// @nodoc
abstract mixin class _$VisitDtoCopyWith<$Res> implements $VisitDtoCopyWith<$Res> {
  factory _$VisitDtoCopyWith(_VisitDto value, $Res Function(_VisitDto) _then) = __$VisitDtoCopyWithImpl;
@override @useResult
$Res call({
 int? id, int doctorId, int patientId, String visitDate, String? symptoms, String? diagnosis, String? lifeAnamnesis, String? diseaseAnamnesis, String? initialExamination, String? stateDynamics, String? labResults, String? instrumentalResults, String? recommendations, String? medications, String? dosage, String? dischargeDate, int? treatmentDurationDays
});




}
/// @nodoc
class __$VisitDtoCopyWithImpl<$Res>
    implements _$VisitDtoCopyWith<$Res> {
  __$VisitDtoCopyWithImpl(this._self, this._then);

  final _VisitDto _self;
  final $Res Function(_VisitDto) _then;

/// Create a copy of VisitDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? doctorId = null,Object? patientId = null,Object? visitDate = null,Object? symptoms = freezed,Object? diagnosis = freezed,Object? lifeAnamnesis = freezed,Object? diseaseAnamnesis = freezed,Object? initialExamination = freezed,Object? stateDynamics = freezed,Object? labResults = freezed,Object? instrumentalResults = freezed,Object? recommendations = freezed,Object? medications = freezed,Object? dosage = freezed,Object? dischargeDate = freezed,Object? treatmentDurationDays = freezed,}) {
  return _then(_VisitDto(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,doctorId: null == doctorId ? _self.doctorId : doctorId // ignore: cast_nullable_to_non_nullable
as int,patientId: null == patientId ? _self.patientId : patientId // ignore: cast_nullable_to_non_nullable
as int,visitDate: null == visitDate ? _self.visitDate : visitDate // ignore: cast_nullable_to_non_nullable
as String,symptoms: freezed == symptoms ? _self.symptoms : symptoms // ignore: cast_nullable_to_non_nullable
as String?,diagnosis: freezed == diagnosis ? _self.diagnosis : diagnosis // ignore: cast_nullable_to_non_nullable
as String?,lifeAnamnesis: freezed == lifeAnamnesis ? _self.lifeAnamnesis : lifeAnamnesis // ignore: cast_nullable_to_non_nullable
as String?,diseaseAnamnesis: freezed == diseaseAnamnesis ? _self.diseaseAnamnesis : diseaseAnamnesis // ignore: cast_nullable_to_non_nullable
as String?,initialExamination: freezed == initialExamination ? _self.initialExamination : initialExamination // ignore: cast_nullable_to_non_nullable
as String?,stateDynamics: freezed == stateDynamics ? _self.stateDynamics : stateDynamics // ignore: cast_nullable_to_non_nullable
as String?,labResults: freezed == labResults ? _self.labResults : labResults // ignore: cast_nullable_to_non_nullable
as String?,instrumentalResults: freezed == instrumentalResults ? _self.instrumentalResults : instrumentalResults // ignore: cast_nullable_to_non_nullable
as String?,recommendations: freezed == recommendations ? _self.recommendations : recommendations // ignore: cast_nullable_to_non_nullable
as String?,medications: freezed == medications ? _self.medications : medications // ignore: cast_nullable_to_non_nullable
as String?,dosage: freezed == dosage ? _self.dosage : dosage // ignore: cast_nullable_to_non_nullable
as String?,dischargeDate: freezed == dischargeDate ? _self.dischargeDate : dischargeDate // ignore: cast_nullable_to_non_nullable
as String?,treatmentDurationDays: freezed == treatmentDurationDays ? _self.treatmentDurationDays : treatmentDurationDays // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
