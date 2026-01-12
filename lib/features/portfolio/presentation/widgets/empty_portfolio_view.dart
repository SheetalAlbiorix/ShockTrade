import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';

class EmptyPortfolioView extends StatelessWidget {
  final VoidCallback onAddPressed;

  const EmptyPortfolioView({super.key, required this.onAddPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        // Illustration placeholder (Mocking the wallet icon from image)
        Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            color: AppColors.premiumCardBackground,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: AppColors.navActiveColor.withValues(alpha: 0.1),
                blurRadius: 40,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.navActiveColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.navActiveColor.withValues(alpha: 0.5),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(Icons.account_balance_wallet, color: Colors.white, size: 48),
              ),
              Positioned(
                top: 50,
                right: 50,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: AppColors.bullishGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.trending_up, color: Colors.white, size: 16),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        const Text(
          'Start building your portfolio',
          style: TextStyle(
            color: AppColors.darkTextPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Invest in top Indian stocks and track your wealth in real-time. Take the first step towards your financial goals.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.darkTextSecondary,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 40),
        ElevatedButton.icon(
          onPressed: onAddPressed,
          icon: const Icon(Icons.add_circle, color: Colors.white),
          label: const Text(
            'Add your first stock',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.navActiveColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            shadowColor: AppColors.navActiveColor.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(height: 24),
        TextButton(
          onPressed: () {},
          child: const Text(
            'View market trends',
            style: TextStyle(
              color: AppColors.darkTextSecondary,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
