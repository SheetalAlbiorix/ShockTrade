import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/features/auth/application/state/auth_state.dart';
import 'package:shock_app/features/auth/domain/usecases/login_usecase.dart';

/// Controller for managing authentication state
class AuthController extends StateNotifier<AuthState> {
  final LoginUseCase loginUseCase;

  AuthController({
    required this.loginUseCase,
  }) : super(const AuthState.initial());

  /// Login with email and password
  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();

    try {
      final user = await loginUseCase(
        email: email,
        password: password,
      );

      state = AuthState.authenticated(user: user);
    } catch (e) {
      state = AuthState.error(message: e.toString());
    }
  }

  /// Logout the current user
  void logout() {
    state = const AuthState.unauthenticated();
  }
}
