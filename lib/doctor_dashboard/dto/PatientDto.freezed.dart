// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'PatientDto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PatientDto {

 int get id; String get username; String get phoneNumber; String? get address; String? get birthDate;
/// Create a copy of PatientDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatientDtoCopyWith<PatientDto> get copyWith => _$PatientDtoCopyWithImpl<PatientDto>(this as PatientDto, _$identity);

  /// Serializes this PatientDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatientDto&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.address, address) || other.address == address)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,phoneNumber,address,birthDate);

@override
String toString() {
  return 'PatientDto(id: $id, username: $username, phoneNumber: $phoneNumber, address: $address, birthDate: $birthDate)';
}


}

/// @nodoc
abstract mixin class $PatientDtoCopyWith<$Res>  {
  factory $PatientDtoCopyWith(PatientDto value, $Res Function(PatientDto) _then) = _$PatientDtoCopyWithImpl;
@useResult
$Res call({
 int id, String username, String phoneNumber, String? address, String? birthDate
});




}
/// @nodoc
class _$PatientDtoCopyWithImpl<$Res>
    implements $PatientDtoCopyWith<$Res> {
  _$PatientDtoCopyWithImpl(this._self, this._then);

  final PatientDto _self;
  final $Res Function(PatientDto) _then;

/// Create a copy of PatientDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? phoneNumber = null,Object? address = freezed,Object? birthDate = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PatientDto].
extension PatientDtoPatterns on PatientDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PatientDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PatientDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PatientDto value)  $default,){
final _that = this;
switch (_that) {
case _PatientDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PatientDto value)?  $default,){
final _that = this;
switch (_that) {
case _PatientDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String username,  String phoneNumber,  String? address,  String? birthDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PatientDto() when $default != null:
return $default(_that.id,_that.username,_that.phoneNumber,_that.address,_that.birthDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String username,  String phoneNumber,  String? address,  String? birthDate)  $default,) {final _that = this;
switch (_that) {
case _PatientDto():
return $default(_that.id,_that.username,_that.phoneNumber,_that.address,_that.birthDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String username,  String phoneNumber,  String? address,  String? birthDate)?  $default,) {final _that = this;
switch (_that) {
case _PatientDto() when $default != null:
return $default(_that.id,_that.username,_that.phoneNumber,_that.address,_that.birthDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PatientDto implements PatientDto {
  const _PatientDto({required this.id, required this.username, required this.phoneNumber, this.address, this.birthDate});
  factory _PatientDto.fromJson(Map<String, dynamic> json) => _$PatientDtoFromJson(json);

@override final  int id;
@override final  String username;
@override final  String phoneNumber;
@override final  String? address;
@override final  String? birthDate;

/// Create a copy of PatientDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatientDtoCopyWith<_PatientDto> get copyWith => __$PatientDtoCopyWithImpl<_PatientDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PatientDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatientDto&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.address, address) || other.address == address)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,phoneNumber,address,birthDate);

@override
String toString() {
  return 'PatientDto(id: $id, username: $username, phoneNumber: $phoneNumber, address: $address, birthDate: $birthDate)';
}


}

/// @nodoc
abstract mixin class _$PatientDtoCopyWith<$Res> implements $PatientDtoCopyWith<$Res> {
  factory _$PatientDtoCopyWith(_PatientDto value, $Res Function(_PatientDto) _then) = __$PatientDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String username, String phoneNumber, String? address, String? birthDate
});




}
/// @nodoc
class __$PatientDtoCopyWithImpl<$Res>
    implements _$PatientDtoCopyWith<$Res> {
  __$PatientDtoCopyWithImpl(this._self, this._then);

  final _PatientDto _self;
  final $Res Function(_PatientDto) _then;

/// Create a copy of PatientDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? phoneNumber = null,Object? address = freezed,Object? birthDate = freezed,}) {
  return _then(_PatientDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
