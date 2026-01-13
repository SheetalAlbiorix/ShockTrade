import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/auth/application/providers/auth_providers.dart';
import 'package:shock_app/features/auth/application/providers/profile_providers.dart';

class GreetingHeader extends ConsumerWidget {
  const GreetingHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final profileAsync = ref.watch(userProfileProvider);

    final String userName = profileAsync.maybeWhen(
      data: (profile) {
        final name = profile?.fullName ?? authState.maybeWhen(
          authenticated: (user) => user.name,
          orElse: () => 'Guest',
        );
        final finalName = name ?? 'Guest';
        print('DEBUG: GreetingHeader - Final userName: $finalName (from profile: ${profile?.fullName})');
        return finalName;
      },
      orElse: () {
        final name = authState.maybeWhen(
          authenticated: (user) => user.name,
          orElse: () => 'Guest',
        );
        final finalName = name ?? 'Guest';
        print('DEBUG: GreetingHeader - Falling back to auth userName: $finalName');
        return finalName;
      },
    );

    final String? avatarUrl = profileAsync.maybeWhen(
      data: (profile) {
        final url = profile?.avatarUrl ?? authState.maybeWhen(
          authenticated: (user) => user.avatarUrl,
          orElse: () => null,
        );
        print('DEBUG: GreetingHeader - Final avatarUrl: $url (from profile: ${profile?.avatarUrl})');
        return url;
      },
      orElse: () {
        final url = authState.maybeWhen(
          authenticated: (user) => user.avatarUrl,
          orElse: () => null,
        );
        print('DEBUG: GreetingHeader - Falling back to auth avatarUrl: $url');
        return url;
      },
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.premiumAccentBlue, width: 2),
              image: DecorationImage(
                image: NetworkImage(
                    avatarUrl ?? 'https://i.pravatar.cc/150?img=11'), // Use dynamic avatar or placeholder
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.premiumAccentBlue.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Greeting & Name
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back,',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.darkTextSecondary,
                      ),
                ),
                Text(
                  userName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.darkTextPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),

          // Actions
          _buildActionButton(
            Icons.candlestick_chart,
            () => context.push('/professional-chart'),
          ),
          const SizedBox(width: 12),
          _buildActionButton(Icons.search, () => context.push('/search')),
          const SizedBox(width: 12),
          Stack(
            children: [
              _buildActionButton(Icons.notifications_none_rounded, () {}),
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.premiumAccentRed,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.premiumCardBackground,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.premiumCardBorder),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, color: AppColors.darkTextPrimary, size: 20),
        onPressed: onPressed,
      ),
    );
  }
}
