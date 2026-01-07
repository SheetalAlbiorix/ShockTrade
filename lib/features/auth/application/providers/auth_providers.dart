import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/di/di.dart';
import 'package:shock_app/features/auth/application/controllers/auth_controller.dart';
import 'package:shock_app/features/auth/application/state/auth_state.dart';
import 'package:shock_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:shock_app/features/auth/domain/usecases/login_usecase.dart';

/// Provider for AuthRepository - bridges GetIt and Riverpod
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return getIt<AuthRepository>();
});

/// Provider for LoginUseCase
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return getIt<LoginUseCase>();
});

/// Provider for AuthController - manages authentication state
final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  final loginUseCase = ref.watch(loginUseCaseProvider);

  return AuthController(loginUseCase: loginUseCase);
});
