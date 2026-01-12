import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/portfolio/application/providers/portfolio_provider.dart';
import 'package:shock_app/features/portfolio/presentation/widgets/portfolio_summary_widgets.dart';
import 'package:shock_app/features/portfolio/presentation/widgets/holding_widgets.dart';
import 'package:shock_app/features/portfolio/presentation/widgets/empty_portfolio_view.dart';
import 'package:intl/intl.dart';

class PortfolioPage extends ConsumerWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(portfolioSummaryProvider);
    final allHoldings = ref.watch(holdingsProvider);
    final bestPerformer = ref.watch(bestPerformerProvider);
    final selectedTab = ref.watch(selectedHoldingsTabProvider);
    final sortBy = ref.watch(portfolioSortProvider);

    // Filter holdings based on selected tab
    var filteredHoldings = allHoldings.where((h) {
      if (selectedTab == 'Profit') return h.pnlAmount > 0;
      if (selectedTab == 'Loss') return h.pnlAmount < 0;
      return true;
    }).toList();

    // Sort holdings
    filteredHoldings.sort((a, b) {
      switch (sortBy) {
        case PortfolioSortOption.value:
          return b.currentValue.compareTo(a.currentValue);
        case PortfolioSortOption.pnl:
          return b.pnlAmount.compareTo(a.pnlAmount);
        case PortfolioSortOption.name:
          return a.name.compareTo(b.name);
        case PortfolioSortOption.quantity:
          return b.quantity.compareTo(a.quantity);
      }
    });

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
      ),
      body: allHoldings.isEmpty
          ? EmptyPortfolioView(onAddPressed: () => context.push('/portfolio-add-holding'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PortfolioSummaryHeader(summary: summary),
                  const SizedBox(height: 24),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  ),
                  const SizedBox(height: 32),
                  if (bestPerformer != null) ...[
                    HighlightCard(holding: bestPerformer),
                    const SizedBox(height: 32),
                  ],
                  _buildHoldingsHeader(allHoldings.length, ref, selectedTab, sortBy),
                  const SizedBox(height: 16),
                  ...filteredHoldings.map((h) => PortfolioHoldingCard(
                        holding: h,
                        onTap: () => context.push('/stock-detail?symbol=${h.symbol}&name=${Uri.encodeComponent(h.name)}'),
                        onEditTap: () => context.push('/portfolio-edit-holding/${h.id}'),
                      )),
                  const SizedBox(height: 80), // Space for FAB
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/portfolio-add-holding'),
        backgroundColor: AppColors.accentGreen,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
    );
  }

  void _showSortMenu(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final currentSort = ref.watch(portfolioSortProvider);
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Sort Holdings By',
                  style: TextStyle(color: AppColors.darkTextPrimary, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              _buildSortItem(context, ref, 'Value', PortfolioSortOption.value, currentSort),
              _buildSortItem(context, ref, 'P&L Amount', PortfolioSortOption.pnl, currentSort),
              _buildSortItem(context, ref, 'Name', PortfolioSortOption.name, currentSort),
              _buildSortItem(context, ref, 'Quantity', PortfolioSortOption.quantity, currentSort),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSortItem(BuildContext context, WidgetRef ref, String label, PortfolioSortOption option, PortfolioSortOption current) {
    final isSelected = current == option;
    return ListTile(
      title: Text(label, style: TextStyle(color: isSelected ? AppColors.navActiveColor : AppColors.darkTextPrimary)),
      trailing: isSelected ? const Icon(Icons.check, color: AppColors.navActiveColor) : null,
      onTap: () {
        ref.read(portfolioSortProvider.notifier).state = option;
        Navigator.pop(context);
      },
    );
  }

  Widget _buildHoldingsHeader(int count, WidgetRef ref, String selectedTab, PortfolioSortOption sortBy) {
    String sortLabel;
    switch (sortBy) {
      case PortfolioSortOption.value: sortLabel = 'Value'; break;
      case PortfolioSortOption.pnl: sortLabel = 'P&L'; break;
      case PortfolioSortOption.name: sortLabel = 'Name'; break;
      case PortfolioSortOption.quantity: sortLabel = 'Quantity'; break;
    }

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
            GestureDetector(
              onTap: () => _showSortMenu(ref.context, ref),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E243A),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.premiumCardBorder, width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Sort: ',
                      style: TextStyle(color: AppColors.darkTextSecondary, fontSize: 13),
                    ),
                    Text(
                      sortLabel,
                      style: const TextStyle(color: Color(0xFF4C8CFF), fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.keyboard_arrow_down, color: Color(0xFF4C8CFF), size: 16),
                  ],
                ),
              ),
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
                    color: isSelected ? Colors.transparent : AppColors.premiumCardBackground,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? AppColors.navActiveColor : AppColors.premiumCardBorder,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      tab,
                      style: TextStyle(
                        color: isSelected ? AppColors.darkTextPrimary : AppColors.darkTextSecondary,
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
