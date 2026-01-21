import 'package:activity/core/network/api_client.dart';
import 'package:activity/features/auth/domain/user_model.dart';
import 'package:dio/dio.dart';

class AuthApiService {
  final ApiClient apiClient;

  AuthApiService(this.apiClient);

  Future<UserModel> login(String email, String password) async {
    final response = await apiClient.post(
      '/login',
      data: {'email': email, 'password': password},
    );
    return UserModel.fromJson(response.data);
  }

  Future<UserModel> signUp(String email, String password, String name) async {
    final response = await apiClient.post(
      '/signup',
      data: {'email': email, 'password': password, 'name': name},
    );
    return UserModel.fromJson(response.data);
  }

  Future<void> forgotPassword(String email) async {
    await apiClient.post('/forgot-password', data: {'email': email});
  }

  // Placeholder for real Google Sign In backend exchange
  Future<UserModel> signInWithGoogle(String idToken) async {
    final response = await apiClient.post(
      '/google-signin',
      data: {'idToken': idToken},
    );
    return UserModel.fromJson(response.data);
  }
}
