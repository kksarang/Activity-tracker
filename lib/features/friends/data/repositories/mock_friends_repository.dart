import 'package:activity/features/friends/domain/entities/friend_model.dart';
import 'package:activity/features/friends/domain/entities/invite_model.dart';
import 'package:activity/features/friends/domain/repositories/friends_repository.dart';
import 'package:uuid/uuid.dart';

class MockFriendsRepository implements FriendsRepository {
  final List<FriendModel> _mockFriends = [
    FriendModel(
      id: '1',
      name: 'Amanda',
      email: 'amanda@example.com',
      avatarUrl: 'https://ui-avatars.com/api/?name=Amanda&background=random',
      status: FriendStatus.accepted,
    ),
    FriendModel(
      id: '2',
      name: 'Jelly',
      email: 'jelly@example.com',
      avatarUrl: 'https://ui-avatars.com/api/?name=Jelly&background=random',
      status: FriendStatus.accepted,
    ),
    FriendModel(
      id: '3',
      name: 'Dr. Code',
      email: 'drcode@example.com',
      avatarUrl: 'https://ui-avatars.com/api/?name=Dr+Code&background=random',
      status: FriendStatus.pending, // Request received
    ),
  ];

  @override
  Future<List<FriendModel>> getFriends() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockFriends
        .where((f) => f.status == FriendStatus.accepted)
        .toList();
  }

  @override
  Future<List<FriendModel>> getFriendRequests() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockFriends.where((f) => f.status == FriendStatus.pending).toList();
  }

  @override
  Future<void> sendFriendRequest(String email) async {
    await Future.delayed(const Duration(milliseconds: 800));
    // Simulate success
  }

  @override
  Future<void> acceptFriendRequest(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _mockFriends.indexWhere((f) => f.id == userId);
    if (index != -1) {
      _mockFriends[index] = _mockFriends[index].copyWith(
        status: FriendStatus.accepted,
      );
    }
  }

  @override
  Future<void> blockUser(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _mockFriends.removeWhere((f) => f.id == userId);
  }

  @override
  Future<InviteModel> generateInviteLink() async {
    await Future.delayed(const Duration(milliseconds: 100)); // Fast!
    final code = const Uuid().v4().substring(0, 6).toUpperCase();
    return InviteModel(
      code: code,
      inviterId: 'current_user',
      dynamicLink: 'https://activity.app/invite?c=$code',
      expiresAt: DateTime.now().add(const Duration(days: 7)),
    );
  }

  @override
  Future<void> processInviteLink(String code) async {
    await Future.delayed(const Duration(seconds: 2));
    // Simulate adding a new friend from the link
    _mockFriends.add(
      FriendModel(
        id: const Uuid().v4(),
        name: 'New Friend ($code)',
        email: 'new@friend.com',
        avatarUrl: 'https://ui-avatars.com/api/?name=New&background=random',
        status: FriendStatus.accepted,
      ),
    );
  }
}
