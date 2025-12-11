// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'DoctorAppointmentDto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DoctorAppointmentDto {

 int get id; PatientDto get patient; String get dateTime; String get status; String? get symptomsDescribedByPatient; String? get selfTreatmentMethodsTaken;
/// Create a copy of DoctorAppointmentDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoctorAppointmentDtoCopyWith<DoctorAppointmentDto> get copyWith => _$DoctorAppointmentDtoCopyWithImpl<DoctorAppointmentDto>(this as DoctorAppointmentDto, _$identity);

  /// Serializes this DoctorAppointmentDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorAppointmentDto&&(identical(other.id, id) || other.id == id)&&(identical(other.patient, patient) || other.patient == patient)&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.status, status) || other.status == status)&&(identical(other.symptomsDescribedByPatient, symptomsDescribedByPatient) || other.symptomsDescribedByPatient == symptomsDescribedByPatient)&&(identical(other.selfTreatmentMethodsTaken, selfTreatmentMethodsTaken) || other.selfTreatmentMethodsTaken == selfTreatmentMethodsTaken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,patient,dateTime,status,symptomsDescribedByPatient,selfTreatmentMethodsTaken);

@override
String toString() {
  return 'DoctorAppointmentDto(id: $id, patient: $patient, dateTime: $dateTime, status: $status, symptomsDescribedByPatient: $symptomsDescribedByPatient, selfTreatmentMethodsTaken: $selfTreatmentMethodsTaken)';
}


}

/// @nodoc
abstract mixin class $DoctorAppointmentDtoCopyWith<$Res>  {
  factory $DoctorAppointmentDtoCopyWith(DoctorAppointmentDto value, $Res Function(DoctorAppointmentDto) _then) = _$DoctorAppointmentDtoCopyWithImpl;
@useResult
$Res call({
 int id, PatientDto patient, String dateTime, String status, String? symptomsDescribedByPatient, String? selfTreatmentMethodsTaken
});


$PatientDtoCopyWith<$Res> get patient;

}
/// @nodoc
class _$DoctorAppointmentDtoCopyWithImpl<$Res>
    implements $DoctorAppointmentDtoCopyWith<$Res> {
  _$DoctorAppointmentDtoCopyWithImpl(this._self, this._then);

  final DoctorAppointmentDto _self;
  final $Res Function(DoctorAppointmentDto) _then;

/// Create a copy of DoctorAppointmentDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? patient = null,Object? dateTime = null,Object? status = null,Object? symptomsDescribedByPatient = freezed,Object? selfTreatmentMethodsTaken = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,patient: null == patient ? _self.patient : patient // ignore: cast_nullable_to_non_nullable
as PatientDto,dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,symptomsDescribedByPatient: freezed == symptomsDescribedByPatient ? _self.symptomsDescribedByPatient : symptomsDescribedByPatient // ignore: cast_nullable_to_non_nullable
as String?,selfTreatmentMethodsTaken: freezed == selfTreatmentMethodsTaken ? _self.selfTreatmentMethodsTaken : selfTreatmentMethodsTaken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of DoctorAppointmentDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PatientDtoCopyWith<$Res> get patient {
  
  return $PatientDtoCopyWith<$Res>(_self.patient, (value) {
    return _then(_self.copyWith(patient: value));
  });
}
}


