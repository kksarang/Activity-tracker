// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'split_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SplitModel {

 String get id; String get title; double get totalAmount; String get createdBy; List<SplitParticipant> get participants; SplitStatus get status; DateTime get createdAt;
/// Create a copy of SplitModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SplitModelCopyWith<SplitModel> get copyWith => _$SplitModelCopyWithImpl<SplitModel>(this as SplitModel, _$identity);

  /// Serializes this SplitModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplitModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&const DeepCollectionEquality().equals(other.participants, participants)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,totalAmount,createdBy,const DeepCollectionEquality().hash(participants),status,createdAt);

@override
String toString() {
  return 'SplitModel(id: $id, title: $title, totalAmount: $totalAmount, createdBy: $createdBy, participants: $participants, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $SplitModelCopyWith<$Res>  {
  factory $SplitModelCopyWith(SplitModel value, $Res Function(SplitModel) _then) = _$SplitModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, double totalAmount, String createdBy, List<SplitParticipant> participants, SplitStatus status, DateTime createdAt
});




}
/// @nodoc
class _$SplitModelCopyWithImpl<$Res>
    implements $SplitModelCopyWith<$Res> {
  _$SplitModelCopyWithImpl(this._self, this._then);

  final SplitModel _self;
  final $Res Function(SplitModel) _then;

/// Create a copy of SplitModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? totalAmount = null,Object? createdBy = null,Object? participants = null,Object? status = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<SplitParticipant>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SplitStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SplitModel].
extension SplitModelPatterns on SplitModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SplitModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SplitModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SplitModel value)  $default,){
final _that = this;
switch (_that) {
case _SplitModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SplitModel value)?  $default,){
final _that = this;
switch (_that) {
case _SplitModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  double totalAmount,  String createdBy,  List<SplitParticipant> participants,  SplitStatus status,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SplitModel() when $default != null:
return $default(_that.id,_that.title,_that.totalAmount,_that.createdBy,_that.participants,_that.status,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  double totalAmount,  String createdBy,  List<SplitParticipant> participants,  SplitStatus status,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _SplitModel():
return $default(_that.id,_that.title,_that.totalAmount,_that.createdBy,_that.participants,_that.status,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  double totalAmount,  String createdBy,  List<SplitParticipant> participants,  SplitStatus status,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _SplitModel() when $default != null:
return $default(_that.id,_that.title,_that.totalAmount,_that.createdBy,_that.participants,_that.status,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SplitModel implements SplitModel {
  const _SplitModel({required this.id, required this.title, required this.totalAmount, required this.createdBy, required final  List<SplitParticipant> participants, this.status = SplitStatus.pending, required this.createdAt}): _participants = participants;
  factory _SplitModel.fromJson(Map<String, dynamic> json) => _$SplitModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  double totalAmount;
@override final  String createdBy;
 final  List<SplitParticipant> _participants;
@override List<SplitParticipant> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}

@override@JsonKey() final  SplitStatus status;
@override final  DateTime createdAt;

/// Create a copy of SplitModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SplitModelCopyWith<_SplitModel> get copyWith => __$SplitModelCopyWithImpl<_SplitModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SplitModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SplitModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&const DeepCollectionEquality().equals(other._participants, _participants)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,totalAmount,createdBy,const DeepCollectionEquality().hash(_participants),status,createdAt);

@override
String toString() {
  return 'SplitModel(id: $id, title: $title, totalAmount: $totalAmount, createdBy: $createdBy, participants: $participants, status: $status, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$SplitModelCopyWith<$Res> implements $SplitModelCopyWith<$Res> {
  factory _$SplitModelCopyWith(_SplitModel value, $Res Function(_SplitModel) _then) = __$SplitModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, double totalAmount, String createdBy, List<SplitParticipant> participants, SplitStatus status, DateTime createdAt
});




}
/// @nodoc
class __$SplitModelCopyWithImpl<$Res>
    implements _$SplitModelCopyWith<$Res> {
  __$SplitModelCopyWithImpl(this._self, this._then);

  final _SplitModel _self;
  final $Res Function(_SplitModel) _then;

/// Create a copy of SplitModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? totalAmount = null,Object? createdBy = null,Object? participants = null,Object? status = null,Object? createdAt = null,}) {
  return _then(_SplitModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<SplitParticipant>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SplitStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$SplitParticipant {

 String get userId; double get share; bool get hasPaid;
/// Create a copy of SplitParticipant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SplitParticipantCopyWith<SplitParticipant> get copyWith => _$SplitParticipantCopyWithImpl<SplitParticipant>(this as SplitParticipant, _$identity);

  /// Serializes this SplitParticipant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplitParticipant&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.share, share) || other.share == share)&&(identical(other.hasPaid, hasPaid) || other.hasPaid == hasPaid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,share,hasPaid);

@override
String toString() {
  return 'SplitParticipant(userId: $userId, share: $share, hasPaid: $hasPaid)';
}


}

/// @nodoc
abstract mixin class $SplitParticipantCopyWith<$Res>  {
  factory $SplitParticipantCopyWith(SplitParticipant value, $Res Function(SplitParticipant) _then) = _$SplitParticipantCopyWithImpl;
@useResult
$Res call({
 String userId, double share, bool hasPaid
});




}
/// @nodoc
class _$SplitParticipantCopyWithImpl<$Res>
    implements $SplitParticipantCopyWith<$Res> {
  _$SplitParticipantCopyWithImpl(this._self, this._then);

  final SplitParticipant _self;
  final $Res Function(SplitParticipant) _then;

/// Create a copy of SplitParticipant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? share = null,Object? hasPaid = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,share: null == share ? _self.share : share // ignore: cast_nullable_to_non_nullable
as double,hasPaid: null == hasPaid ? _self.hasPaid : hasPaid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SplitParticipant].
extension SplitParticipantPatterns on SplitParticipant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SplitParticipant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SplitParticipant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SplitParticipant value)  $default,){
final _that = this;
switch (_that) {
case _SplitParticipant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SplitParticipant value)?  $default,){
final _that = this;
switch (_that) {
case _SplitParticipant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  double share,  bool hasPaid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SplitParticipant() when $default != null:
return $default(_that.userId,_that.share,_that.hasPaid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  double share,  bool hasPaid)  $default,) {final _that = this;
switch (_that) {
case _SplitParticipant():
return $default(_that.userId,_that.share,_that.hasPaid);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  double share,  bool hasPaid)?  $default,) {final _that = this;
switch (_that) {
case _SplitParticipant() when $default != null:
return $default(_that.userId,_that.share,_that.hasPaid);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SplitParticipant implements SplitParticipant {
  const _SplitParticipant({required this.userId, required this.share, this.hasPaid = false});
  factory _SplitParticipant.fromJson(Map<String, dynamic> json) => _$SplitParticipantFromJson(json);

@override final  String userId;
@override final  double share;
@override@JsonKey() final  bool hasPaid;

/// Create a copy of SplitParticipant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SplitParticipantCopyWith<_SplitParticipant> get copyWith => __$SplitParticipantCopyWithImpl<_SplitParticipant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SplitParticipantToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SplitParticipant&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.share, share) || other.share == share)&&(identical(other.hasPaid, hasPaid) || other.hasPaid == hasPaid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,share,hasPaid);

@override
String toString() {
  return 'SplitParticipant(userId: $userId, share: $share, hasPaid: $hasPaid)';
}


}

/// @nodoc
abstract mixin class _$SplitParticipantCopyWith<$Res> implements $SplitParticipantCopyWith<$Res> {
  factory _$SplitParticipantCopyWith(_SplitParticipant value, $Res Function(_SplitParticipant) _then) = __$SplitParticipantCopyWithImpl;
@override @useResult
$Res call({
 String userId, double share, bool hasPaid
});




}
/// @nodoc
class __$SplitParticipantCopyWithImpl<$Res>
    implements _$SplitParticipantCopyWith<$Res> {
  __$SplitParticipantCopyWithImpl(this._self, this._then);

  final _SplitParticipant _self;
  final $Res Function(_SplitParticipant) _then;

/// Create a copy of SplitParticipant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? share = null,Object? hasPaid = null,}) {
  return _then(_SplitParticipant(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,share: null == share ? _self.share : share // ignore: cast_nullable_to_non_nullable
as double,hasPaid: null == hasPaid ? _self.hasPaid : hasPaid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
