import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/features/auth/application/state/auth_state.dart';
import 'package:shock_app/features/auth/domain/entities/user.dart';
import 'package:shock_app/features/auth/domain/usecases/login_usecase.dart';

/// Controller for managing authentication state
class AuthController extends StateNotifier<AuthState> {
  final LoginUseCase loginUseCase;

  AuthController({
    required this.loginUseCase,
  }) : super(const AuthState.initial());

  /// Login with email and password (using static credentials for testing)
  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();

    try {
      // Static credentials for testing (bypass API)
      if (email == 'test@test.com' && password == 'test123') {
        // Simulate network delay
        await Future.delayed(const Duration(milliseconds: 500));

        // Create a mock user
        final user = User(
          id: '1',
          email: email,
          name: 'Test User',
        );

        state = AuthState.authenticated(user: user);
      } else {
        state = const AuthState.error(
          message: 'Invalid credentials. Use test@test.com / test123',
        );
      }
    } catch (e) {
      state = AuthState.error(message: e.toString());
    }
  }

  /// Logout the current user
  void logout() {
    state = const AuthState.unauthenticated();
  }
}
