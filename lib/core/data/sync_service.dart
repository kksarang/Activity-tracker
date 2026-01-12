import 'package:activity/core/data/database_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SyncService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DatabaseHelper _localDb = DatabaseHelper.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> syncData() async {
    final user = _auth.currentUser;
    if (user == null || user.isAnonymous) return;

    // 1. Push local changes to Firestore
    await _pushLocalChanges(user.uid);

    // 2. Pull remote changes from Firestore
    await _pullRemoteChanges(user.uid);
  }

  Future<void> _pushLocalChanges(String userId) async {
    final db = await _localDb.database;
    // Example: Fetch unsynced activities
    final unsyncedActivities = await db.query(
      'activities',
      where: 'isSynced = ? AND userId = ?',
      whereArgs: [0, userId],
    );

    final batch = _firestore.batch();

    for (var activity in unsyncedActivities) {
      final docRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('activities')
          .doc(activity['id'] as String);
      batch.set(docRef, _convertLocalToRemote(activity));
      // Mark as synced locally pending success?
    }

    await batch.commit();

    // Mark as synched locally
    for (var activity in unsyncedActivities) {
      await db.update(
        'activities',
        {'isSynced': 1},
        where: 'id = ?',
        whereArgs: [activity['id']],
      );
    }
  }

  Future<void> _pullRemoteChanges(String userId) async {
    // Fetch latest from Firestore based on last sync timestamp
    // Update local DB
  }

  Map<String, dynamic> _convertLocalToRemote(Map<String, dynamic> local) {
    final map = Map<String, dynamic>.from(local);
    map.remove('isSynced');
    // Convert timestamps if needed
    return map;
  }
}
