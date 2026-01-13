// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountModel {

 String get userId; double get currentBalance;// Cash Balance
 double get openingBalance; double get totalIncome; double get totalExpense; double get totalReceivable; double get totalPayable; DateTime get lastUpdated;
/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountModelCopyWith<AccountModel> get copyWith => _$AccountModelCopyWithImpl<AccountModel>(this as AccountModel, _$identity);

  /// Serializes this AccountModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.currentBalance, currentBalance) || other.currentBalance == currentBalance)&&(identical(other.openingBalance, openingBalance) || other.openingBalance == openingBalance)&&(identical(other.totalIncome, totalIncome) || other.totalIncome == totalIncome)&&(identical(other.totalExpense, totalExpense) || other.totalExpense == totalExpense)&&(identical(other.totalReceivable, totalReceivable) || other.totalReceivable == totalReceivable)&&(identical(other.totalPayable, totalPayable) || other.totalPayable == totalPayable)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,currentBalance,openingBalance,totalIncome,totalExpense,totalReceivable,totalPayable,lastUpdated);

@override
String toString() {
  return 'AccountModel(userId: $userId, currentBalance: $currentBalance, openingBalance: $openingBalance, totalIncome: $totalIncome, totalExpense: $totalExpense, totalReceivable: $totalReceivable, totalPayable: $totalPayable, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $AccountModelCopyWith<$Res>  {
  factory $AccountModelCopyWith(AccountModel value, $Res Function(AccountModel) _then) = _$AccountModelCopyWithImpl;
@useResult
$Res call({
 String userId, double currentBalance, double openingBalance, double totalIncome, double totalExpense, double totalReceivable, double totalPayable, DateTime lastUpdated
});




}
/// @nodoc
class _$AccountModelCopyWithImpl<$Res>
    implements $AccountModelCopyWith<$Res> {
  _$AccountModelCopyWithImpl(this._self, this._then);

  final AccountModel _self;
  final $Res Function(AccountModel) _then;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? currentBalance = null,Object? openingBalance = null,Object? totalIncome = null,Object? totalExpense = null,Object? totalReceivable = null,Object? totalPayable = null,Object? lastUpdated = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,currentBalance: null == currentBalance ? _self.currentBalance : currentBalance // ignore: cast_nullable_to_non_nullable
as double,openingBalance: null == openingBalance ? _self.openingBalance : openingBalance // ignore: cast_nullable_to_non_nullable
as double,totalIncome: null == totalIncome ? _self.totalIncome : totalIncome // ignore: cast_nullable_to_non_nullable
as double,totalExpense: null == totalExpense ? _self.totalExpense : totalExpense // ignore: cast_nullable_to_non_nullable
as double,totalReceivable: null == totalReceivable ? _self.totalReceivable : totalReceivable // ignore: cast_nullable_to_non_nullable
as double,totalPayable: null == totalPayable ? _self.totalPayable : totalPayable // ignore: cast_nullable_to_non_nullable
as double,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountModel].
extension AccountModelPatterns on AccountModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountModel value)  $default,){
final _that = this;
switch (_that) {
case _AccountModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountModel value)?  $default,){
final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  double currentBalance,  double openingBalance,  double totalIncome,  double totalExpense,  double totalReceivable,  double totalPayable,  DateTime lastUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
return $default(_that.userId,_that.currentBalance,_that.openingBalance,_that.totalIncome,_that.totalExpense,_that.totalReceivable,_that.totalPayable,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  double currentBalance,  double openingBalance,  double totalIncome,  double totalExpense,  double totalReceivable,  double totalPayable,  DateTime lastUpdated)  $default,) {final _that = this;
switch (_that) {
case _AccountModel():
return $default(_that.userId,_that.currentBalance,_that.openingBalance,_that.totalIncome,_that.totalExpense,_that.totalReceivable,_that.totalPayable,_that.lastUpdated);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  double currentBalance,  double openingBalance,  double totalIncome,  double totalExpense,  double totalReceivable,  double totalPayable,  DateTime lastUpdated)?  $default,) {final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
return $default(_that.userId,_that.currentBalance,_that.openingBalance,_that.totalIncome,_that.totalExpense,_that.totalReceivable,_that.totalPayable,_that.lastUpdated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccountModel extends AccountModel {
  const _AccountModel({required this.userId, required this.currentBalance, this.openingBalance = 0.0, this.totalIncome = 0.0, this.totalExpense = 0.0, this.totalReceivable = 0.0, this.totalPayable = 0.0, required this.lastUpdated}): super._();
  factory _AccountModel.fromJson(Map<String, dynamic> json) => _$AccountModelFromJson(json);

@override final  String userId;
@override final  double currentBalance;
// Cash Balance
@override@JsonKey() final  double openingBalance;
@override@JsonKey() final  double totalIncome;
@override@JsonKey() final  double totalExpense;
@override@JsonKey() final  double totalReceivable;
@override@JsonKey() final  double totalPayable;
@override final  DateTime lastUpdated;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountModelCopyWith<_AccountModel> get copyWith => __$AccountModelCopyWithImpl<_AccountModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.currentBalance, currentBalance) || other.currentBalance == currentBalance)&&(identical(other.openingBalance, openingBalance) || other.openingBalance == openingBalance)&&(identical(other.totalIncome, totalIncome) || other.totalIncome == totalIncome)&&(identical(other.totalExpense, totalExpense) || other.totalExpense == totalExpense)&&(identical(other.totalReceivable, totalReceivable) || other.totalReceivable == totalReceivable)&&(identical(other.totalPayable, totalPayable) || other.totalPayable == totalPayable)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,currentBalance,openingBalance,totalIncome,totalExpense,totalReceivable,totalPayable,lastUpdated);

