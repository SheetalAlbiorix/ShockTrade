import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/core/config/app_strings.dart';
import 'package:shock_app/features/portfolio/application/providers/portfolio_provider.dart';
import 'package:shock_app/features/portfolio/domain/entities/portfolio_models.dart';
import 'package:shock_app/features/portfolio/presentation/widgets/donut_chart_widget.dart';
import 'package:shock_app/features/portfolio/presentation/widgets/holding_row_widget.dart';

/// Portfolio page - displays user's stock holdings and overall portfolio value
class PortfolioPage extends ConsumerWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(portfolioSummaryProvider);
    final assets = ref.watch(assetDistributionProvider);
    final holdings = ref.watch(holdingsProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkSurface,
        elevation: 0,
        title: const Text(
          AppStrings.portfolio,
          style: TextStyle(
            color: AppColors.darkTextPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              _showOptionsMenu(context);
            },
            icon: const Icon(
              Icons.menu,
              color: AppColors.darkTextPrimary,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: AppColors.darkDivider,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(portfolioLoadingProvider.notifier).state = true;
          await Future.delayed(const Duration(seconds: 1));
          ref.read(portfolioLoadingProvider.notifier).state = false;
        },
        color: AppColors.navActiveColor,
        backgroundColor: AppColors.darkCardBackground,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Portfolio Summary Card
              _buildSummaryCard(context, summary),
              const SizedBox(height: 16),
              // Investment Metrics Row
              _buildMetricsRow(context, summary),
              const SizedBox(height: 16),
              // Asset Distribution Chart
              DonutChartWidget(categories: assets),
              const SizedBox(height: 24),
              // Holdings Section
              _buildHoldingsSection(context, holdings),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, PortfolioSummary summary) {
    return Semantics(
      label: 'Total portfolio value ${summary.formattedTotalValue}, '
          '${summary.isPositive ? "up" : "down"} ${summary.formattedDailyChange} today',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.darkCardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.darkDivider, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Total Portfolio Value',
              style: TextStyle(
                color: AppColors.darkTextSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              summary.formattedTotalValue,
              style: const TextStyle(
                color: AppColors.darkTextPrimary,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 12),
            // Daily change indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: (summary.isPositive
                        ? AppColors.bullishGreen
                        : AppColors.bearishRed)
                    .withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    summary.isPositive
                        ? Icons.arrow_circle_up
                        : Icons.arrow_circle_down,
                    color: summary.isPositive
                        ? AppColors.bullishGreen
                        : AppColors.bearishRed,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    summary.formattedDailyChange,
                    style: TextStyle(
                      color: summary.isPositive
                          ? AppColors.bullishGreen
                          : AppColors.bearishRed,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    '(Today)',
                    style: TextStyle(
                      color: AppColors.darkTextSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsRow(BuildContext context, PortfolioSummary summary) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.darkCardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkDivider, width: 0.5),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildMetricItem(
              context,
              label: 'Invested',
              value: summary.formattedInvested,
              color: AppColors.darkTextPrimary,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: AppColors.darkDivider,
          ),
          Expanded(
            child: _buildMetricItem(
              context,
              label: 'Current',
              value: summary.formattedCurrent,
              color: AppColors.darkTextPrimary,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: AppColors.darkDivider,
          ),
          Expanded(
            child: _buildMetricItem(
              context,
              label: 'Gain',
              value: summary.formattedGain,
              color: summary.isPositive
                  ? AppColors.bullishGreen
                  : AppColors.bearishRed,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(
    BuildContext context, {
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.darkTextSecondary,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildHoldingsSection(BuildContext context, List holdings) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkCardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkDivider, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Your Holdings',
              style: TextStyle(
                color: AppColors.darkTextPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ...holdings.map((holding) => HoldingRowWidget(
                holding: holding,
                onTap: () => _showHoldingDetails(context, holding),
              )),
        ],
      ),
    );
  }

  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.add, color: AppColors.navActiveColor),
                  title: const Text(
                    'Add Holding',
                    style: TextStyle(color: AppColors.darkTextPrimary),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(Icons.download, color: AppColors.navActiveColor),
                  title: const Text(
                    'Export Portfolio',
                    style: TextStyle(color: AppColors.darkTextPrimary),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(Icons.settings, color: AppColors.navActiveColor),
                  title: const Text(
                    'Portfolio Settings',
                    style: TextStyle(color: AppColors.darkTextPrimary),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showHoldingDetails(BuildContext context, dynamic holding) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${holding.symbol} details - Coming soon!'),
        backgroundColor: AppColors.darkSurface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
