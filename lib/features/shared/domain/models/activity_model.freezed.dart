// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ActivityItem {

 String get id; ActivityType get type; String get title; String? get description; double get amount; ActivityDirection get direction; ActivityStatus get status; int get timestamp;// Unix timestamp in milliseconds
 ActivitySource get source; String? get relatedId;// ID of the specific entity (ExpenseID, SplitID)
 Map<String, dynamic>? get metadata;
/// Create a copy of ActivityItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityItemCopyWith<ActivityItem> get copyWith => _$ActivityItemCopyWithImpl<ActivityItem>(this as ActivityItem, _$identity);

  /// Serializes this ActivityItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityItem&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.status, status) || other.status == status)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.source, source) || other.source == source)&&(identical(other.relatedId, relatedId) || other.relatedId == relatedId)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,description,amount,direction,status,timestamp,source,relatedId,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'ActivityItem(id: $id, type: $type, title: $title, description: $description, amount: $amount, direction: $direction, status: $status, timestamp: $timestamp, source: $source, relatedId: $relatedId, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $ActivityItemCopyWith<$Res>  {
  factory $ActivityItemCopyWith(ActivityItem value, $Res Function(ActivityItem) _then) = _$ActivityItemCopyWithImpl;
@useResult
$Res call({
 String id, ActivityType type, String title, String? description, double amount, ActivityDirection direction, ActivityStatus status, int timestamp, ActivitySource source, String? relatedId, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$ActivityItemCopyWithImpl<$Res>
    implements $ActivityItemCopyWith<$Res> {
  _$ActivityItemCopyWithImpl(this._self, this._then);

  final ActivityItem _self;
  final $Res Function(ActivityItem) _then;

/// Create a copy of ActivityItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? title = null,Object? description = freezed,Object? amount = null,Object? direction = null,Object? status = null,Object? timestamp = null,Object? source = null,Object? relatedId = freezed,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ActivityType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as ActivityDirection,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ActivityStatus,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ActivitySource,relatedId: freezed == relatedId ? _self.relatedId : relatedId // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityItem].
extension ActivityItemPatterns on ActivityItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityItem value)  $default,){
final _that = this;
switch (_that) {
case _ActivityItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityItem value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ActivityType type,  String title,  String? description,  double amount,  ActivityDirection direction,  ActivityStatus status,  int timestamp,  ActivitySource source,  String? relatedId,  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityItem() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.description,_that.amount,_that.direction,_that.status,_that.timestamp,_that.source,_that.relatedId,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ActivityType type,  String title,  String? description,  double amount,  ActivityDirection direction,  ActivityStatus status,  int timestamp,  ActivitySource source,  String? relatedId,  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _ActivityItem():
return $default(_that.id,_that.type,_that.title,_that.description,_that.amount,_that.direction,_that.status,_that.timestamp,_that.source,_that.relatedId,_that.metadata);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ActivityType type,  String title,  String? description,  double amount,  ActivityDirection direction,  ActivityStatus status,  int timestamp,  ActivitySource source,  String? relatedId,  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _ActivityItem() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.description,_that.amount,_that.direction,_that.status,_that.timestamp,_that.source,_that.relatedId,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivityItem implements ActivityItem {
  const _ActivityItem({required this.id, required this.type, required this.title, this.description, required this.amount, required this.direction, this.status = ActivityStatus.completed, required this.timestamp, this.source = ActivitySource.manual, this.relatedId, final  Map<String, dynamic>? metadata}): _metadata = metadata;
  factory _ActivityItem.fromJson(Map<String, dynamic> json) => _$ActivityItemFromJson(json);

@override final  String id;
@override final  ActivityType type;
@override final  String title;
@override final  String? description;
@override final  double amount;
@override final  ActivityDirection direction;
@override@JsonKey() final  ActivityStatus status;
@override final  int timestamp;
// Unix timestamp in milliseconds
@override@JsonKey() final  ActivitySource source;
@override final  String? relatedId;
// ID of the specific entity (ExpenseID, SplitID)
 final  Map<String, dynamic>? _metadata;
// ID of the specific entity (ExpenseID, SplitID)
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of ActivityItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityItemCopyWith<_ActivityItem> get copyWith => __$ActivityItemCopyWithImpl<_ActivityItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivityItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityItem&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.status, status) || other.status == status)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.source, source) || other.source == source)&&(identical(other.relatedId, relatedId) || other.relatedId == relatedId)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,description,amount,direction,status,timestamp,source,relatedId,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'ActivityItem(id: $id, type: $type, title: $title, description: $description, amount: $amount, direction: $direction, status: $status, timestamp: $timestamp, source: $source, relatedId: $relatedId, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$ActivityItemCopyWith<$Res> implements $ActivityItemCopyWith<$Res> {
  factory _$ActivityItemCopyWith(_ActivityItem value, $Res Function(_ActivityItem) _then) = __$ActivityItemCopyWithImpl;
@override @useResult
$Res call({
 String id, ActivityType type, String title, String? description, double amount, ActivityDirection direction, ActivityStatus status, int timestamp, ActivitySource source, String? relatedId, Map<String, dynamic>? metadata
});




}
/// @nodoc
class __$ActivityItemCopyWithImpl<$Res>
    implements _$ActivityItemCopyWith<$Res> {
  __$ActivityItemCopyWithImpl(this._self, this._then);

  final _ActivityItem _self;
  final $Res Function(_ActivityItem) _then;

/// Create a copy of ActivityItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? title = null,Object? description = freezed,Object? amount = null,Object? direction = null,Object? status = null,Object? timestamp = null,Object? source = null,Object? relatedId = freezed,Object? metadata = freezed,}) {
  return _then(_ActivityItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ActivityType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as ActivityDirection,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ActivityStatus,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ActivitySource,relatedId: freezed == relatedId ? _self.relatedId : relatedId // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
