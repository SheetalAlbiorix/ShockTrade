import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            // Logo with Glow Effect
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryBlue.withOpacity(0.2),
                    blurRadius: 60,
                    spreadRadius: 20,
                  ),
                ],
              ),
              child: Image.asset(
                'assets/icon/app_icon.png',
                width: 120,
                height: 120,
              ),
            ),
            const SizedBox(height: 32),
            // App Name
            const Text(
              'ShockTrade',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            // Tagline
            const Text(
              'The Pulse of Indian Markets',
              style: TextStyle(
                color: AppColors.neutralGray,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            // Initialization Text
            const Text(
              'INITIALIZING',
              style: TextStyle(
                color: AppColors.neutralGray,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            // Progress Bar with Animation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: const Duration(seconds: 2),
                  builder: (context, value, child) {
                    return LinearProgressIndicator(
                      value: value,
                      backgroundColor: Colors.white.withOpacity(0.1),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.primaryBlue,
                      ),
                      minHeight: 4,
                    );
                  },
                  onEnd: () {
                    context.goNamed('onboarding');
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Footer Info
            const Text(
              'Secure • Reliable • Fast',
              style: TextStyle(
                color: AppColors.neutralGray,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
            // Version
            Text(
              'v1.0.0',
              style: TextStyle(
                color: AppColors.neutralGray.withOpacity(0.5),
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
