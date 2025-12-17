// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'DoctorResumeDto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DoctorResumeDto {

 int get id; int get doctorId; String get stage; int get experienceYears; String get education; String get certificates; String? get photoUrl; String get description;
/// Create a copy of DoctorResumeDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoctorResumeDtoCopyWith<DoctorResumeDto> get copyWith => _$DoctorResumeDtoCopyWithImpl<DoctorResumeDto>(this as DoctorResumeDto, _$identity);

  /// Serializes this DoctorResumeDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorResumeDto&&(identical(other.id, id) || other.id == id)&&(identical(other.doctorId, doctorId) || other.doctorId == doctorId)&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.experienceYears, experienceYears) || other.experienceYears == experienceYears)&&(identical(other.education, education) || other.education == education)&&(identical(other.certificates, certificates) || other.certificates == certificates)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,doctorId,stage,experienceYears,education,certificates,photoUrl,description);

@override
String toString() {
  return 'DoctorResumeDto(id: $id, doctorId: $doctorId, stage: $stage, experienceYears: $experienceYears, education: $education, certificates: $certificates, photoUrl: $photoUrl, description: $description)';
}


}

/// @nodoc
abstract mixin class $DoctorResumeDtoCopyWith<$Res>  {
  factory $DoctorResumeDtoCopyWith(DoctorResumeDto value, $Res Function(DoctorResumeDto) _then) = _$DoctorResumeDtoCopyWithImpl;
@useResult
$Res call({
 int id, int doctorId, String stage, int experienceYears, String education, String certificates, String? photoUrl, String description
});




}
/// @nodoc
class _$DoctorResumeDtoCopyWithImpl<$Res>
    implements $DoctorResumeDtoCopyWith<$Res> {
  _$DoctorResumeDtoCopyWithImpl(this._self, this._then);

  final DoctorResumeDto _self;
  final $Res Function(DoctorResumeDto) _then;

/// Create a copy of DoctorResumeDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? doctorId = null,Object? stage = null,Object? experienceYears = null,Object? education = null,Object? certificates = null,Object? photoUrl = freezed,Object? description = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,doctorId: null == doctorId ? _self.doctorId : doctorId // ignore: cast_nullable_to_non_nullable
as int,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as String,experienceYears: null == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int,education: null == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as String,certificates: null == certificates ? _self.certificates : certificates // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DoctorResumeDto].
extension DoctorResumeDtoPatterns on DoctorResumeDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DoctorResumeDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DoctorResumeDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DoctorResumeDto value)  $default,){
final _that = this;
switch (_that) {
case _DoctorResumeDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DoctorResumeDto value)?  $default,){
final _that = this;
switch (_that) {
case _DoctorResumeDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int doctorId,  String stage,  int experienceYears,  String education,  String certificates,  String? photoUrl,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DoctorResumeDto() when $default != null:
return $default(_that.id,_that.doctorId,_that.stage,_that.experienceYears,_that.education,_that.certificates,_that.photoUrl,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int doctorId,  String stage,  int experienceYears,  String education,  String certificates,  String? photoUrl,  String description)  $default,) {final _that = this;
switch (_that) {
case _DoctorResumeDto():
return $default(_that.id,_that.doctorId,_that.stage,_that.experienceYears,_that.education,_that.certificates,_that.photoUrl,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int doctorId,  String stage,  int experienceYears,  String education,  String certificates,  String? photoUrl,  String description)?  $default,) {final _that = this;
switch (_that) {
case _DoctorResumeDto() when $default != null:
return $default(_that.id,_that.doctorId,_that.stage,_that.experienceYears,_that.education,_that.certificates,_that.photoUrl,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DoctorResumeDto implements DoctorResumeDto {
  const _DoctorResumeDto({required this.id, required this.doctorId, required this.stage, required this.experienceYears, required this.education, required this.certificates, this.photoUrl, required this.description});
  factory _DoctorResumeDto.fromJson(Map<String, dynamic> json) => _$DoctorResumeDtoFromJson(json);

@override final  int id;
@override final  int doctorId;
@override final  String stage;
@override final  int experienceYears;
@override final  String education;
@override final  String certificates;
@override final  String? photoUrl;
@override final  String description;

/// Create a copy of DoctorResumeDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DoctorResumeDtoCopyWith<_DoctorResumeDto> get copyWith => __$DoctorResumeDtoCopyWithImpl<_DoctorResumeDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DoctorResumeDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DoctorResumeDto&&(identical(other.id, id) || other.id == id)&&(identical(other.doctorId, doctorId) || other.doctorId == doctorId)&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.experienceYears, experienceYears) || other.experienceYears == experienceYears)&&(identical(other.education, education) || other.education == education)&&(identical(other.certificates, certificates) || other.certificates == certificates)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,doctorId,stage,experienceYears,education,certificates,photoUrl,description);

@override
String toString() {
  return 'DoctorResumeDto(id: $id, doctorId: $doctorId, stage: $stage, experienceYears: $experienceYears, education: $education, certificates: $certificates, photoUrl: $photoUrl, description: $description)';
}


}

/// @nodoc
abstract mixin class _$DoctorResumeDtoCopyWith<$Res> implements $DoctorResumeDtoCopyWith<$Res> {
  factory _$DoctorResumeDtoCopyWith(_DoctorResumeDto value, $Res Function(_DoctorResumeDto) _then) = __$DoctorResumeDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, int doctorId, String stage, int experienceYears, String education, String certificates, String? photoUrl, String description
});




}
/// @nodoc
class __$DoctorResumeDtoCopyWithImpl<$Res>
    implements _$DoctorResumeDtoCopyWith<$Res> {
  __$DoctorResumeDtoCopyWithImpl(this._self, this._then);

  final _DoctorResumeDto _self;
  final $Res Function(_DoctorResumeDto) _then;

/// Create a copy of DoctorResumeDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? doctorId = null,Object? stage = null,Object? experienceYears = null,Object? education = null,Object? certificates = null,Object? photoUrl = freezed,Object? description = null,}) {
  return _then(_DoctorResumeDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,doctorId: null == doctorId ? _self.doctorId : doctorId // ignore: cast_nullable_to_non_nullable
as int,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as String,experienceYears: null == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int,education: null == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as String,certificates: null == certificates ? _self.certificates : certificates // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
