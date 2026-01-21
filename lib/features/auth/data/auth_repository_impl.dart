import 'package:activity/core/network/api_exception.dart';
import 'package:activity/core/network/api_result.dart';
import 'package:activity/features/auth/data/auth_api_service.dart';
import 'package:activity/features/auth/domain/auth_repository.dart';
import 'package:activity/features/auth/domain/user_model.dart';
import 'package:activity/core/network/network_constants.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _apiService;

  AuthRepositoryImpl(this._apiService);

  @override
  Stream<UserModel?> get authStateChanges => Stream.empty(); // TODO: Implement socket/stream if needed

  @override
  UserModel? get currentUser => null; // TODO: Implement local storage persistence

  @override
  Future<ApiResult<UserModel>> signInWithEmail(
    String email,
    String password,
  ) async {
    try {
      final user = await _apiService.login(email, password);
      return Success(user);
    } on ApiException catch (e) {
      return Failure(e.message, code: e.statusCode);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<ApiResult<UserModel>> signUpWithEmail(
    String email,
    String password,
    String name,
  ) async {
    try {
      final user = await _apiService.signUp(email, password, name);
      return Success(user);
    } on ApiException catch (e) {
      return Failure(e.message, code: e.statusCode);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<ApiResult<void>> signInWithGoogle() async {
    try {
      // In a real app, you'd get the ID token from Google Sign In plugin here
      // String idToken = await googleSignIn.currentUser.authentication.idToken;
      final user = await _apiService.signInWithGoogle('mock_id_token');
      return const Success(null); // Or return user if needed
    } on ApiException catch (e) {
      return Failure(e.message, code: e.statusCode);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<ApiResult<void>> signInAnonymously() async {
    // API might not support anonymous, or it handles it differently
    return const Success(null);
  }

  @override
  Future<ApiResult<void>> deleteAccount() async {
    // Implement delete account API call
    return const Success(null);
  }

  @override
  Future<void> signOut() async {
    // Clear local tokens
  }

  @override
  Future<void> sendEmailVerification() async {
    // API call for verification
  }
}
