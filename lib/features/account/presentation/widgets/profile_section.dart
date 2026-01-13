import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/features/auth/application/providers/auth_providers.dart';
import 'package:shock_app/features/auth/application/providers/profile_providers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileSection extends ConsumerStatefulWidget {
  const ProfileSection({super.key});

  @override
  ConsumerState<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends ConsumerState<ProfileSection> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final profileAsync = ref.watch(userProfileProvider);

    final String displayName = profileAsync.maybeWhen(
      data: (profile) => profile?.fullName ?? authState.maybeWhen(
        authenticated: (user) => user.name,
        orElse: () => 'Trader',
      ),
      orElse: () => authState.maybeWhen(
        authenticated: (user) => user.name,
        orElse: () => 'Trader',
      ),
    );

    final String email = profileAsync.maybeWhen(
      data: (profile) => profile?.email ?? authState.maybeWhen(
        authenticated: (user) => user.email,
        orElse: () => '',
      ),
      orElse: () => authState.maybeWhen(
        authenticated: (user) => user.email,
        orElse: () => '',
      ),
    );

    final String? avatarUrl = profileAsync.maybeWhen(
      data: (profile) => profile?.avatarUrl ?? authState.maybeWhen(
        authenticated: (user) => user.avatarUrl,
        orElse: () => null,
      ),
      orElse: () => authState.maybeWhen(
        authenticated: (user) => user.avatarUrl,
        orElse: () => null,
      ),
    );
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
                      avatarUrl ??
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
                        displayName,
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
                  email,
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
              // provider is automatically invalidated in EditProfilePage
            },
          ),
        ],
      ),
    );
  }
}
