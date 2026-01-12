// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SplitDetail _$SplitDetailFromJson(Map<String, dynamic> json) => _SplitDetail(
  amount: (json['amount'] as num).toDouble(),
  status: json['status'] as String? ?? 'pending',
);

Map<String, dynamic> _$SplitDetailToJson(_SplitDetail instance) =>
    <String, dynamic>{'amount': instance.amount, 'status': instance.status};

_ExpenseModel _$ExpenseModelFromJson(Map<String, dynamic> json) =>
    _ExpenseModel(
      id: json['id'] as String,
      title: json['title'] as String,
      type:
          $enumDecodeNullable(_$TransactionTypeEnumMap, json['type']) ??
          TransactionType.expense,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'INR',
      date: (json['date'] as num).toInt(),
      categoryId: json['categoryId'] as String,
      categoryName: json['categoryName'] as String,
      groupId: json['groupId'] as String?,
      payerId: json['payerId'] as String,
      splitType:
          $enumDecodeNullable(_$SplitTypeEnumMap, json['splitType']) ??
          SplitType.equal,
      participants:
          (json['participants'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      splitDetails:
          (json['splitDetails'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, SplitDetail.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      createdBy: json['createdBy'] as String,
      notes: json['notes'] as String?,
      receiptUrl: json['receiptUrl'] as String?,
    );

Map<String, dynamic> _$ExpenseModelToJson(_ExpenseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'amount': instance.amount,
      'currency': instance.currency,
      'date': instance.date,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'groupId': instance.groupId,
      'payerId': instance.payerId,
      'splitType': _$SplitTypeEnumMap[instance.splitType]!,
      'participants': instance.participants,
      'splitDetails': instance.splitDetails,
      'createdBy': instance.createdBy,
      'notes': instance.notes,
      'receiptUrl': instance.receiptUrl,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.income: 'income',
  TransactionType.expense: 'expense',
};

const _$SplitTypeEnumMap = {
  SplitType.equal: 'equal',
  SplitType.exact: 'exact',
  SplitType.percent: 'percent',
  SplitType.adjustment: 'adjustment',
};
