import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabaseClient;

  AuthService(this._supabaseClient);

  bool get _isFirebaseInitialized => Firebase.apps.isNotEmpty;

  /// Exchanges the Firebase ID Token for a Supabase JWT
  Future<void> exchangeTokenAndAuthenticate() async {
    try {
      if (!_isFirebaseInitialized) {
        throw Exception("Firebase not initialized");
      }
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("No Firebase user found");
      }

      // 1. Get Firebase ID Token
      final idToken = await user.getIdToken();
      if (idToken == null) {
        throw Exception("Failed to get Firebase ID Token");
      }

      debugPrint("Extracted Firebase ID Token.");

      // 2. Call Edge Function 'exchange-token'
      // We send the Firebase token in the body.
      // We EXPLICITLY set the Authorization header to the Anon Key to satisfy the Supabase Gateway.
      const anonKey =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhobG9qeWRhbnlnb2F4d2F3dHBiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njc5NTk4MzAsImV4cCI6MjA4MzUzNTgzMH0.cuzRoGNm0xFGbzIK76aYiCw1OB0lSepM3yR8zZS9aA4';

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
      debugPrint("Received Supabase JWT: $supabaseJwt");

      // 3. Set the custom session on the Supabase client
      // This is crucial: We don't use Supabase Auth to signInWithPassword.
      // We manually set the accessToken.
      // NOTE: SupabaseFlutter currently relies on valid sessions.
      // If we just want to use the client for DB calls with this token,
      // we might need to recreate the client or use RestClient directly
      // if headers override isn't persistent.

      // However, usually setting the header globally is the way if we don't have a full session.
      // But Supabase Client supports `setSession` if we had a refresh token, which we don't here.
      // Simpler approach for RLS: Add Authorization header to all future requests.

      _supabaseClient.headers['Authorization'] = 'Bearer $supabaseJwt';

      debugPrint("Supabase Client configured with new JWT.");
    } catch (e) {
      debugPrint("Token Exchange Failed: $e");
      rethrow;
    }
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
      if (!_isFirebaseInitialized) {
        debugPrint(
            "Firebase not initialized. Skipping session restoration. Defaulting to logged out.");
        return 2;
      }
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

  /// Signs out the user from both Firebase and Supabase.
  Future<void> signOut() async {
    try {
      if (_isFirebaseInitialized) {
        await FirebaseAuth.instance.signOut();
      }
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
