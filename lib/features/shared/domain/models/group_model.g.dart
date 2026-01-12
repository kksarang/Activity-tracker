// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GroupModel _$GroupModelFromJson(Map<String, dynamic> json) => _GroupModel(
  id: json['id'] as String,
  name: json['name'] as String,
  members: (json['members'] as List<dynamic>).map((e) => e as String).toList(),
  createdBy: json['createdBy'] as String,
  createdAt: (json['createdAt'] as num).toInt(),
  totalExpense: (json['totalExpense'] as num?)?.toDouble() ?? 0.0,
  iconUrl: json['iconUrl'] as String?,
);

Map<String, dynamic> _$GroupModelToJson(_GroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'members': instance.members,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt,
      'totalExpense': instance.totalExpense,
      'iconUrl': instance.iconUrl,
    };
