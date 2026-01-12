import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  final SupabaseClient _supabase;

  ProfileService(this._supabase);

  /// Syncs the user's profile data to the 'profiles' table.
  /// This should be called after a successful login.
  Future<void> syncProfile({
    required String id,
    required String email,
    String? fullName,
    String? avatarUrl,
  }) async {
    try {
      final updates = {
        'id': id,
        'email': email,
        'updated_at': DateTime.now().toIso8601String(),
        if (fullName != null) 'full_name': fullName,
        if (avatarUrl != null) 'avatar_url': avatarUrl,
      };

      // Upsert: Insert if new, Update if exists
      await _supabase.from('profiles').upsert(updates);
      debugPrint('Profile synced successfully for $id');
    } catch (e) {
      debugPrint('Error syncing profile: $e');
      rethrow;
    }
  }

  /// Fetches the current user's profile.
  Future<Map<String, dynamic>?> getProfile(String userId) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();
      return response;
    } catch (e) {
      debugPrint('Error fetching profile: $e');
      return null;
    }
  }

  /// Uploads the avatar image to Supabase Storage and returns the public URL.
  Future<String> uploadAvatar(File imageFile, String userId) async {
    try {
      // FIX: The default _supabase.storage getter might use the Anon Key
      // because we don't have a standard Supabase session.
      // We manually construct the Storage Client with our Custom JWT header.
      final authHeader = _supabase.headers['Authorization'];
      if (authHeader == null) {
        throw Exception("Missing Authorization Header for Storage Upload");
      }

      // Re-create storage client to force headers
      // Re-create storage client to force headers
      // TODO: Move Supabase URL to a shared config to avoid duplication
      const supabaseUrl = 'https://hhlojydanygoaxwawtpb.supabase.co';
      final storageClient = SupabaseStorageClient(
        '$supabaseUrl/storage/v1',
        {
          ..._supabase.headers,
        },
      );

      final fileExt = imageFile.path.split('.').last;
      final fileName =
          '$userId-${DateTime.now().millisecondsSinceEpoch}.$fileExt';
      final filePath = '$userId/$fileName';

      await storageClient.from('avatars').upload(
            filePath,
            imageFile,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      final imageUrl = storageClient.from('avatars').getPublicUrl(filePath);
      return imageUrl;
    } catch (e) {
      debugPrint('Error uploading avatar: $e');
      rethrow;
    }
  }

  /// Updates specific fields in the user's profile using the Edge Function.
  /// This ensures validation and security are handled server-side.
  Future<void> updateProfile({
    required String userId,
    String? fullName,
    String? bio,
    String? avatarUrl,
  }) async {
    try {
      final updates = <String, dynamic>{};
      if (fullName != null) updates['full_name'] = fullName;
      if (bio != null) updates['bio'] = bio;
      if (avatarUrl != null) updates['avatar_url'] = avatarUrl;

      if (updates.isEmpty) return; // Nothing to update

      // Invoke the 'update-profile' Edge Function
      // FIX: Explicitly pass the Authorization header.
      // The SDK might default to Anon Key if it thinks session is missing.
      final authHeader = _supabase.headers['Authorization'];
      if (authHeader == null) {
        throw Exception("Missing Authorization Header for Profile Update");
      }

      final response = await _supabase.functions.invoke(
        'update-profile',
        body: updates,
        headers: {
          'Authorization': authHeader,
        },
      );

      if (response.status != 200) {
        throw Exception('Update failed: ${response.data}');
      }

      debugPrint('Profile updated successfully via Edge Function');
    } catch (e) {
      debugPrint('Error updating profile: $e');
      rethrow;
    }
  }
}
