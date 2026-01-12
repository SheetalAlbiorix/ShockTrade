import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';

class AccountFooter extends StatelessWidget {
  const AccountFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.red.withOpacity(0.2)),
              backgroundColor: Colors.red.withOpacity(0.1),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Log Out',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'App Version v2.4.1',
          style: TextStyle(
            color: AppColors.darkTextSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '© 2024 TradeIndia Financials',
          style: TextStyle(
            color: Colors.white.withOpacity(0.3),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
