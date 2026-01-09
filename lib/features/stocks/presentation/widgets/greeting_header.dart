import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({super.key});

  @override
  Widget build(BuildContext context) {
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
              image: const DecorationImage(
                image: NetworkImage('https://i.pravatar.cc/150?img=11'), // Placeholder avatar
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
                  'Arjun Mehta',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.darkTextPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          
          // Actions
          _buildActionButton(Icons.search, () {}),
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
