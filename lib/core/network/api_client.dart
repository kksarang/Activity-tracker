import 'package:activity/core/network/api_exception.dart';
import 'package:activity/core/network/network_constants.dart';
import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient(this.dio) {
    dio.options
      ..baseUrl = NetworkConstants.baseUrl
      ..connectTimeout = NetworkConstants.connectTimeout
      ..receiveTimeout = NetworkConstants.receiveTimeout
      ..headers = {'Content-Type': 'application/json'};
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await dio.post(path, data: data);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await dio.put(path, data: data);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<Response> delete(String path, {dynamic data}) async {
    try {
      return await dio.delete(path, data: data);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }
}