@override
String toString() {
  return 'AccountModel(userId: $userId, currentBalance: $currentBalance, openingBalance: $openingBalance, totalIncome: $totalIncome, totalExpense: $totalExpense, totalReceivable: $totalReceivable, totalPayable: $totalPayable, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$AccountModelCopyWith<$Res> implements $AccountModelCopyWith<$Res> {
  factory _$AccountModelCopyWith(_AccountModel value, $Res Function(_AccountModel) _then) = __$AccountModelCopyWithImpl;
@override @useResult
$Res call({
 String userId, double currentBalance, double openingBalance, double totalIncome, double totalExpense, double totalReceivable, double totalPayable, DateTime lastUpdated
});




}
/// @nodoc
class __$AccountModelCopyWithImpl<$Res>
    implements _$AccountModelCopyWith<$Res> {
  __$AccountModelCopyWithImpl(this._self, this._then);

  final _AccountModel _self;
  final $Res Function(_AccountModel) _then;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? currentBalance = null,Object? openingBalance = null,Object? totalIncome = null,Object? totalExpense = null,Object? totalReceivable = null,Object? totalPayable = null,Object? lastUpdated = null,}) {
  return _then(_AccountModel(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,currentBalance: null == currentBalance ? _self.currentBalance : currentBalance // ignore: cast_nullable_to_non_nullable
as double,openingBalance: null == openingBalance ? _self.openingBalance : openingBalance // ignore: cast_nullable_to_non_nullable
as double,totalIncome: null == totalIncome ? _self.totalIncome : totalIncome // ignore: cast_nullable_to_non_nullable
as double,totalExpense: null == totalExpense ? _self.totalExpense : totalExpense // ignore: cast_nullable_to_non_nullable
as double,totalReceivable: null == totalReceivable ? _self.totalReceivable : totalReceivable // ignore: cast_nullable_to_non_nullable
as double,totalPayable: null == totalPayable ? _self.totalPayable : totalPayable // ignore: cast_nullable_to_non_nullable
as double,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
