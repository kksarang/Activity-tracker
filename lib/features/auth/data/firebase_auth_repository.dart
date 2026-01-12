import 'package:activity/features/auth/domain/auth_repository.dart';
import 'package:activity/features/auth/domain/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firestore;

  FirebaseAuthRepository({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    FirebaseFirestore? firestore,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
       _googleSignIn = googleSignIn ?? GoogleSignIn(),
       _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<UserModel?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map(_mapFirebaseUser);
  }

  @override
  UserModel? get currentUser => _mapFirebaseUser(_firebaseAuth.currentUser);

  UserModel? _mapFirebaseUser(User? user) {
    if (user == null) return null;
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? (user.isAnonymous ? 'Guest' : 'User'),
      photoUrl: user.photoURL,
      isEmailVerified: user.emailVerified,
      isAnonymous: user.isAnonymous,
    );
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // User canceled

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);

      final user = userCredential.user;
      if (user != null) {
        // Sync user to Firestore
        await _saveUserToFirestore(user);
        return _mapFirebaseUser(user);
      }
      return null;
    } catch (e) {
      throw Exception('Google Sign-In failed: $e');
    }
  }

  @override
  Future<UserModel?> signInWithEmail(String email, String password) async {
    try {
      final UserCredential result = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return _mapFirebaseUser(result.user);
    } catch (e) {
      throw Exception('Email Sign-In failed: $e');
    }
  }

  @override
  Future<UserModel?> signUpWithEmail(
    String email,
    String password,
    String name,
  ) async {
    try {
      final UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = result.user;
      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();
        // Send verification email
        await user.sendEmailVerification();

        // Sync to Firestore
        await _saveUserToFirestore(user, name: name);

        // Return updated user
        return _mapFirebaseUser(_firebaseAuth.currentUser);
      }
      return null;
    } catch (e) {
      throw Exception('Sign Up failed: $e');
    }
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        // Delete from Firestore (optional, cleaning up user data)
        await _firestore.collection('users').doc(user.uid).delete();

        // Delete from Auth
        await user.delete();
      }
    } catch (e) {
      throw Exception('Delete account failed: $e');
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = _firebaseAuth.currentUser;
    await user?.sendEmailVerification();
  }

  @override
  Future<UserModel?> signInAnonymously() async {
    try {
      final UserCredential result = await _firebaseAuth.signInAnonymously();
      // Anonymous users don't have email/name usually, so we map carefully
      return _mapFirebaseUser(result.user);
    } catch (e) {
      throw Exception('Guest Sign-In failed: $e');
    }
  }

  Future<void> _saveUserToFirestore(User user, {String? name}) async {
    final userRef = _firestore.collection('users').doc(user.uid);
    final doc = await userRef.get();
    if (!doc.exists) {
      await userRef.set({
        'id': user.uid,
        'email': user.email,
        'name': name ?? user.displayName,
        'photoUrl': user.photoURL,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }
}
