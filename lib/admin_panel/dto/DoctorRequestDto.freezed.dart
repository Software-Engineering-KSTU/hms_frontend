// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'DoctorRequestDto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DoctorRequestDto {

 String get username; String get email; String get password; String get specialization; String get phoneNumber;// Используем String для даты (формат yyyy-MM-dd), так как это проще для передачи в JSON
@JsonKey(name: 'dateOfBirth') String get dateOfBirth;
/// Create a copy of DoctorRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoctorRequestDtoCopyWith<DoctorRequestDto> get copyWith => _$DoctorRequestDtoCopyWithImpl<DoctorRequestDto>(this as DoctorRequestDto, _$identity);

  /// Serializes this DoctorRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoctorRequestDto&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.specialization, specialization) || other.specialization == specialization)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,email,password,specialization,phoneNumber,dateOfBirth);

@override
String toString() {
  return 'DoctorRequestDto(username: $username, email: $email, password: $password, specialization: $specialization, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth)';
}


}

/// @nodoc
abstract mixin class $DoctorRequestDtoCopyWith<$Res>  {
  factory $DoctorRequestDtoCopyWith(DoctorRequestDto value, $Res Function(DoctorRequestDto) _then) = _$DoctorRequestDtoCopyWithImpl;
@useResult
$Res call({
 String username, String email, String password, String specialization, String phoneNumber,@JsonKey(name: 'dateOfBirth') String dateOfBirth
});




}
/// @nodoc
class _$DoctorRequestDtoCopyWithImpl<$Res>
    implements $DoctorRequestDtoCopyWith<$Res> {
  _$DoctorRequestDtoCopyWithImpl(this._self, this._then);

  final DoctorRequestDto _self;
  final $Res Function(DoctorRequestDto) _then;

/// Create a copy of DoctorRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,Object? email = null,Object? password = null,Object? specialization = null,Object? phoneNumber = null,Object? dateOfBirth = null,}) {
  return _then(_self.copyWith(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,specialization: null == specialization ? _self.specialization : specialization // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,dateOfBirth: null == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DoctorRequestDto].
extension DoctorRequestDtoPatterns on DoctorRequestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DoctorRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DoctorRequestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DoctorRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _DoctorRequestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DoctorRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _DoctorRequestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String username,  String email,  String password,  String specialization,  String phoneNumber, @JsonKey(name: 'dateOfBirth')  String dateOfBirth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DoctorRequestDto() when $default != null:
return $default(_that.username,_that.email,_that.password,_that.specialization,_that.phoneNumber,_that.dateOfBirth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String username,  String email,  String password,  String specialization,  String phoneNumber, @JsonKey(name: 'dateOfBirth')  String dateOfBirth)  $default,) {final _that = this;
switch (_that) {
case _DoctorRequestDto():
return $default(_that.username,_that.email,_that.password,_that.specialization,_that.phoneNumber,_that.dateOfBirth);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String username,  String email,  String password,  String specialization,  String phoneNumber, @JsonKey(name: 'dateOfBirth')  String dateOfBirth)?  $default,) {final _that = this;
switch (_that) {
case _DoctorRequestDto() when $default != null:
return $default(_that.username,_that.email,_that.password,_that.specialization,_that.phoneNumber,_that.dateOfBirth);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DoctorRequestDto implements DoctorRequestDto {
  const _DoctorRequestDto({required this.username, required this.email, required this.password, required this.specialization, required this.phoneNumber, @JsonKey(name: 'dateOfBirth') required this.dateOfBirth});
  factory _DoctorRequestDto.fromJson(Map<String, dynamic> json) => _$DoctorRequestDtoFromJson(json);

@override final  String username;
@override final  String email;
@override final  String password;
@override final  String specialization;
@override final  String phoneNumber;
// Используем String для даты (формат yyyy-MM-dd), так как это проще для передачи в JSON
@override@JsonKey(name: 'dateOfBirth') final  String dateOfBirth;

/// Create a copy of DoctorRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DoctorRequestDtoCopyWith<_DoctorRequestDto> get copyWith => __$DoctorRequestDtoCopyWithImpl<_DoctorRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DoctorRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DoctorRequestDto&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.specialization, specialization) || other.specialization == specialization)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,username,email,password,specialization,phoneNumber,dateOfBirth);

@override
String toString() {
  return 'DoctorRequestDto(username: $username, email: $email, password: $password, specialization: $specialization, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth)';
}


}

/// @nodoc
abstract mixin class _$DoctorRequestDtoCopyWith<$Res> implements $DoctorRequestDtoCopyWith<$Res> {
  factory _$DoctorRequestDtoCopyWith(_DoctorRequestDto value, $Res Function(_DoctorRequestDto) _then) = __$DoctorRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String username, String email, String password, String specialization, String phoneNumber,@JsonKey(name: 'dateOfBirth') String dateOfBirth
});




}
/// @nodoc
class __$DoctorRequestDtoCopyWithImpl<$Res>
    implements _$DoctorRequestDtoCopyWith<$Res> {
  __$DoctorRequestDtoCopyWithImpl(this._self, this._then);

  final _DoctorRequestDto _self;
  final $Res Function(_DoctorRequestDto) _then;

/// Create a copy of DoctorRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,Object? email = null,Object? password = null,Object? specialization = null,Object? phoneNumber = null,Object? dateOfBirth = null,}) {
  return _then(_DoctorRequestDto(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,specialization: null == specialization ? _self.specialization : specialization // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,dateOfBirth: null == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
