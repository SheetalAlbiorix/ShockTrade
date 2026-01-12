import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.darkTextPrimary,
            ),
          ),
          Expanded(
            child: Text(
              'ShockTrade',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.darkTextPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
          // Balance out the back button for perfect centering
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}
