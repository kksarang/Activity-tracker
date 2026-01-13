// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'split_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SplitModel _$SplitModelFromJson(Map<String, dynamic> json) => _SplitModel(
  id: json['id'] as String,
  title: json['title'] as String,
  totalAmount: (json['totalAmount'] as num).toDouble(),
  createdBy: json['createdBy'] as String,
  participants: (json['participants'] as List<dynamic>)
      .map((e) => SplitParticipant.fromJson(e as Map<String, dynamic>))
      .toList(),
  status:
      $enumDecodeNullable(_$SplitStatusEnumMap, json['status']) ??
      SplitStatus.pending,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$SplitModelToJson(_SplitModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'totalAmount': instance.totalAmount,
      'createdBy': instance.createdBy,
      'participants': instance.participants,
      'status': _$SplitStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$SplitStatusEnumMap = {
  SplitStatus.pending: 'pending',
  SplitStatus.partial: 'partial',
  SplitStatus.completed: 'completed',
};

_SplitParticipant _$SplitParticipantFromJson(Map<String, dynamic> json) =>
    _SplitParticipant(
      userId: json['userId'] as String,
      share: (json['share'] as num).toDouble(),
      hasPaid: json['hasPaid'] as bool? ?? false,
    );

Map<String, dynamic> _$SplitParticipantToJson(_SplitParticipant instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'share': instance.share,
      'hasPaid': instance.hasPaid,
    };
