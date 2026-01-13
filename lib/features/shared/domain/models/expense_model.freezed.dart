// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SplitDetail {

 double get amount; String get status;
/// Create a copy of SplitDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SplitDetailCopyWith<SplitDetail> get copyWith => _$SplitDetailCopyWithImpl<SplitDetail>(this as SplitDetail, _$identity);

  /// Serializes this SplitDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplitDetail&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,status);

@override
String toString() {
  return 'SplitDetail(amount: $amount, status: $status)';
}


}

/// @nodoc
abstract mixin class $SplitDetailCopyWith<$Res>  {
  factory $SplitDetailCopyWith(SplitDetail value, $Res Function(SplitDetail) _then) = _$SplitDetailCopyWithImpl;
@useResult
$Res call({
 double amount, String status
});




}
/// @nodoc
class _$SplitDetailCopyWithImpl<$Res>
    implements $SplitDetailCopyWith<$Res> {
  _$SplitDetailCopyWithImpl(this._self, this._then);

  final SplitDetail _self;
  final $Res Function(SplitDetail) _then;

/// Create a copy of SplitDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? status = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SplitDetail].
extension SplitDetailPatterns on SplitDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SplitDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SplitDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SplitDetail value)  $default,){
final _that = this;
switch (_that) {
case _SplitDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SplitDetail value)?  $default,){
final _that = this;
switch (_that) {
case _SplitDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double amount,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SplitDetail() when $default != null:
return $default(_that.amount,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double amount,  String status)  $default,) {final _that = this;
switch (_that) {
case _SplitDetail():
return $default(_that.amount,_that.status);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double amount,  String status)?  $default,) {final _that = this;
switch (_that) {
case _SplitDetail() when $default != null:
return $default(_that.amount,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SplitDetail implements SplitDetail {
  const _SplitDetail({required this.amount, this.status = 'pending'});
  factory _SplitDetail.fromJson(Map<String, dynamic> json) => _$SplitDetailFromJson(json);

@override final  double amount;
@override@JsonKey() final  String status;

/// Create a copy of SplitDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SplitDetailCopyWith<_SplitDetail> get copyWith => __$SplitDetailCopyWithImpl<_SplitDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SplitDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SplitDetail&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,status);

@override
String toString() {
  return 'SplitDetail(amount: $amount, status: $status)';
}


}

/// @nodoc
abstract mixin class _$SplitDetailCopyWith<$Res> implements $SplitDetailCopyWith<$Res> {
  factory _$SplitDetailCopyWith(_SplitDetail value, $Res Function(_SplitDetail) _then) = __$SplitDetailCopyWithImpl;
@override @useResult
$Res call({
 double amount, String status
});




}
/// @nodoc
class __$SplitDetailCopyWithImpl<$Res>
    implements _$SplitDetailCopyWith<$Res> {
  __$SplitDetailCopyWithImpl(this._self, this._then);

  final _SplitDetail _self;
  final $Res Function(_SplitDetail) _then;

/// Create a copy of SplitDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? status = null,}) {
  return _then(_SplitDetail(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ExpenseModel {

 String get id; String get title; TransactionType get type;// income, expense
 double get amount; String get currency; int get date;// Timestamp
 String get categoryId; String get categoryName; String? get groupId; String get payerId; SplitType get splitType; List<String> get participants; Map<String, SplitDetail> get splitDetails; String get createdBy; String? get notes; String? get receiptUrl;
/// Create a copy of ExpenseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseModelCopyWith<ExpenseModel> get copyWith => _$ExpenseModelCopyWithImpl<ExpenseModel>(this as ExpenseModel, _$identity);

  /// Serializes this ExpenseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.date, date) || other.date == date)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.payerId, payerId) || other.payerId == payerId)&&(identical(other.splitType, splitType) || other.splitType == splitType)&&const DeepCollectionEquality().equals(other.participants, participants)&&const DeepCollectionEquality().equals(other.splitDetails, splitDetails)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.receiptUrl, receiptUrl) || other.receiptUrl == receiptUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,type,amount,currency,date,categoryId,categoryName,groupId,payerId,splitType,const DeepCollectionEquality().hash(participants),const DeepCollectionEquality().hash(splitDetails),createdBy,notes,receiptUrl);

@override
String toString() {
  return 'ExpenseModel(id: $id, title: $title, type: $type, amount: $amount, currency: $currency, date: $date, categoryId: $categoryId, categoryName: $categoryName, groupId: $groupId, payerId: $payerId, splitType: $splitType, participants: $participants, splitDetails: $splitDetails, createdBy: $createdBy, notes: $notes, receiptUrl: $receiptUrl)';
}


}

/// @nodoc
abstract mixin class $ExpenseModelCopyWith<$Res>  {
  factory $ExpenseModelCopyWith(ExpenseModel value, $Res Function(ExpenseModel) _then) = _$ExpenseModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, TransactionType type, double amount, String currency, int date, String categoryId, String categoryName, String? groupId, String payerId, SplitType splitType, List<String> participants, Map<String, SplitDetail> splitDetails, String createdBy, String? notes, String? receiptUrl
});




}
/// @nodoc
class _$ExpenseModelCopyWithImpl<$Res>
    implements $ExpenseModelCopyWith<$Res> {
  _$ExpenseModelCopyWithImpl(this._self, this._then);

  final ExpenseModel _self;
  final $Res Function(ExpenseModel) _then;

/// Create a copy of ExpenseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? type = null,Object? amount = null,Object? currency = null,Object? date = null,Object? categoryId = null,Object? categoryName = null,Object? groupId = freezed,Object? payerId = null,Object? splitType = null,Object? participants = null,Object? splitDetails = null,Object? createdBy = null,Object? notes = freezed,Object? receiptUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as int,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,payerId: null == payerId ? _self.payerId : payerId // ignore: cast_nullable_to_non_nullable
as String,splitType: null == splitType ? _self.splitType : splitType // ignore: cast_nullable_to_non_nullable
as SplitType,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<String>,splitDetails: null == splitDetails ? _self.splitDetails : splitDetails // ignore: cast_nullable_to_non_nullable
as Map<String, SplitDetail>,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,receiptUrl: freezed == receiptUrl ? _self.receiptUrl : receiptUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExpenseModel].
extension ExpenseModelPatterns on ExpenseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseModel value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  TransactionType type,  double amount,  String currency,  int date,  String categoryId,  String categoryName,  String? groupId,  String payerId,  SplitType splitType,  List<String> participants,  Map<String, SplitDetail> splitDetails,  String createdBy,  String? notes,  String? receiptUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseModel() when $default != null:
return $default(_that.id,_that.title,_that.type,_that.amount,_that.currency,_that.date,_that.categoryId,_that.categoryName,_that.groupId,_that.payerId,_that.splitType,_that.participants,_that.splitDetails,_that.createdBy,_that.notes,_that.receiptUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  TransactionType type,  double amount,  String currency,  int date,  String categoryId,  String categoryName,  String? groupId,  String payerId,  SplitType splitType,  List<String> participants,  Map<String, SplitDetail> splitDetails,  String createdBy,  String? notes,  String? receiptUrl)  $default,) {final _that = this;
switch (_that) {
case _ExpenseModel():
return $default(_that.id,_that.title,_that.type,_that.amount,_that.currency,_that.date,_that.categoryId,_that.categoryName,_that.groupId,_that.payerId,_that.splitType,_that.participants,_that.splitDetails,_that.createdBy,_that.notes,_that.receiptUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  TransactionType type,  double amount,  String currency,  int date,  String categoryId,  String categoryName,  String? groupId,  String payerId,  SplitType splitType,  List<String> participants,  Map<String, SplitDetail> splitDetails,  String createdBy,  String? notes,  String? receiptUrl)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseModel() when $default != null:
return $default(_that.id,_that.title,_that.type,_that.amount,_that.currency,_that.date,_that.categoryId,_that.categoryName,_that.groupId,_that.payerId,_that.splitType,_that.participants,_that.splitDetails,_that.createdBy,_that.notes,_that.receiptUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpenseModel implements ExpenseModel {
  const _ExpenseModel({required this.id, required this.title, this.type = TransactionType.expense, required this.amount, this.currency = 'INR', required this.date, required this.categoryId, required this.categoryName, this.groupId, required this.payerId, this.splitType = SplitType.equal, final  List<String> participants = const [], final  Map<String, SplitDetail> splitDetails = const {}, required this.createdBy, this.notes, this.receiptUrl}): _participants = participants,_splitDetails = splitDetails;
  factory _ExpenseModel.fromJson(Map<String, dynamic> json) => _$ExpenseModelFromJson(json);

@override final  String id;
@override final  String title;
@override@JsonKey() final  TransactionType type;
// income, expense
@override final  double amount;
@override@JsonKey() final  String currency;
@override final  int date;
// Timestamp
@override final  String categoryId;
@override final  String categoryName;
@override final  String? groupId;
@override final  String payerId;
@override@JsonKey() final  SplitType splitType;
 final  List<String> _participants;
@override@JsonKey() List<String> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}

 final  Map<String, SplitDetail> _splitDetails;
@override@JsonKey() Map<String, SplitDetail> get splitDetails {
  if (_splitDetails is EqualUnmodifiableMapView) return _splitDetails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_splitDetails);
}

@override final  String createdBy;
@override final  String? notes;
@override final  String? receiptUrl;

/// Create a copy of ExpenseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseModelCopyWith<_ExpenseModel> get copyWith => __$ExpenseModelCopyWithImpl<_ExpenseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpenseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.date, date) || other.date == date)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.payerId, payerId) || other.payerId == payerId)&&(identical(other.splitType, splitType) || other.splitType == splitType)&&const DeepCollectionEquality().equals(other._participants, _participants)&&const DeepCollectionEquality().equals(other._splitDetails, _splitDetails)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.receiptUrl, receiptUrl) || other.receiptUrl == receiptUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,type,amount,currency,date,categoryId,categoryName,groupId,payerId,splitType,const DeepCollectionEquality().hash(_participants),const DeepCollectionEquality().hash(_splitDetails),createdBy,notes,receiptUrl);

@override
String toString() {
  return 'ExpenseModel(id: $id, title: $title, type: $type, amount: $amount, currency: $currency, date: $date, categoryId: $categoryId, categoryName: $categoryName, groupId: $groupId, payerId: $payerId, splitType: $splitType, participants: $participants, splitDetails: $splitDetails, createdBy: $createdBy, notes: $notes, receiptUrl: $receiptUrl)';
}


}

/// @nodoc
abstract mixin class _$ExpenseModelCopyWith<$Res> implements $ExpenseModelCopyWith<$Res> {
  factory _$ExpenseModelCopyWith(_ExpenseModel value, $Res Function(_ExpenseModel) _then) = __$ExpenseModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, TransactionType type, double amount, String currency, int date, String categoryId, String categoryName, String? groupId, String payerId, SplitType splitType, List<String> participants, Map<String, SplitDetail> splitDetails, String createdBy, String? notes, String? receiptUrl
});




}
/// @nodoc
class __$ExpenseModelCopyWithImpl<$Res>
    implements _$ExpenseModelCopyWith<$Res> {
  __$ExpenseModelCopyWithImpl(this._self, this._then);

  final _ExpenseModel _self;
  final $Res Function(_ExpenseModel) _then;

/// Create a copy of ExpenseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? type = null,Object? amount = null,Object? currency = null,Object? date = null,Object? categoryId = null,Object? categoryName = null,Object? groupId = freezed,Object? payerId = null,Object? splitType = null,Object? participants = null,Object? splitDetails = null,Object? createdBy = null,Object? notes = freezed,Object? receiptUrl = freezed,}) {
  return _then(_ExpenseModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as int,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,payerId: null == payerId ? _self.payerId : payerId // ignore: cast_nullable_to_non_nullable
as String,splitType: null == splitType ? _self.splitType : splitType // ignore: cast_nullable_to_non_nullable
as SplitType,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<String>,splitDetails: null == splitDetails ? _self._splitDetails : splitDetails // ignore: cast_nullable_to_non_nullable
as Map<String, SplitDetail>,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,receiptUrl: freezed == receiptUrl ? _self.receiptUrl : receiptUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
