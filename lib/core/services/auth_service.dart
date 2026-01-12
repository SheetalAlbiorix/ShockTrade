import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shock_app/core/config/env.dart';
import 'package:shock_app/core/services/profile_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabaseClient;

  AuthService(this._supabaseClient);

  Timer? _refreshTimer;

  Future<void> exchangeTokenAndAuthenticate() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("No Firebase user found");
      }

      // 1. Get Firebase ID Token (forceRefresh: true to ensure fresh token for exchange)
      final idToken = await user.getIdToken(true);
      if (idToken == null) {
        throw Exception("Failed to get Firebase ID Token");
      }

      debugPrint("Extracted Firebase ID Token.");

      // 2. Call Edge Function 'exchange-token'
      // We send the Firebase token in the body.
      // We EXPLICITLY set the Authorization header to the Anon Key to satisfy the Supabase Gateway.
      final anonKey = Env.supabaseAnonKey;

      final response = await _supabaseClient.functions.invoke(
        'exchange-token',
        body: {
          'firebase_token': idToken,
        },
        headers: {
          'Authorization': 'Bearer $anonKey',
          'apikey': anonKey,
        },
      );

      final data = response.data;
      if (data == null || data['token'] == null) {
        throw Exception("Invalid response from exchange-token function: $data");
      }

      final supabaseJwt = data['token'] as String;
      debugPrint("Received Supabase JWT (Exchange Success).");

      // 3. Set the custom session on the Supabase client
      _supabaseClient.headers['Authorization'] = 'Bearer $supabaseJwt';

      debugPrint("Supabase Client configured with new JWT.");

      // 4. Start/Restart the Token Refresh Timer
      _startTokenRefreshTimer();

      // 5. Sync Profile to Supabase (Only needed on initial login, but harmless to call here generally,
      // although somewhat expensive. Should optimization be needed, we can flag if it's a refresh vs login)
      // For now, we will skip profile sync if it's just a background refresh to save resources,
      // but simplistic approach is fine. Let's keep it simple.
      try {
        final profileService = ProfileService(_supabaseClient);
        await profileService.syncProfile(
          id: user.uid,
          email: user.email!,
          fullName: user.displayName,
          avatarUrl: user.photoURL,
        );
      } catch (e) {
        debugPrint("Profile Sync Warning during exchange: $e");
      }
    } catch (e) {
      debugPrint("Token Exchange Failed: $e");
      // If auto-refresh fails, we might want to retry soon?
      // For now, simple rethrow.
      rethrow;
    }
  }

  /// Starts a timer to refresh the token proactively before it expires (e.g., every 50 mins).
  void _startTokenRefreshTimer() {
    _refreshTimer?.cancel();
    debugPrint("Starting Session Refresh Timer (50 minutes)...");

    // JWT expires in 60 mins. We refresh at 50 mins to be safe.
    _refreshTimer = Timer(const Duration(minutes: 50), () async {
      debugPrint("⏰ Session Refresh Timer Triggered. Refreshing Token...");
      try {
        await exchangeTokenAndAuthenticate();
        debugPrint("✅ Token Refreshed Successfully via Timer.");
      } catch (e) {
        debugPrint("❌ Proactive Token Refresh Failed: $e");
        // Retry logic could go here (e.g. try again in 1 min)
      }
    });
  }

  /// Restores the session if a user is logged in and verified.
  /// Returns 0 for success (Home), 1 for unverified (VerifyEmail), 2 for logged out (Onboarding).
  /// Using int/enum for state is cleaner, but for now I'll use simple logic or return an enum.
  /// Let's stick to the plan: return bool? No, we need 3 states.
  /// Let's return AuthState enum or simple int.
  /// 0: Authenticated -> Home
  /// 1: Unverified -> VerifyEmail
  /// 2: Unauthenticated -> Onboarding
  Future<int> restoreSession() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return 2;
      }

      await user.reload(); // Ensure we have latest verification status
      if (!user.emailVerified) {
        return 1;
      }

      // User verified, exchange token
      await exchangeTokenAndAuthenticate();
      return 0;
    } catch (e) {
      debugPrint("Session restoration failed: $e");
      // If exchange fails, treat as unauthenticated so they can login again explicitly
      return 2;
    }
  }

  /// Sends a password reset email to the given email address.
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      debugPrint("Password reset email sent to $email");
    } catch (e) {
      debugPrint("Failed to send password reset email: $e");
      rethrow;
    }
  }

  /// Signs out the user from both Firebase and Supabase.
  Future<void> signOut() async {
    try {
      _refreshTimer?.cancel(); // Stop the timer logic
      await FirebaseAuth.instance.signOut();
      // Clear Supabase Authorization header
      _supabaseClient.headers.remove('Authorization');
      // Optionally clear full session if we were using it, but we are using manual headers.
      // If we move to full Supabase Auth later, use _supabaseClient.auth.signOut();
      debugPrint("User signed out successfully.");
    } catch (e) {
      debugPrint("Sign out failed: $e");
      rethrow;
    }
  }
}
