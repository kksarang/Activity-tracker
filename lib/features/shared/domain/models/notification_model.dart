import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

enum NotificationType { info, success, warning, error }

@freezed
sealed class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required String title,
    required String message,
    @Default(NotificationType.info) NotificationType type,
    String? relatedActivityId,
    @Default(false) bool isRead,
    required int createdAt, // Unix timestamp in milliseconds
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);
}
