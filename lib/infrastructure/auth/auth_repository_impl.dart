import 'package:dio/dio.dart';
import 'package:shock_app/features/auth/domain/entities/user.dart';
import 'package:shock_app/features/auth/domain/repositories/auth_repository.dart';

/// Implementation of AuthRepository using Dio for HTTP requests
class AuthRepositoryImpl implements AuthRepository {
  final Dio dio;

  const AuthRepositoryImpl({required this.dio});

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      return User.fromJson(response.data['user'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dio.post('/auth/logout');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final response = await dio.get('/auth/me');
      if (response.data == null) return null;
      return User.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      final user = await getCurrentUser();
      return user != null;
    } catch (e) {
      return false;
    }
  }

  Exception _handleDioError(DioException error) {
    if (error.response != null) {
      final statusCode = error.response!.statusCode;
      final message = error.response!.data['message'] ?? 'An error occurred';

      if (statusCode == 401) {
        return Exception('Invalid credentials');
      } else if (statusCode == 500) {
        return Exception('Server error: $message');
      }
      return Exception(message);
    } else {
      return Exception('Network error: ${error.message}');
    }
  }
}
