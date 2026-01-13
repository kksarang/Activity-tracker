import 'package:activity/features/shared/domain/models/activity_model.dart';
import 'package:activity/features/shared/domain/models/notification_model.dart';
import 'package:activity/features/shared/domain/models/account_model.dart';
import 'package:activity/features/shared/domain/models/split_model.dart';
import 'package:activity/features/shared/domain/models/expense_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class ActivityState {
  final AccountModel account;
  final List<ActivityItem> activities;
  final List<SplitModel> splits;
  final List<AppNotification> notifications;

  const ActivityState({
    required this.account,
    this.activities = const [],
    this.splits = const [],
    this.notifications = const [],
  });

  // Backward Compatibility (UI uses these getters)
  double get totalIncome => account.totalIncome;
  double get totalExpense => account.totalExpense;
  double get accountBalance => account.currentBalance;
  int get unreadNotificationCount =>
      notifications.where((n) => !n.isRead).length;

  List<ActivityItem> get recentActivities {
    final sorted = List<ActivityItem>.from(activities);
    sorted.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return sorted.take(5).toList();
  }

  ActivityState copyWith({
    AccountModel? account,
    List<ActivityItem>? activities,
    List<SplitModel>? splits,
    List<AppNotification>? notifications,
  }) {
    return ActivityState(
      account: account ?? this.account,
      activities: activities ?? this.activities,
      splits: splits ?? this.splits,
      notifications: notifications ?? this.notifications,
    );
  }
}

class ActivityNotifier extends StateNotifier<ActivityState> {
  ActivityNotifier()
    : super(
        ActivityState(
          account: AccountModel(
            userId: 'sarang@gmail.com', // Mock User
            currentBalance: 0.0,
            lastUpdated: DateTime.now(),
          ),
        ),
      ) {
    _loadInitialData();
  }

  void _loadInitialData() {
    // Phase 1: In-memory (Mock)
    // Eventually load from DB
  }

  // --- CORE LOGIC: THE MANIFESTO IMPLEMENTATION ---

  void logActivity(ActivityItem activity) {
    // 1. Update Account Logic (Transactional)
    final updatedAccount = _calculateNewAccountState(state.account, activity);

    // 2. Add Activity
    final newActivities = [activity, ...state.activities];

    // 3. Create Notification (Side Effect)
    final newNotification = _createNotificationFor(activity);
    final newNotifications = newNotification != null
        ? [newNotification, ...state.notifications]
        : state.notifications;

    // 4. Update State Atomically
    state = state.copyWith(
      account: updatedAccount,
      activities: newActivities,
      notifications: newNotifications,
    );
  }

  AccountModel _calculateNewAccountState(
    AccountModel current,
    ActivityItem activity,
  ) {
    double newBalance = current.currentBalance;
    double newIncome = current.totalIncome;
    double newExpense = current.totalExpense;
    // TODO: Handle Receivable/Payable for Splits

    if (activity.direction == ActivityDirection.credit) {
      newBalance += activity.amount;
      if (activity.type == ActivityType.income) {
        newIncome += activity.amount;
      }
    } else {
      newBalance -= activity.amount;
      if (activity.type == ActivityType.expense) {
        newExpense += activity.amount;
      }
    }

    return current.copyWith(
      currentBalance: newBalance,
      totalIncome: newIncome,
      totalExpense: newExpense,
      lastUpdated: DateTime.now(),
    );
  }

  AppNotification? _createNotificationFor(ActivityItem activity) {
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
      default:
        return null; // No notification for silent updates
    }

    return AppNotification(
      id: const Uuid().v4(),
      title: title,
      message: message,
      type: type,
      relatedActivityId: activity.id,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
  }

  void markNotificationsRead() {
    final updated = state.notifications
        .map((n) => n.copyWith(isRead: true))
        .toList();
    state = state.copyWith(notifications: updated);
  }

  // --- API FOR SPLIT LOGIC (Phase 1) ---

