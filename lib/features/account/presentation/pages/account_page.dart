import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/account/presentation/widgets/account_footer.dart';
import 'package:shock_app/features/account/presentation/widgets/account_header.dart';
import 'package:shock_app/features/account/presentation/widgets/profile_section.dart';
import 'package:shock_app/features/account/presentation/widgets/settings_group.dart';
import 'package:shock_app/features/account/presentation/widgets/settings_tile.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            const AccountHeader(),
            
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  children: [
                    // Profile Section
                    const ProfileSection(),
                    const SizedBox(height: 24),
                    
                    // App Preferences Section
                    const SettingsGroup(
                      title: 'PREFERENCES',
                      children: [
                        SettingsTile(
                          icon: Icons.dark_mode_outlined,
                          title: 'Dark Mode',
                          iconColor: AppColors.primaryBlue,
                          iconBgColor: Color(0xFFE3F2FD),
                          isSwitch: true,
                          switchValue: true,
                        ),
                        SettingsTile(
                          icon: Icons.currency_rupee,
                          title: 'Currency',
                          iconColor: Color(0xFF16A34A),
                          iconBgColor: Color(0xFFDCFCE7),
                          trailingText: 'INR (₹)',
                        ),
                        SettingsTile(
                          icon: Icons.notifications_outlined,
                          title: 'Notifications',
                          iconColor: Color(0xFFEA580C),
                          iconBgColor: Color(0xFFFFEDD5),
                          trailingText: 'Push, Email',
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Security Section
                    const SettingsGroup(
                      title: 'SECURITY',
                      children: [
                        SettingsTile(
                          icon: Icons.lock_outline,
                          title: 'Change PIN',
                          iconColor: Color(0xFF9333EA),
                          iconBgColor: Color(0xFFF3E8FF),
                        ),
                        SettingsTile(
                          icon: Icons.fingerprint,
                          title: 'Biometric Login',
                          iconColor: Color(0xFFE11D48),
                          iconBgColor: Color(0xFFFFE4E6),
                          isSwitch: true,
                          switchValue: true,
                        ),
                        SettingsTile(
                          icon: Icons.shield_outlined,
                          title: 'Two-Factor Auth',
                          iconColor: Color(0xFF0D9488),
                          iconBgColor: Color(0xFFCCFBF1),
                          trailingText: 'Enabled',
                          trailingTextColor: AppColors.primaryBlue,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Support & Legal Section
                    const SettingsGroup(
                      title: 'SUPPORT & LEGAL',
                      children: [
                        SettingsTile(
                          icon: Icons.help_outline,
                          title: 'Help Center',
                          iconColor: Color(0xFF4F46E5),
                          iconBgColor: Color(0xFFE0E7FF),
                          trailingIcon: Icons.open_in_new,
                        ),
                        SettingsTile(
                          icon: Icons.description_outlined,
                          title: 'Terms & Privacy Policy',
                          iconColor: Color(0xFF475569),
                          iconBgColor: Color(0xFFF1F5F9),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Footer
                    const AccountFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
