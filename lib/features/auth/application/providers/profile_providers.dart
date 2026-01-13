import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/di/di.dart';
import 'package:shock_app/features/auth/application/providers/auth_providers.dart';
import 'package:shock_app/features/auth/domain/entities/profile.dart';
import 'package:shock_app/features/auth/domain/repositories/profile_repository.dart';

/// Provider for ProfileRepository
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return getIt<ProfileRepository>();
});

/// Provider for user profile based on current auth state
final userProfileProvider = FutureProvider<Profile?>((ref) async {
  final authState = ref.watch(authControllerProvider);
  
  return authState.maybeWhen(
    authenticated: (user) async {
      print('DEBUG: userProfileProvider - Authenticated User ID: ${user.id}');
      final repository = ref.read(profileRepositoryProvider);
      
      try {
        final profile = await repository.getProfile(user.id);
        print('DEBUG: userProfileProvider - Fetched Profile: ${profile?.fullName}, Avatar: ${profile?.avatarUrl}');
        return profile;
      } catch (e) {
        print('DEBUG: userProfileProvider - Error fetching profile: $e');
        return null;
      }
    },
    orElse: () {
      print('DEBUG: userProfileProvider - Auth state is not authenticated: $authState');
      return null;
    },
  );
});
