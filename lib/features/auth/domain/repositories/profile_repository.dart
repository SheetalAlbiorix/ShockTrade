import 'package:shock_app/features/auth/domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<Profile?> getProfile(String id);
  Future<void> updateProfile(Profile profile);
}
