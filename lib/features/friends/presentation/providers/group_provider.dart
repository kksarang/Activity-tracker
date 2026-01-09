import 'package:activity/features/friends/domain/group_model.dart';
import 'package:activity/features/friends/domain/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class GroupState {
  final List<GroupModel> groups;
  final List<UserModel> friends; // Mock source of truth for friends

  const GroupState({this.groups = const [], this.friends = const []});

  GroupState copyWith({List<GroupModel>? groups, List<UserModel>? friends}) {
    return GroupState(
      groups: groups ?? this.groups,
      friends: friends ?? this.friends,
    );
  }
}

class GroupNotifier extends StateNotifier<GroupState> {
  GroupNotifier() : super(const GroupState()) {
    _loadInitialData();
  }

  void _loadInitialData() {
    // Mock Data
    final initialFriends = [
      const UserModel(
        id: '1',
        name: 'Amanda',
        avatarUrl: 'https://i.pravatar.cc/150?u=1',
        email: 'amanda@example.com',
      ),
      const UserModel(
        id: '2',
        name: 'Jelly',
        avatarUrl: 'https://i.pravatar.cc/150?u=2',
        email: 'jelly@example.com',
      ),
      const UserModel(
        id: '3',
        name: 'Cody',
        avatarUrl: 'https://i.pravatar.cc/150?u=3',
        email: 'cody@example.com',
      ),
      const UserModel(
        id: '4',
        name: 'Alex',
        avatarUrl: 'https://i.pravatar.cc/150?u=4',
        email: 'alex@example.com',
      ),
      const UserModel(
        id: '5',
        name: 'Bella',
        avatarUrl: 'https://i.pravatar.cc/150?u=5',
        email: 'bella@example.com',
      ),
      const UserModel(
        id: '6',
        name: 'Charlie',
        avatarUrl: 'https://i.pravatar.cc/150?u=6',
        email: 'charlie@example.com',
      ),
      const UserModel(
        id: '7',
        name: 'David',
        avatarUrl: 'https://i.pravatar.cc/150?u=7',
        email: 'david@example.com',
      ),
      const UserModel(
        id: '8',
        name: 'Eva',
        avatarUrl: 'https://i.pravatar.cc/150?u=8',
        email: 'eva@example.com',
      ),
    ];

    final initialGroups = [
      GroupModel(
        id: 'g1',
        name: 'Goa Trip',
        members: [initialFriends[0], initialFriends[1]],
      ),
      GroupModel(
        id: 'g2',
        name: 'Office Lunch',
        members: [initialFriends[2], initialFriends[3], initialFriends[4]],
      ),
    ];

    state = state.copyWith(friends: initialFriends, groups: initialGroups);
  }

  void addGroup(String name, List<String> memberIds) {
    final members = state.friends
        .where((f) => memberIds.contains(f.id))
        .toList();
    final newGroup = GroupModel(
      id: const Uuid().v4(),
      name: name,
      members: members,
    );
    state = state.copyWith(groups: [...state.groups, newGroup]);
  }
}

final groupProvider = StateNotifierProvider<GroupNotifier, GroupState>((ref) {
  return GroupNotifier();
});
