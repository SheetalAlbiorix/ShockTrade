import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shock_app/core/services/profile_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  String _displayName = 'Loading...';
  String _email = '';
  String? _avatarUrl;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // 1. Set initial data from Firebase Cache (Fast)
      if (mounted) {
        setState(() {
          _displayName = user.displayName ?? 'Trader';
          _email = user.email ?? '';
          _avatarUrl = user.photoURL;
        });
      }

      // 2. Fetch latest from Supabase (DB Source of Truth)
      try {
        final profileService = ProfileService(Supabase.instance.client);
        final profile = await profileService.getProfile(user.uid);
        if (profile != null && mounted) {
          setState(() {
            _displayName = profile['full_name'] ?? _displayName;
            _email = profile['email'] ?? _email;
            _avatarUrl = profile['avatar_url'] ?? _avatarUrl;
          });
        }
      } catch (e) {
        debugPrint('Error fetching profile in section: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface, // Using darkSurface as per AppColors
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          // Avatar
          Stack(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.white.withOpacity(0.1), width: 2),
                  image: DecorationImage(
                    image: NetworkImage(
                      _avatarUrl ??
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuDBBAnWS59jUq6K0aHWcx6o0E9fBtWrJgKcH8ev2pUQiZtldm9WqFkLKIDcmfrIXnsnGtS1hnA2MGDa5nEPM-lBVoV5qIBsveCNT-caZSc3e5vHNPXOJESP6Osj6GkObFY405_7Uevh00kAlREqoTqYNS_IOQF0wO_0spho5Nkgpp2wgm4SAyuASIU4xhfJd3vwI4QIkZj0oqABUPTu-vhSY9yYH59L6hIAMoxvYWWs-fttdcpK-Jiv_2HmyrneVemzbG2XJsSjQlA',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: AppColors.darkSurface,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.verified,
                    color: AppColors.primaryBlue,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        _displayName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                            color: AppColors.primaryBlue.withOpacity(0.2)),
                      ),
                      child: const Text(
                        'KYC Verified',
                        style: TextStyle(
                          color: AppColors.primaryBlue,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  _email,
                  style: const TextStyle(
                    color: AppColors.darkTextSecondary,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Edit Button
          IconButton(
            icon: const Icon(Icons.edit_square,
                color: AppColors.darkTextSecondary),
            onPressed: () async {
              await context.push('/edit-profile');
              // Refresh when coming back
              _loadProfile();
            },
          ),
        ],
      ),
    );
  }
}
