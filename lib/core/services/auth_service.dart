import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabaseClient;

  AuthService(this._supabaseClient);

  /// Exchanges the Firebase ID Token for a Supabase JWT
  Future<void> exchangeTokenAndAuthenticate() async {
    try {
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
}
