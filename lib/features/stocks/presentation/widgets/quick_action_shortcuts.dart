import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';

class QuickActionShortcuts extends StatelessWidget {
  const QuickActionShortcuts({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildShortcut(context, 'Portfolio', Icons.pie_chart_outline, Colors.blue),
          _buildShortcut(context, 'Watchlist', Icons.remove_red_eye_outlined, Colors.purple, onTap: () {
            context.push('/market-news');
          }),
          _buildShortcut(context, 'Alerts', Icons.notifications_active_outlined, Colors.orange),
          _buildShortcut(context, 'IPOs', Icons.rocket_launch_outlined, Colors.green),
        ],
      ),
    );
  }

  Widget _buildShortcut(BuildContext context, String label, IconData icon, Color color, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.premiumSurface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.premiumCardBorder),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: color,
              size: 26,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.darkTextSecondary,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
