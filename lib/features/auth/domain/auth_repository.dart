import 'package:activity/features/auth/domain/user_model.dart';

abstract class AuthRepository {
  Stream<UserModel?> get authStateChanges;
  Future<UserModel?> signInWithGoogle();
  Future<UserModel?> signInWithEmail(String email, String password);
  Future<UserModel?> signInAnonymously();
  Future<UserModel?> signUpWithEmail(
    String email,
    String password,
    String name,
  );
  Future<void> signOut();
  Future<void> deleteAccount();
  Future<void> sendEmailVerification();
  UserModel? get currentUser;
}
