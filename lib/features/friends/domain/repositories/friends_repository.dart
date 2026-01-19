import 'package:activity/features/friends/domain/entities/friend_model.dart';
import 'package:activity/features/friends/domain/entities/invite_model.dart';

abstract class FriendsRepository {
  Future<List<FriendModel>> getFriends();
  Future<List<FriendModel>> getFriendRequests();
  Future<void> sendFriendRequest(String email);
  Future<void> acceptFriendRequest(String friendshipId);
  Future<void> blockUser(String userId);

  // Invite System
  Future<InviteModel> generateInviteLink();
  Future<void> processInviteLink(String code);
}
