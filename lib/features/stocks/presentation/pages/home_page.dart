import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/stocks/presentation/widgets/greeting_header.dart';
import 'package:shock_app/features/stocks/presentation/widgets/portfolio_summary_card.dart';
import 'package:shock_app/features/stocks/presentation/widgets/market_indices_section.dart';
import 'package:shock_app/features/stocks/presentation/widgets/quick_action_shortcuts.dart';
import 'package:shock_app/features/stocks/presentation/widgets/top_movers_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.premiumBackgroundDark,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.premiumDarkGradient,
        ),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              // TODO: Implement refresh logic
              await Future.delayed(const Duration(seconds: 1));
            },
            color: AppColors.premiumAccentBlue,
            backgroundColor: AppColors.premiumCardBackground,
            child: const SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   GreetingHeader(),
                   // No vertical spacing here as Greeting header has bottom padding
                   PortfolioSummaryCard(),
                   SizedBox(height: 32),
                   QuickActionShortcuts(),
                   SizedBox(height: 32),
                   MarketIndicesSection(),
                   SizedBox(height: 32),
                   TopMoversSection(),
                   SizedBox(height: 48), // Bottom padding
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