/// Adds pattern-matching-related methods to [DoctorAppointmentDto].
extension DoctorAppointmentDtoPatterns on DoctorAppointmentDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DoctorAppointmentDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DoctorAppointmentDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DoctorAppointmentDto value)  $default,){
final _that = this;
switch (_that) {
case _DoctorAppointmentDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DoctorAppointmentDto value)?  $default,){
final _that = this;
switch (_that) {
case _DoctorAppointmentDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  PatientDto patient,  String dateTime,  String status,  String? symptomsDescribedByPatient,  String? selfTreatmentMethodsTaken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DoctorAppointmentDto() when $default != null:
return $default(_that.id,_that.patient,_that.dateTime,_that.status,_that.symptomsDescribedByPatient,_that.selfTreatmentMethodsTaken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  PatientDto patient,  String dateTime,  String status,  String? symptomsDescribedByPatient,  String? selfTreatmentMethodsTaken)  $default,) {final _that = this;
switch (_that) {
case _DoctorAppointmentDto():
return $default(_that.id,_that.patient,_that.dateTime,_that.status,_that.symptomsDescribedByPatient,_that.selfTreatmentMethodsTaken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  PatientDto patient,  String dateTime,  String status,  String? symptomsDescribedByPatient,  String? selfTreatmentMethodsTaken)?  $default,) {final _that = this;
switch (_that) {
case _DoctorAppointmentDto() when $default != null:
return $default(_that.id,_that.patient,_that.dateTime,_that.status,_that.symptomsDescribedByPatient,_that.selfTreatmentMethodsTaken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DoctorAppointmentDto implements DoctorAppointmentDto {
  const _DoctorAppointmentDto({required this.id, required this.patient, required this.dateTime, required this.status, this.symptomsDescribedByPatient, this.selfTreatmentMethodsTaken});
  factory _DoctorAppointmentDto.fromJson(Map<String, dynamic> json) => _$DoctorAppointmentDtoFromJson(json);

@override final  int id;
@override final  PatientDto patient;
@override final  String dateTime;
@override final  String status;
@override final  String? symptomsDescribedByPatient;
@override final  String? selfTreatmentMethodsTaken;

/// Create a copy of DoctorAppointmentDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DoctorAppointmentDtoCopyWith<_DoctorAppointmentDto> get copyWith => __$DoctorAppointmentDtoCopyWithImpl<_DoctorAppointmentDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DoctorAppointmentDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DoctorAppointmentDto&&(identical(other.id, id) || other.id == id)&&(identical(other.patient, patient) || other.patient == patient)&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.status, status) || other.status == status)&&(identical(other.symptomsDescribedByPatient, symptomsDescribedByPatient) || other.symptomsDescribedByPatient == symptomsDescribedByPatient)&&(identical(other.selfTreatmentMethodsTaken, selfTreatmentMethodsTaken) || other.selfTreatmentMethodsTaken == selfTreatmentMethodsTaken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,patient,dateTime,status,symptomsDescribedByPatient,selfTreatmentMethodsTaken);

@override
String toString() {
  return 'DoctorAppointmentDto(id: $id, patient: $patient, dateTime: $dateTime, status: $status, symptomsDescribedByPatient: $symptomsDescribedByPatient, selfTreatmentMethodsTaken: $selfTreatmentMethodsTaken)';
}


}

/// @nodoc
abstract mixin class _$DoctorAppointmentDtoCopyWith<$Res> implements $DoctorAppointmentDtoCopyWith<$Res> {
  factory _$DoctorAppointmentDtoCopyWith(_DoctorAppointmentDto value, $Res Function(_DoctorAppointmentDto) _then) = __$DoctorAppointmentDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, PatientDto patient, String dateTime, String status, String? symptomsDescribedByPatient, String? selfTreatmentMethodsTaken
});


@override $PatientDtoCopyWith<$Res> get patient;

}
/// @nodoc
class __$DoctorAppointmentDtoCopyWithImpl<$Res>
    implements _$DoctorAppointmentDtoCopyWith<$Res> {
  __$DoctorAppointmentDtoCopyWithImpl(this._self, this._then);

  final _DoctorAppointmentDto _self;
  final $Res Function(_DoctorAppointmentDto) _then;

/// Create a copy of DoctorAppointmentDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? patient = null,Object? dateTime = null,Object? status = null,Object? symptomsDescribedByPatient = freezed,Object? selfTreatmentMethodsTaken = freezed,}) {
  return _then(_DoctorAppointmentDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,patient: null == patient ? _self.patient : patient // ignore: cast_nullable_to_non_nullable
as PatientDto,dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,symptomsDescribedByPatient: freezed == symptomsDescribedByPatient ? _self.symptomsDescribedByPatient : symptomsDescribedByPatient // ignore: cast_nullable_to_non_nullable
as String?,selfTreatmentMethodsTaken: freezed == selfTreatmentMethodsTaken ? _self.selfTreatmentMethodsTaken : selfTreatmentMethodsTaken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of DoctorAppointmentDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PatientDtoCopyWith<$Res> get patient {
  
  return $PatientDtoCopyWith<$Res>(_self.patient, (value) {
    return _then(_self.copyWith(patient: value));
  });
}
}

// dart format on
