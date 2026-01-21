import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  factory ApiException.fromDio(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ApiException('Connection timeout');
      case DioExceptionType.sendTimeout:
        return ApiException('Send timeout');
      case DioExceptionType.receiveTimeout:
        return ApiException('Server timeout');
      case DioExceptionType.badResponse:
        return ApiException(
          e.response?.data['message'] ?? 'Something went wrong',
          statusCode: e.response?.statusCode,
        );
      case DioExceptionType.cancel:
        return ApiException('Request cancelled');
      case DioExceptionType.connectionError:
        return ApiException('No internet connection');
      case DioExceptionType.unknown:
        return ApiException('Unexpected error occurred');
      default:
        return ApiException('Something went wrong');
    }
  }
}
