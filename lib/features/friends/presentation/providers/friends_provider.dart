import 'dart:async';
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
  final String? errorMessage;

  const FriendsState({
    this.friends = const [],
    this.requests = const [],
    this.isLoading = false,
    this.activeInvite,
    this.errorMessage,
  });

  FriendsState copyWith({
    List<FriendModel>? friends,
    List<FriendModel>? requests,
    bool? isLoading,
    InviteModel? activeInvite,
    String? errorMessage,
    bool clearError = false,
  }) {
    return FriendsState(
      friends: friends ?? this.friends,
      requests: requests ?? this.requests,
      isLoading: isLoading ?? this.isLoading,
      activeInvite: activeInvite ?? this.activeInvite,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class FriendsNotifier extends StateNotifier<FriendsState> {
  final FriendsRepository _repository;
  StreamSubscription? _friendsSub;
  StreamSubscription? _requestsSub;

  FriendsNotifier(this._repository) : super(const FriendsState()) {
    _init();
  }

  void _init() {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      _friendsSub = _repository.getFriends().listen(
        (friends) {
          state = state.copyWith(friends: friends, isLoading: false);
        },
        onError: (e) {
          state = state.copyWith(
            errorMessage: e.toString().replaceAll('Exception: ', ''),
            isLoading: false,
          );
        },
      );

      _requestsSub = _repository.getFriendRequests().listen(
        (requests) {
          state = state.copyWith(requests: requests, isLoading: false);
        },
        onError: (e) {
          state = state.copyWith(
            errorMessage: e.toString().replaceAll('Exception: ', ''),
            isLoading: false,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString().replaceAll('Exception: ', ''),
        isLoading: false,
      );
    }
  }

  @override
  void dispose() {
    _friendsSub?.cancel();
    _requestsSub?.cancel();
    super.dispose();
  }

  Future<void> generateInvite() async {
    if (state.activeInvite != null && !state.activeInvite!.isExpired) {
      return;
    }

    try {
      final invite = await _repository.generateInviteLink();
      state = state.copyWith(activeInvite: invite, clearError: true);
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  Future<void> acceptRequest(String userId) async {
    try {
      await _repository.acceptFriendRequest(userId);
      // No need to reload, stream will update
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  Future<void> blockUser(String userId) async {
    try {
      await _repository.blockUser(userId);
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }

  Future<void> simulateDeepLink(String code) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _repository.processInviteLink(code);
      // No need to reload
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
    }
  }
}

final friendsProvider = StateNotifierProvider<FriendsNotifier, FriendsState>((
  ref,
) {
  final repo = ref.watch(friendsRepositoryProvider);
  return FriendsNotifier(repo);
});
