import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_model.freezed.dart';
part 'activity_model.g.dart';

enum ActivityType { expense, income, split, settlement, transfer, request }

enum ActivityDirection { credit, debit }

enum ActivityStatus { completed, pending, failed }

enum ActivitySource { wallet, split_group, scan, manual }

@freezed
sealed class ActivityItem with _$ActivityItem {
  const factory ActivityItem({
    required String id,
    required ActivityType type,
    required String title,
    String? description,
    required double amount,
    required ActivityDirection direction,
    @Default(ActivityStatus.completed) ActivityStatus status,
    required int timestamp, // Unix timestamp in milliseconds
    @Default(ActivitySource.manual) ActivitySource source,
    String? relatedId, // ID of the specific entity (ExpenseID, SplitID)
    Map<String, dynamic>? metadata,
  }) = _ActivityItem;

  factory ActivityItem.fromJson(Map<String, dynamic> json) =>
      _$ActivityItemFromJson(json);
}
