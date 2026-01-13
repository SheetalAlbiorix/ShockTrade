import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shock_app/features/auth/domain/entities/profile.dart';
import 'package:shock_app/features/auth/domain/repositories/profile_repository.dart';

class SupabaseProfileRepository implements ProfileRepository {
  final SupabaseClient _client;

  SupabaseProfileRepository(this._client);

  @override
  Future<Profile?> getProfile(String id) async {
    try {
      final response = await _client
          .from('profiles')
          .select()
          .eq('id', id)
          .maybeSingle();
      
      if (response == null) return null;
      return Profile.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateProfile(Profile profile) async {
    final data = profile.toJson();
    data.remove('id'); // ID is primary key and should not be updated
    data.remove('updated_at'); // Handled by DB default

    await _client
        .from('profiles')
        .update(data)
        .eq('id', profile.id);
  }
}
