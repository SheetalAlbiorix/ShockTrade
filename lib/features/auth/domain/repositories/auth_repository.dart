import 'package:shock_app/features/auth/domain/entities/user.dart';

/// Abstract repository for authentication operations
abstract class AuthRepository {
  /// Login with email and password
  /// Returns User on success, throws exception on failure
  Future<User> login({
    required String email,
    required String password,
  });

  /// Logout the current user
  Future<void> logout();

  /// Get the currently authenticated user, if any
  Future<User?> getCurrentUser();

  /// Check if user is authenticated
  Future<bool> isAuthenticated();
}
