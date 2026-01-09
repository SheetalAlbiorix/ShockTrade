import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/core/config/app_strings.dart';

class WatchlistHeader extends StatelessWidget {
  final VoidCallback? onEditTap;

  const WatchlistHeader({
    super.key,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.premiumBackgroundDark,
      surfaceTintColor: Colors.transparent, // Disable material 3 tint
      pinned: false,
      floating: true,
      snap: false,
      elevation: 0,
      centerTitle: false,
      titleSpacing: 16,
      automaticallyImplyLeading: false,
      title: const Text(
        AppStrings.watchlist,
        style: TextStyle(
          color: AppColors.darkTextPrimary,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            HapticFeedback.lightImpact();
            onEditTap?.call();
          },
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.premiumSurface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.edit_outlined,
              color: AppColors.darkTextPrimary,
              size: 20,
            ),
          ),
          tooltip: 'Edit Watchlist',
        ),
        const SizedBox(width: 8),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: AppColors.darkDivider.withOpacity(0.3),
        ),
      ),
    );
  }
}
