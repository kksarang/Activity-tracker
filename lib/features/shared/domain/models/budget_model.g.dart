// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BudgetModel _$BudgetModelFromJson(Map<String, dynamic> json) => _BudgetModel(
  id: json['id'] as String,
  uid: json['uid'] as String,
  month: json['month'] as String,
  limit: (json['limit'] as num).toDouble(),
  currentWait: (json['currentWait'] as num?)?.toDouble() ?? 0.0,
  alertsEnabled: json['alertsEnabled'] as bool? ?? true,
);

Map<String, dynamic> _$BudgetModelToJson(_BudgetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'month': instance.month,
      'limit': instance.limit,
      'currentWait': instance.currentWait,
      'alertsEnabled': instance.alertsEnabled,
    };
