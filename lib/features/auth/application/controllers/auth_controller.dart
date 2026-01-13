import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:shock_app/features/auth/application/state/auth_state.dart';
import 'package:shock_app/features/auth/domain/entities/user.dart';
import 'package:shock_app/features/auth/domain/usecases/login_usecase.dart';
import 'dart:async';

/// Controller for managing authentication state
class AuthController extends StateNotifier<AuthState> {
  final LoginUseCase loginUseCase;

  AuthController({
    required this.loginUseCase,
  }) : super(const AuthState.initial()) {
    _init();
    _listenToAuthChanges();
  }

  StreamSubscription? _firebaseAuthSubscription;

  void _init() {
    final firebaseUser = firebase.FirebaseAuth.instance.currentUser;
    final supabaseUser = supabase.Supabase.instance.client.auth.currentUser;

    print('DEBUG: AuthController _init - Firebase: ${firebaseUser?.uid}, Supabase: ${supabaseUser?.id}');

    if (firebaseUser != null) {
      state = AuthState.authenticated(
        user: User(
          id: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          name: firebaseUser.displayName ?? 'User',
          avatarUrl: firebaseUser.photoURL,
        ),
      );
    } else if (supabaseUser != null) {
      state = AuthState.authenticated(
        user: User(
          id: supabaseUser.id,
          email: supabaseUser.email ?? '',
          name: supabaseUser.userMetadata?['full_name'] ?? 'User',
        ),
      );
    } else {
      state = const AuthState.unauthenticated();
    }
  }

  void _listenToAuthChanges() {
    _firebaseAuthSubscription = firebase.FirebaseAuth.instance.authStateChanges().listen((firebaseUser) {
      print('DEBUG: AuthController - Firebase authStateChanges: ${firebaseUser?.uid}');
      if (firebaseUser != null) {
        state = AuthState.authenticated(
          user: User(
            id: firebaseUser.uid,
            email: firebaseUser.email ?? '',
            name: firebaseUser.displayName ?? 'User',
            avatarUrl: firebaseUser.photoURL,
          ),
        );
      } else {
        // Only set unauthenticated if Supabase is also nil
        final supabaseUser = supabase.Supabase.instance.client.auth.currentUser;
        if (supabaseUser == null) {
          state = const AuthState.unauthenticated();
        }
      }
    });
  }

  @override
  void dispose() {
    _firebaseAuthSubscription?.cancel();
    super.dispose();
  }

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
