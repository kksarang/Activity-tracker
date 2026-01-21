import 'package:activity/features/friends/domain/entities/friend_model.dart';
import 'package:activity/features/friends/domain/entities/invite_model.dart';
import 'package:activity/features/friends/domain/repositories/friends_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FriendsRepositoryImpl implements FriendsRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  FriendsRepositoryImpl({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  String? get _currentUserId => _auth.currentUser?.uid;

  void _checkAuth() {
    if (_currentUserId == null) {
      throw Exception('User not logged in');
    }
  }

  @override
  Stream<List<FriendModel>> getFriends() {
    _checkAuth();
    return _firestore
        .collection('friendships')
        .where('users', arrayContains: _currentUserId!)
        .where('status', isEqualTo: 'accepted')
        .snapshots()
        .asyncMap(_mapSnapshotToFriends);
  }

  @override
  Stream<List<FriendModel>> getFriendRequests() {
    _checkAuth();
    // Incoming requests: status 'pending' AND actionUserId is NOT me
    return _firestore
        .collection('friendships')
        .where('users', arrayContains: _currentUserId!)
        .where('status', isEqualTo: 'pending')
        .where('actionUserId', isNotEqualTo: _currentUserId!)
        .snapshots()
        .asyncMap(_mapSnapshotToFriends);
  }

  Future<List<FriendModel>> _mapSnapshotToFriends(
    QuerySnapshot snapshot,
  ) async {
    if (snapshot.docs.isEmpty) return [];

    final friendIds = <String>{};
    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final users = List<String>.from(data['users'] as List);
      final friendId = users.firstWhere((id) => id != _currentUserId!);
      friendIds.add(friendId);
    }

    if (friendIds.isEmpty) return [];

    // Fetch user details for these friends
    // Note: In a real app, you might chunk this if > 10 items
    final usersSnapshot = await _firestore
        .collection('users')
        .where(FieldPath.documentId, whereIn: friendIds.toList())
        .get();

    return usersSnapshot.docs.map((doc) {
      final data = doc.data();
      return FriendModel.fromJson({
        'id': doc.id,
        ...data,
        'status': 'accepted', // Simplified for list view
      });
    }).toList();
  }

  @override
  Future<void> sendFriendRequest(String email) async {
    _checkAuth();
    // 1. Find user by email
    final userQuery = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (userQuery.docs.isEmpty) {
      throw Exception('User not found');
    }

    final targetUserId = userQuery.docs.first.id;
    if (targetUserId == _currentUserId!) {
      throw Exception('Cannot add yourself');
    }

    // 2. Check if friendship already exists
    final existingCheck = await _firestore
        .collection('friendships')
        .where('users', arrayContains: _currentUserId!)
        .get();

    final alreadyConnected = existingCheck.docs.any((doc) {
      final users = List<String>.from(doc['users']);
      return users.contains(targetUserId);
    });

    if (alreadyConnected) {
      throw Exception('Interaction already exists');
    }

    // 3. Create Friendship Doc
    await _firestore.collection('friendships').add({
      'users': [_currentUserId!, targetUserId],
      'status': 'pending',
      'actionUserId': _currentUserId!,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> acceptFriendRequest(String friendId) async {
    _checkAuth();
    // Find the specific friendship doc
    final snapshot = await _firestore
        .collection('friendships')
        .where('users', arrayContains: _currentUserId!)
        .where('actionUserId', isEqualTo: friendId) // The other person sent it
        .where('status', isEqualTo: 'pending')
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      await snapshot.docs.first.reference.update({
        'status': 'accepted',
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Future<void> blockUser(String userId) async {
    _checkAuth();

    // 1. Check if ANY relationship exists (pending or accepted)
    final snapshot = await _firestore
        .collection('friendships')
        .where('users', arrayContains: _currentUserId!)
        .get();

    // Filter where other user is target
    final doc = snapshot.docs
        .cast<QueryDocumentSnapshot<Map<String, dynamic>>?>()
        .firstWhere((d) {
          final users = List<String>.from(d!.data()['users']);
          return users.contains(userId);
        }, orElse: () => null);

    if (doc != null) {
      // Update existing
      await doc.reference.update({
        'status': 'blocked',
        'actionUserId': _currentUserId!,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } else {
      // Create new blocked doc (pre-emptive block)
      await _firestore.collection('friendships').add({
        'users': [_currentUserId!, userId],
        'status': 'blocked',
        'actionUserId': _currentUserId!,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Future<InviteModel> generateInviteLink() async {
    _checkAuth();
    final code = const Uuid().v4().substring(0, 6).toUpperCase();
    final expiresAt = DateTime.now().add(const Duration(days: 7));

    // Save to Firestore
    await _firestore.collection('invites').doc(code).set({
      'code': code,
      'inviterId': _currentUserId!,
      'createdAt': FieldValue.serverTimestamp(),
      'expiresAt': Timestamp.fromDate(expiresAt),
      'maxUses': 10,
      'useCount': 0,
      'status': 'active',
    });

    return InviteModel(
      code: code,
      inviterId: _currentUserId!,
      dynamicLink: 'https://activity.app/invite?c=$code',
      expiresAt: expiresAt,
    );
  }

  @override
  Future<void> processInviteLink(String code) async {
    _checkAuth();
    // 1. Validate Invite
    final inviteDoc = await _firestore.collection('invites').doc(code).get();
    if (!inviteDoc.exists) throw Exception('Invalid invite code');

    final data = inviteDoc.data()!;
    final inviterId = data['inviterId'] as String;

    if (inviterId == _currentUserId!) {
      throw Exception('Cannot accept your own invite');
    }

    // 2. Create Friendship
    await _firestore.collection('friendships').add({
      'users': [_currentUserId!, inviterId],
      'status': 'accepted', // Direct accept for invites
      'actionUserId': _currentUserId!, // I accepted it
      'source': 'invite:$code',
      'createdAt': FieldValue.serverTimestamp(),
    });

    // 3. Increment Use Count (Atomic)
    await inviteDoc.reference.update({'useCount': FieldValue.increment(1)});
  }
}
