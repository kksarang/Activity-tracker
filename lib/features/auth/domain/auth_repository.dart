import 'package:activity/core/network/api_result.dart';
import 'package:activity/features/auth/domain/user_model.dart';

abstract class AuthRepository {
  Stream<UserModel?> get authStateChanges;

  Future<ApiResult<UserModel>> signInWithEmail(String email, String password);

  Future<ApiResult<UserModel>> signUpWithEmail(
    String email,
    String password,
    String name,
  );

  Future<ApiResult<void>> signInWithGoogle();

  Future<ApiResult<void>> signInAnonymously();

  Future<void> signOut();
  Future<ApiResult<void>> deleteAccount();
  Future<void> sendEmailVerification();
  UserModel? get currentUser;
}
