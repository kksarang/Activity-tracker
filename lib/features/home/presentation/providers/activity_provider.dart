import 'package:activity/features/bills/presentation/providers/split_bill_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityState {
  final List<SplitBillState> activities;

  const ActivityState({this.activities = const []});

  ActivityState copyWith({List<SplitBillState>? activities}) {
    return ActivityState(activities: activities ?? this.activities);
  }
}

class ActivityNotifier extends StateNotifier<ActivityState> {
  ActivityNotifier() : super(const ActivityState()) {
    _loadInitialData();
  }

  void _loadInitialData() {
    // Optional: Load initial mock data here if needed, or start empty.
    // Starting empty to clean up "unwanted datas" as requested.
    state = const ActivityState(activities: []);
  }

  void addBill(SplitBillState bill) {
    state = state.copyWith(activities: [bill, ...state.activities]);
  }
}

final activityProvider = StateNotifierProvider<ActivityNotifier, ActivityState>(
  (ref) {
    return ActivityNotifier();
  },
);
