import 'package:activity/features/friends/domain/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SplitType { equal, custom }

class SplitBillState {
  final String title;
  final double totalAmount;
  final List<UserModel> participants;
  final SplitType splitType;
  final Map<String, double> customAmounts;

  const SplitBillState({
    this.title = '',
    this.totalAmount = 0,
    this.participants = const [],
    this.splitType = SplitType.equal,
    this.customAmounts = const {},
  });

  SplitBillState copyWith({
    String? title,
    double? totalAmount,
    List<UserModel>? participants,
    SplitType? splitType,
    Map<String, double>? customAmounts,
  }) {
    return SplitBillState(
      title: title ?? this.title,
      totalAmount: totalAmount ?? this.totalAmount,
      participants: participants ?? this.participants,
      splitType: splitType ?? this.splitType,
      customAmounts: customAmounts ?? this.customAmounts,
    );
  }
}

class SplitBillNotifier extends StateNotifier<SplitBillState> {
  SplitBillNotifier() : super(const SplitBillState());

  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  void setAmount(double amount) {
    state = state.copyWith(totalAmount: amount);
  }

  void addParticipant(UserModel user) {
    if (!state.participants.any((p) => p.id == user.id)) {
      state = state.copyWith(participants: [...state.participants, user]);
    }
  }

  void removeParticipant(String userId) {
    state = state.copyWith(
      participants: state.participants.where((p) => p.id != userId).toList(),
    );
  }

  void setSplitType(SplitType type) {
    state = state.copyWith(splitType: type);
  }

  void updateCustomAmount(String userId, double amount) {
    final newCustomAmounts = Map<String, double>.from(state.customAmounts);
    newCustomAmounts[userId] = amount;
    state = state.copyWith(customAmounts: newCustomAmounts);
  }

  void reset() {
    state = const SplitBillState();
  }
}

final splitBillProvider =
    StateNotifierProvider<SplitBillNotifier, SplitBillState>((ref) {
      return SplitBillNotifier();
    });
