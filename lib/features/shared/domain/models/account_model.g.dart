// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountModel _$AccountModelFromJson(Map<String, dynamic> json) =>
    _AccountModel(
      userId: json['userId'] as String,
      currentBalance: (json['currentBalance'] as num).toDouble(),
      openingBalance: (json['openingBalance'] as num?)?.toDouble() ?? 0.0,
      totalIncome: (json['totalIncome'] as num?)?.toDouble() ?? 0.0,
      totalExpense: (json['totalExpense'] as num?)?.toDouble() ?? 0.0,
      totalReceivable: (json['totalReceivable'] as num?)?.toDouble() ?? 0.0,
      totalPayable: (json['totalPayable'] as num?)?.toDouble() ?? 0.0,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$AccountModelToJson(_AccountModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'currentBalance': instance.currentBalance,
      'openingBalance': instance.openingBalance,
      'totalIncome': instance.totalIncome,
      'totalExpense': instance.totalExpense,
      'totalReceivable': instance.totalReceivable,
      'totalPayable': instance.totalPayable,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
    };
