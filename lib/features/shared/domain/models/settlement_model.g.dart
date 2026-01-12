// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settlement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettlementModel _$SettlementModelFromJson(Map<String, dynamic> json) =>
    _SettlementModel(
      id: json['id'] as String,
      payerId: json['payerId'] as String,
      receiverId: json['receiverId'] as String,
      amount: (json['amount'] as num).toDouble(),
      groupId: json['groupId'] as String?,
      date: (json['date'] as num).toInt(),
      method: json['method'] as String? ?? 'CASH',
    );

Map<String, dynamic> _$SettlementModelToJson(_SettlementModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'payerId': instance.payerId,
      'receiverId': instance.receiverId,
      'amount': instance.amount,
      'groupId': instance.groupId,
      'date': instance.date,
      'method': instance.method,
    };
