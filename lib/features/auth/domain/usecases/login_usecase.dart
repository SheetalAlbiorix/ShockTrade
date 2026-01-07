import 'package:shock_app/features/auth/domain/entities/user.dart';
import 'package:shock_app/features/auth/domain/repositories/auth_repository.dart';

/// Use case for user login
class LoginUseCase {
  final AuthRepository repository;

  const LoginUseCase({required this.repository});

  /// Execute login with email and password
  Future<User> call({
    required String email,
    required String password,
  }) async {
    // Add any business logic validation here
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password cannot be empty');
    }

    return await repository.login(email: email, password: password);
  }
}
