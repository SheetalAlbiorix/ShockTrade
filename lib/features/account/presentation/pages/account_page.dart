import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.premiumBackgroundDark,
      body: Center(
        child: Text(
          'Account',
          style: TextStyle(color: AppColors.darkTextPrimary, fontSize: 24),
        ),
      ),
    );
  }
}
