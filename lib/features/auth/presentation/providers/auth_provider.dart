import 'package:activity/core/network/api_client.dart';
import 'package:activity/core/network/api_result.dart';
import 'package:activity/features/auth/data/auth_api_service.dart';
import 'package:activity/features/auth/data/auth_repository_impl.dart';
import 'package:activity/features/auth/domain/auth_repository.dart';
import 'package:activity/features/auth/domain/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. Dio Instance
final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

// 2. ApiClient
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref.watch(dioProvider));
});

// 3. AuthApiService
final authApiServiceProvider = Provider<AuthApiService>((ref) {
  return AuthApiService(ref.watch(apiClientProvider));
});

// 4. AuthRepository (Using Implementation)
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(authApiServiceProvider));
});

// 5. Auth State (User Stream) - Keep native StreamProvider for auth state changes
final authStateProvider = StreamProvider<UserModel?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges;
});

// 6. Auth Controller (Manages login/signup state via ApiResult)
class AuthController extends StateNotifier<ApiResult<void>> {
  final AuthRepository _authRepository;

  AuthController(this._authRepository)
    : super(
        const Loading(),
      ); // Initial state could be specialized 'Idle' if needed

  Future<void> signInWithGoogle() async {
    state = const Loading();
    final result = await _authRepository.signInWithGoogle();
    state = result;
  }

  Future<void> signInWithEmail(String email, String password) async {
    state = const Loading();
    final result = await _authRepository.signInWithEmail(email, password);
    // We map generic success (UserModel) to void for the state if we don't need the user object directly in state
    if (result is Success) {
      state = const Success(null);
    } else if (result is Failure) {
      state = Failure(
        (result as Failure).message,
        code: (result as Failure).code,
      );
    }
  }

  Future<void> signUpWithEmail(
    String email,
    String password,
    String name,
  ) async {
    state = const Loading();
    final result = await _authRepository.signUpWithEmail(email, password, name);
    if (result is Success) {
      state = const Success(null);
    } else if (result is Failure) {
      state = Failure(
        (result as Failure).message,
        code: (result as Failure).code,
      );
    }
  }

  Future<void> signInAnonymously() async {
    state = const Loading();
    final result = await _authRepository.signInAnonymously();
    state = result;
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
  }

  Future<void> deleteAccount() async {
    state = const Loading();
    final result = await _authRepository.deleteAccount();
    state = result;
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, ApiResult<void>>((ref) {
      return AuthController(ref.watch(authRepositoryProvider));
    });
