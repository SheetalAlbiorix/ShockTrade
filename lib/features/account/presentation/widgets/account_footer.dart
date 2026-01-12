import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/core/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountFooter extends StatelessWidget {
  const AccountFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => _showLogoutDialog(context),
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

  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        title: const Text(
          'Log Out',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to log out?',
          style: TextStyle(color: AppColors.neutralGray),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white)),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context); // Close Confirmation
              _handleLogoutWithLoader(context);
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleLogoutWithLoader(BuildContext context) async {
    // Show Loading Dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: AppColors.primaryBlue),
      ),
    );

    try {
      final authService = AuthService(Supabase.instance.client);
      await authService.signOut();

      if (context.mounted) {
        Navigator.pop(context); // Close Loader
        context.go('/login');
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context); // Close Loader
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logout failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
