import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/core/config/app_strings.dart';
import 'package:shock_app/core/config/theme_provider.dart';

/// Home page - main dashboard with market overview
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkSurface,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.navActiveColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.bolt,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        title: const Text(
          AppStrings.appName,
          style: TextStyle(
            color: AppColors.darkTextPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.darkTextPrimary),
            onPressed: () {
              // TODO: Navigate to search
            },
          ),
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
              color: AppColors.darkTextPrimary,
            ),
            onPressed: () {
              ref.read(themeModeProvider.notifier).toggleTheme();
            },
            tooltip: themeMode == ThemeMode.light
                ? AppStrings.darkMode
                : AppStrings.lightMode,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Market Index Cards
            Row(
              children: [
                Expanded(
                  child: _buildIndexCard(
                    context,
                    name: 'Sensex',
                    value: '73,858.92',
                    change: '+125.33 (+0.17%)',
                    isPositive: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildIndexCard(
                    context,
                    name: 'Nifty 50',
                    value: '22,462.00',
                    change: '-30.95 (-0.14%)',
                    isPositive: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Top Gainers Section
            _buildSectionHeader(context, AppStrings.topGainers),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildStockCard(
                    context,
                    symbol: 'RELIANCE',
                    name: 'Reliance Ind.',
                    price: '₹2,950.00',
                    change: '+45.70 (+1.57%)',
                    isPositive: true,
                  ),
                  _buildStockCard(
                    context,
                    symbol: 'TCS',
                    name: 'Tata Consult.',
                    price: '₹4,120.50',
                    change: '+38.10 (+0.93%)',
                    isPositive: true,
                  ),
                  _buildStockCard(
                    context,
                    symbol: 'HDFC',
                    name: 'HDFC Bank',
                    price: '₹1,580.25',
                    change: '+22.50 (+1.44%)',
                    isPositive: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Top Losers Section
            _buildSectionHeader(context, AppStrings.topLosers),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildStockCard(
                    context,
                    symbol: 'WIPRO',
                    name: 'Wipro Ltd.',
                    price: '₹490.50',
                    change: '-7.80 (-1.57%)',
                    isPositive: false,
                  ),
                  _buildStockCard(
                    context,
                    symbol: 'BHARTIARTL',
                    name: 'Bharti Airtel',
                    price: '₹1,250.70',
                    change: '-10.00 (-0.79%)',
                    isPositive: false,
                  ),
                  _buildStockCard(
                    context,
                    symbol: 'TECHM',
                    name: 'Tech Mahindra',
                    price: '₹1,320.00',
                    change: '-15.50 (-1.16%)',
                    isPositive: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndexCard(
    BuildContext context, {
    required String name,
    required String value,
    required String change,
    required bool isPositive,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPositive
              ? AppColors.bullishGreen.withOpacity(0.3)
              : AppColors.bearishRed.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.darkTextSecondary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.darkTextPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(
                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                color: isPositive
                    ? AppColors.bullishGreen
                    : AppColors.bearishRed,
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(
                change,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isPositive
                          ? AppColors.bullishGreen
                          : AppColors.bearishRed,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.darkTextPrimary,
            fontWeight: FontWeight.w600,
          ),
    );
  }

  Widget _buildStockCard(
    BuildContext context, {
    required String symbol,
    required String name,
    required String price,
    required String change,
    required bool isPositive,
  }) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.darkCardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPositive
              ? AppColors.bullishGreen.withOpacity(0.3)
              : AppColors.bearishRed.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                symbol,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.darkTextPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                name,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.darkTextSecondary,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                price,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.darkTextPrimary,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Icon(
                    isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                    color: isPositive
                        ? AppColors.bullishGreen
                        : AppColors.bearishRed,
                    size: 12,
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: Text(
                      change,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: isPositive
                                ? AppColors.bullishGreen
                                : AppColors.bearishRed,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
