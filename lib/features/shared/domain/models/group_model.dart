import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_model.freezed.dart';
part 'group_model.g.dart';

@freezed
sealed class GroupModel with _$GroupModel {
  const factory GroupModel({
    required String id,
    required String name,
    required List<String> members, // List of user UIDs
    required String createdBy,
    required int createdAt, // Timestamp
    @Default(0.0) double totalExpense,
    String? iconUrl,
  }) = _GroupModel;

  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      _$GroupModelFromJson(json);
}
