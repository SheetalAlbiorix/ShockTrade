import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/portfolio/application/providers/portfolio_provider.dart';
import 'package:shock_app/features/portfolio/domain/entities/portfolio_models.dart';
import 'package:shock_app/features/portfolio/presentation/widgets/portfolio_summary_widgets.dart';
import 'package:shock_app/features/portfolio/presentation/widgets/portfolio_chart_widget.dart';
import 'package:shock_app/features/portfolio/presentation/widgets/holding_widgets.dart';
import 'package:shock_app/features/portfolio/presentation/widgets/empty_portfolio_view.dart';
import 'package:intl/intl.dart';

class PortfolioPage extends ConsumerWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEmpty = ref.watch(isEmptyPortfolioProvider);
    final summary = ref.watch(portfolioSummaryProvider);
    final holdings = ref.watch(holdingsProvider);
    final bestPerformer = ref.watch(bestPerformerProvider);
    final selectedTimeRange = ref.watch(selectedTimeRangeProvider);
    final selectedAssetType = ref.watch(selectedAssetTypeProvider);
    final selectedTab = ref.watch(selectedHoldingsTabProvider);

    final currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');

    return Scaffold(
      backgroundColor: AppColors.premiumBackgroundDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.darkTextPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Portfolio',
          style: TextStyle(
            color: AppColors.darkTextPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.navActiveColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.analytics_outlined, size: 16, color: AppColors.navActiveColor),
                  label: const Text(
                    'Analyze',
                    style: TextStyle(
                      color: AppColors.navActiveColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: isEmpty
          ? EmptyPortfolioView(onAddPressed: () => context.push('/portfolio-add-holding'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PortfolioSummaryHeader(summary: summary),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: PortfolioMetricCard(
                          title: 'Invested Value',
                          value: currencyFormat.format(summary.investedValue),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: PortfolioMetricCard(
                          title: "Day's P&L",
                          value: '${summary.dayPnlAmount >= 0 ? "+" : ""}${currencyFormat.format(summary.dayPnlAmount)}',
                          subtitle: '(${summary.dayPnlPercentage.toStringAsFixed(1)}%)',
                          valueColor: summary.isDayPositive ? AppColors.bullishGreen : AppColors.bearishRed,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildFilters(ref, selectedTimeRange, selectedAssetType),
                  const SizedBox(height: 16),
                  PortfolioChartWidget(dataPoints: ref.watch(portfolioChartDataProvider)),
                  const SizedBox(height: 24),
                  if (bestPerformer != null) ...[
                    HighlightCard(holding: bestPerformer),
                    const SizedBox(height: 32),
                  ],
                  _buildHoldingsHeader(holdings.length, ref, selectedTab),
                  const SizedBox(height: 16),
                  ...holdings.map((h) => PortfolioHoldingCard(
                        holding: h,
                        onTap: () => context.push('/stock-detail?symbol=${h.symbol}&name=${h.name}'),
                      )),
                  const SizedBox(height: 80), // Space for FAB
                ],
              ),
            ),
      floatingActionButton: !isEmpty
          ? FloatingActionButton(
              onPressed: () => context.push('/portfolio-add-holding'),
              backgroundColor: AppColors.accentGreen,
              child: const Icon(Icons.add, color: Colors.white, size: 32),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            )
          : null,
    );
  }

  Widget _buildFilters(WidgetRef ref, String timeRange, String assetType) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Time range chips
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.premiumCardBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: ['1D', '1W', '1M', '1Y', 'All'].map((range) {
              final isSelected = timeRange == range;
              return GestureDetector(
                onTap: () => ref.read(selectedTimeRangeProvider.notifier).state = range,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.darkDivider : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    range,
                    style: TextStyle(
                      color: isSelected ? AppColors.darkTextPrimary : AppColors.darkTextSecondary,
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        // Asset type toggle
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.premiumCardBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: ['Equity', 'All Assets'].map((type) {
              final isSelected = assetType == type;
              return GestureDetector(
                onTap: () => ref.read(selectedAssetTypeProvider.notifier).state = type,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.navActiveColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    type,
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppColors.darkTextSecondary,
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildHoldingsHeader(int count, WidgetRef ref, String selectedTab) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Holdings ($count)',
              style: const TextStyle(
                color: AppColors.darkTextPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                const Text(
                  'Sort by: ',
                  style: TextStyle(color: AppColors.darkTextSecondary, fontSize: 13),
                ),
                Text(
                  'Value',
                  style: TextStyle(color: AppColors.navActiveColor, fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: ['All', 'Profit', 'Loss'].map((tab) {
            final isSelected = selectedTab == tab;
            return Expanded(
              child: GestureDetector(
                onTap: () => ref.read(selectedHoldingsTabProvider.notifier).state = tab,
                child: Container(
                  margin: EdgeInsets.only(
                    right: tab != 'Loss' ? 8 : 0,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.navActiveColor.withValues(alpha: 0.1) : AppColors.premiumCardBackground,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? AppColors.navActiveColor : AppColors.premiumCardBorder,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      tab,
                      style: TextStyle(
                        color: isSelected ? AppColors.navActiveColor : AppColors.darkTextSecondary,
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