  void createSplit(SplitModel split) {
    // 1. Validate
    final totalShare = split.participants.fold(0.0, (sum, p) => sum + p.share);
    if ((totalShare - split.totalAmount).abs() > 0.1) {
      throw Exception(
        "Mismatch: Total ₹${split.totalAmount} vs Shares ₹$totalShare",
      );
    }

    // 2. Identify My Share
    final myId = state.account.userId;
    final myParticipant = split.participants.firstWhere(
      (p) => p.userId == myId,
      orElse: () => SplitParticipant(userId: myId, share: 0),
    );
    final myShare = myParticipant.share;
    final othersShare = split.totalAmount - myShare;

    // 3. Update Account (Transactional)
    // Cash: -Total (We paid full)
    // Expense: +MyShare
    // Receivable: +OthersShare

    final updatedAccount = state.account.copyWith(
      currentBalance: state.account.currentBalance - split.totalAmount,
      totalExpense: state.account.totalExpense + myShare,
      totalReceivable: state.account.totalReceivable + othersShare,
      lastUpdated: DateTime.now(),
    );

    // 4. Log Activity
    final activity = ActivityItem(
      id: const Uuid().v4(),
      type: ActivityType.split,
      title: 'Paid for ${split.title}',
      amount: split.totalAmount,
      direction: ActivityDirection.debit,
      source: ActivitySource.split_group,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      relatedId: split.id,
      metadata: {'myShare': myShare, 'receivable': othersShare},
      status: ActivityStatus.completed,
    );

    // 5. Update State
    state = state.copyWith(
      account: updatedAccount,
      splits: [split, ...state.splits],
      activities: [activity, ...state.activities],
    );
  }

  void settleSplit(String splitId, double amount, String payerName) {
    // 1. Validate
    final splitIndex = state.splits.indexWhere((s) => s.id == splitId);
    if (splitIndex == -1) throw Exception("Split not found");

    if (amount > state.account.totalReceivable) {
      // Allow it but warn? No, strict rule: "Cannot settle more than payable/receivable"
      // But receivable is global.
      // Strict check: if amount > receivable, something is wrong.
      // For now, allow it but log strict warning or clamp?
      // "Cannot settle if already paid".
    }

    // 2. Update Account (Transactional)
    // Cash: +Amount (Received)
    // Receivable: -Amount (Settled)

    final updatedAccount = state.account.copyWith(
      currentBalance: state.account.currentBalance + amount,
      totalReceivable: state.account.totalReceivable - amount,
      lastUpdated: DateTime.now(),
    );

    // 3. Log Activity
    final activity = ActivityItem(
      id: const Uuid().v4(),
      type: ActivityType.settlement,
      title: 'Received from $payerName',
      amount: amount,
      direction: ActivityDirection.credit,
      source: ActivitySource.manual, // or settlement source
      timestamp: DateTime.now().millisecondsSinceEpoch,
      relatedId: splitId,
    );

    // 4. Update Split Status (Simulated)
    // In a real app, find the participant and mark hasPaid=true

    state = state.copyWith(
      account: updatedAccount,
      activities: [activity, ...state.activities],
      // splits: updatedSplits... TODO
    );
  }

  /// Validates if an expense can be added.
  /// Returns error message if invalid, null if safe.
  String? validateExpense(double amount) {
    if (amount <= 0) return "Amount must be greater than 0";
    if (amount > state.account.currentBalance) {
      return "Warning: Expense exceeds current balance (₹${state.account.currentBalance.toStringAsFixed(2)})";
    }
    return null;
  }

  // --- COMPATIBILITY LAYERS ---

  void setOpeningBalance(double amount) {
    // Special case: direct override or credit?
    // User manifesto: "Balance changes ONLY via Income, Expense, Settlement"
    // Opening balance is essentially "Initial Income".
    final activity = ActivityItem(
      id: const Uuid().v4(),
      type: ActivityType.income,
      title: 'Opening Balance',
      amount: amount,
      direction: ActivityDirection.credit,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      source: ActivitySource.wallet,
    );

    // Reset state first if needed, but for now just log it.
    // Actually, setting opening balance usually implies "Starting fresh".
    if (state.account.currentBalance == 0) {
      logActivity(activity);
    } else {
      // Calculation adjustment if re-setting?
      // For now, treat as additional capital.
      logActivity(activity);
    }
  }

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
