import 'package:activity/features/friends/data/repositories/friends_repository_impl.dart';
import 'package:activity/features/friends/domain/entities/friend_model.dart';
import 'package:activity/features/friends/domain/entities/invite_model.dart';
import 'package:activity/features/friends/domain/repositories/friends_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Repository Provider
final friendsRepositoryProvider = Provider<FriendsRepository>((ref) {
  // Switch to Real Impl
  return FriendsRepositoryImpl();
});

// State
class FriendsState {
  final List<FriendModel> friends;
  final List<FriendModel> requests;
  final bool isLoading;
  final InviteModel? activeInvite;

  const FriendsState({
    this.friends = const [],
    this.requests = const [],
    this.isLoading = false,
    this.activeInvite,
  });

  FriendsState copyWith({
    List<FriendModel>? friends,
    List<FriendModel>? requests,
    bool? isLoading,
    InviteModel? activeInvite,
  }) {
    return FriendsState(
      friends: friends ?? this.friends,
      requests: requests ?? this.requests,
      isLoading: isLoading ?? this.isLoading,
      activeInvite: activeInvite ?? this.activeInvite,
    );
  }
}

class FriendsNotifier extends StateNotifier<FriendsState> {
  final FriendsRepository _repository;

  FriendsNotifier(this._repository) : super(const FriendsState()) {
    loadFriends();
  }

  Future<void> loadFriends() async {
    state = state.copyWith(isLoading: true);
    try {
      final friends = await _repository.getFriends();
      final requests = await _repository.getFriendRequests();
      state = state.copyWith(
        friends: friends,
        requests: requests,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> generateInvite() async {
    // Check cache (in state) first - O(1)
    if (state.activeInvite != null && !state.activeInvite!.isExpired) {
      return;
    }

    final invite = await _repository.generateInviteLink();
    state = state.copyWith(activeInvite: invite);
  }

  Future<void> acceptRequest(String userId) async {
    await _repository.acceptFriendRequest(userId);
    await loadFriends(); // Refresh list
  }

  // Debug method to simulate deep link
  Future<void> simulateDeepLink(String code) async {
    state = state.copyWith(isLoading: true);
    await _repository.processInviteLink(code);
    await loadFriends();
  }
}

final friendsProvider = StateNotifierProvider<FriendsNotifier, FriendsState>((
  ref,
) {
  final repo = ref.watch(friendsRepositoryProvider);
  return FriendsNotifier(repo);
});
