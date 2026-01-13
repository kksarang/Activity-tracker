// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettlementModel {

 String get id; String get payerId; String get receiverId; double get amount; String? get groupId; int get date;// Timestamp
 String get method;
/// Create a copy of SettlementModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettlementModelCopyWith<SettlementModel> get copyWith => _$SettlementModelCopyWithImpl<SettlementModel>(this as SettlementModel, _$identity);

  /// Serializes this SettlementModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettlementModel&&(identical(other.id, id) || other.id == id)&&(identical(other.payerId, payerId) || other.payerId == payerId)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.date, date) || other.date == date)&&(identical(other.method, method) || other.method == method));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,payerId,receiverId,amount,groupId,date,method);

@override
String toString() {
  return 'SettlementModel(id: $id, payerId: $payerId, receiverId: $receiverId, amount: $amount, groupId: $groupId, date: $date, method: $method)';
}


}

/// @nodoc
abstract mixin class $SettlementModelCopyWith<$Res>  {
  factory $SettlementModelCopyWith(SettlementModel value, $Res Function(SettlementModel) _then) = _$SettlementModelCopyWithImpl;
@useResult
$Res call({
 String id, String payerId, String receiverId, double amount, String? groupId, int date, String method
});




}
/// @nodoc
class _$SettlementModelCopyWithImpl<$Res>
    implements $SettlementModelCopyWith<$Res> {
  _$SettlementModelCopyWithImpl(this._self, this._then);

  final SettlementModel _self;
  final $Res Function(SettlementModel) _then;

/// Create a copy of SettlementModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? payerId = null,Object? receiverId = null,Object? amount = null,Object? groupId = freezed,Object? date = null,Object? method = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,payerId: null == payerId ? _self.payerId : payerId // ignore: cast_nullable_to_non_nullable
as String,receiverId: null == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as int,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SettlementModel].
extension SettlementModelPatterns on SettlementModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettlementModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettlementModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettlementModel value)  $default,){
final _that = this;
switch (_that) {
case _SettlementModel():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettlementModel value)?  $default,){
final _that = this;
switch (_that) {
case _SettlementModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String payerId,  String receiverId,  double amount,  String? groupId,  int date,  String method)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettlementModel() when $default != null:
return $default(_that.id,_that.payerId,_that.receiverId,_that.amount,_that.groupId,_that.date,_that.method);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String payerId,  String receiverId,  double amount,  String? groupId,  int date,  String method)  $default,) {final _that = this;
switch (_that) {
case _SettlementModel():
return $default(_that.id,_that.payerId,_that.receiverId,_that.amount,_that.groupId,_that.date,_that.method);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String payerId,  String receiverId,  double amount,  String? groupId,  int date,  String method)?  $default,) {final _that = this;
switch (_that) {
case _SettlementModel() when $default != null:
return $default(_that.id,_that.payerId,_that.receiverId,_that.amount,_that.groupId,_that.date,_that.method);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SettlementModel implements SettlementModel {
  const _SettlementModel({required this.id, required this.payerId, required this.receiverId, required this.amount, this.groupId, required this.date, this.method = 'CASH'});
  factory _SettlementModel.fromJson(Map<String, dynamic> json) => _$SettlementModelFromJson(json);

@override final  String id;
@override final  String payerId;
@override final  String receiverId;
@override final  double amount;
@override final  String? groupId;
@override final  int date;
// Timestamp
@override@JsonKey() final  String method;

/// Create a copy of SettlementModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettlementModelCopyWith<_SettlementModel> get copyWith => __$SettlementModelCopyWithImpl<_SettlementModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettlementModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettlementModel&&(identical(other.id, id) || other.id == id)&&(identical(other.payerId, payerId) || other.payerId == payerId)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.date, date) || other.date == date)&&(identical(other.method, method) || other.method == method));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,payerId,receiverId,amount,groupId,date,method);

@override
String toString() {
  return 'SettlementModel(id: $id, payerId: $payerId, receiverId: $receiverId, amount: $amount, groupId: $groupId, date: $date, method: $method)';
}


}

/// @nodoc
abstract mixin class _$SettlementModelCopyWith<$Res> implements $SettlementModelCopyWith<$Res> {
  factory _$SettlementModelCopyWith(_SettlementModel value, $Res Function(_SettlementModel) _then) = __$SettlementModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String payerId, String receiverId, double amount, String? groupId, int date, String method
});




}
/// @nodoc
class __$SettlementModelCopyWithImpl<$Res>
    implements _$SettlementModelCopyWith<$Res> {
  __$SettlementModelCopyWithImpl(this._self, this._then);

  final _SettlementModel _self;
  final $Res Function(_SettlementModel) _then;

/// Create a copy of SettlementModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? payerId = null,Object? receiverId = null,Object? amount = null,Object? groupId = freezed,Object? date = null,Object? method = null,}) {
  return _then(_SettlementModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,payerId: null == payerId ? _self.payerId : payerId // ignore: cast_nullable_to_non_nullable
as String,receiverId: null == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as int,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
