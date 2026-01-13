// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivityItem _$ActivityItemFromJson(Map<String, dynamic> json) =>
    _ActivityItem(
      id: json['id'] as String,
      type: $enumDecode(_$ActivityTypeEnumMap, json['type']),
      title: json['title'] as String,
      description: json['description'] as String?,
      amount: (json['amount'] as num).toDouble(),
      direction: $enumDecode(_$ActivityDirectionEnumMap, json['direction']),
      status:
          $enumDecodeNullable(_$ActivityStatusEnumMap, json['status']) ??
          ActivityStatus.completed,
      timestamp: (json['timestamp'] as num).toInt(),
      source:
          $enumDecodeNullable(_$ActivitySourceEnumMap, json['source']) ??
          ActivitySource.manual,
      relatedId: json['relatedId'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ActivityItemToJson(_ActivityItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ActivityTypeEnumMap[instance.type]!,
      'title': instance.title,
      'description': instance.description,
      'amount': instance.amount,
      'direction': _$ActivityDirectionEnumMap[instance.direction]!,
      'status': _$ActivityStatusEnumMap[instance.status]!,
      'timestamp': instance.timestamp,
      'source': _$ActivitySourceEnumMap[instance.source]!,
      'relatedId': instance.relatedId,
      'metadata': instance.metadata,
    };

const _$ActivityTypeEnumMap = {
  ActivityType.expense: 'expense',
  ActivityType.income: 'income',
  ActivityType.split: 'split',
  ActivityType.settlement: 'settlement',
  ActivityType.transfer: 'transfer',
  ActivityType.request: 'request',
};

const _$ActivityDirectionEnumMap = {
  ActivityDirection.credit: 'credit',
  ActivityDirection.debit: 'debit',
};

const _$ActivityStatusEnumMap = {
  ActivityStatus.completed: 'completed',
  ActivityStatus.pending: 'pending',
  ActivityStatus.failed: 'failed',
};

const _$ActivitySourceEnumMap = {
  ActivitySource.wallet: 'wallet',
  ActivitySource.split_group: 'split_group',
  ActivitySource.scan: 'scan',
  ActivitySource.manual: 'manual',
};
