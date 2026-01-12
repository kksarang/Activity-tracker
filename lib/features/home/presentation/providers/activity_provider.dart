import 'package:activity/features/shared/domain/models/activity_model.dart';
import 'package:activity/features/shared/domain/models/notification_model.dart';
import 'package:activity/features/shared/domain/models/expense_model.dart'; // Keep for compatibility
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class ActivityState {
  final List<ActivityItem> activities;
  final List<AppNotification> notifications;

  const ActivityState({
    this.activities = const [],
    this.notifications = const [],
  });

  // Computed Properties (Single Source of Truth)
  double get totalIncome => activities
      .where(
        (a) =>
            a.direction == ActivityDirection.credit &&
            a.status == ActivityStatus.completed,
      )
      .fold(0.0, (sum, item) => sum + item.amount);

  double get totalExpense => activities
      .where(
        (a) =>
            a.direction == ActivityDirection.debit &&
            a.status == ActivityStatus.completed,
      )
      .fold(0.0, (sum, item) => sum + item.amount);

  double get accountBalance => totalIncome - totalExpense;

  int get unreadNotificationCount =>
      notifications.where((n) => !n.isRead).length;

  // Getters for filtered views
  List<ActivityItem> get recentActivities {
    final sorted = List<ActivityItem>.from(activities);
    sorted.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return sorted.take(5).toList();
  }

  ActivityState copyWith({
    List<ActivityItem>? activities,
    List<AppNotification>? notifications,
  }) {
    return ActivityState(
      activities: activities ?? this.activities,
      notifications: notifications ?? this.notifications,
    );
  }
}

class ActivityNotifier extends StateNotifier<ActivityState> {
  ActivityNotifier() : super(const ActivityState()) {
    _loadInitialData();
  }

  void _loadInitialData() {
    // Phase 1: In-memory (Mock)
    // Eventually load from DB
    state = const ActivityState(activities: [], notifications: []);
  }

  // --- CORE LOGIC: THE MANIFESTO IMPLEMENTATION ---

  /// The Single Access Point for changing state.
  /// 1. Validate (Pre-call)
  /// 2. Add Activity
  /// 3. Update Notifications
  /// 4. UI Refreshes automatically via State
  void logActivity(ActivityItem activity) {
    // 1. Add Activity
    final newActivities = [activity, ...state.activities];

    // 2. Create Notification (Side Effect)
    _createNotificationFor(activity);

    // 3. Update State
    state = state.copyWith(activities: newActivities);
  }

  void _createNotificationFor(ActivityItem activity) {
    String title = '';
    String message = '';
    NotificationType type = NotificationType.info;

    switch (activity.source) {
      case ActivitySource.wallet:
      case ActivitySource.manual:
      case ActivitySource.scan:
        if (activity.direction == ActivityDirection.debit) {
          title = 'Expense Recorded';
          message =
              'You spent ₹${activity.amount.toStringAsFixed(2)} on ${activity.title}';
          type = NotificationType.info;
        } else {
          title = 'Income Received';
          message =
              'You received ₹${activity.amount.toStringAsFixed(2)} from ${activity.title}';
          type = NotificationType.success;
        }
        break;
      case ActivitySource.split_group:
        title = 'Split Bill Updated';
        message = '${activity.title} was added to split.';
        type = NotificationType.info;
        break;
    }

    final notification = AppNotification(
      id: const Uuid().v4(),
      title: title,
      message: message,
      type: type,
      relatedActivityId: activity.id,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    final newNotifications = [notification, ...state.notifications];
    state = state.copyWith(notifications: newNotifications);
  }

  void markNotificationsRead() {
    final updated = state.notifications
        .map((n) => n.copyWith(isRead: true))
        .toList();
    state = state.copyWith(notifications: updated);
  }

  // --- COMPATIBILITY LAYERS ---

  void setOpeningBalance(double amount) {
    // Treat opening balance as an Income activity
    final activity = ActivityItem(
      id: const Uuid().v4(),
      type: ActivityType.income,
      title: 'Opening Balance',
      amount: amount,
      direction: ActivityDirection.credit,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      source: ActivitySource.wallet,
    );
    logActivity(activity);
  }

  // Adapter for old ExpenseModel calls
  void addTransaction(ExpenseModel transaction) {
    final activity = ActivityItem(
      id: transaction.id,
      type: transaction.type == TransactionType.income
          ? ActivityType.income
          : ActivityType.expense,
      title: transaction.title,
      description: transaction.notes,
      amount: transaction.amount,
      direction: transaction.type == TransactionType.income
          ? ActivityDirection.credit
          : ActivityDirection.debit,
      timestamp: transaction.date,
      source: ActivitySource.manual,
      relatedId: transaction.id,
      metadata: transaction.toJson(),
    );
    logActivity(activity);
  }

  void addQuickTransaction({
    required String title,
    required double amount,
    required TransactionType type,
    String categoryId = 'generated',
    String categoryName = 'General',
  }) {
    final activity = ActivityItem(
      id: const Uuid().v4(),
      type: type == TransactionType.income
          ? ActivityType.income
          : ActivityType.expense,
      title: title,
      amount: amount,
      direction: type == TransactionType.income
          ? ActivityDirection.credit
          : ActivityDirection.debit,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      source: ActivitySource.manual,
    );
    logActivity(activity);
  }
}

final activityProvider = StateNotifierProvider<ActivityNotifier, ActivityState>(
  (ref) {
    return ActivityNotifier();
  },
);
