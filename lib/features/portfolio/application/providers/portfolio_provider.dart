import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/features/portfolio/domain/entities/portfolio_models.dart';

/// Provider for portfolio summary
final portfolioSummaryProvider = Provider<PortfolioSummary>((ref) {
  return const PortfolioSummary(
    totalValue: 1245000.50,
    investedValue: 1121000.00,
    dayPnlAmount: 12450.00,
    dayPnlPercentage: 1.2,
    totalPnlAmount: 124000.00,
    totalPnlPercentage: 11.5,
  );
});

/// Provider for holdings list
final holdingsProvider = Provider<List<Holding>>((ref) {
  return [
    Holding.mock(
      symbol: 'HDFCBANK',
      name: 'HDFC Bank',
      logoUrl: 'https://logo.clearbit.com/hdfcbank.com',
      quantity: 50,
      avgPrice: 1500,
      currentPrice: 1650,
    ),
    Holding.mock(
      symbol: 'TATAMOTORS',
      name: 'Tata Motors',
      logoUrl: 'https://logo.clearbit.com/tatamotors.com',
      quantity: 100,
      avgPrice: 950,
      currentPrice: 937.5,
    ),
    Holding.mock(
      symbol: 'RELIANCE',
      name: 'Reliance Ind.',
      logoUrl: 'https://logo.clearbit.com/reliance.com',
      quantity: 45,
      avgPrice: 2400,
      currentPrice: 2742.22, // Adjusted to get ~1.21L value
    ),
  ];
});

/// Provider for chart data
final portfolioChartDataProvider = Provider<List<ChartDataPoint>>((ref) {
  return const [
    ChartDataPoint(0, 10),
    ChartDataPoint(1, 12),
    ChartDataPoint(2, 11),
    ChartDataPoint(3, 15),
    ChartDataPoint(4, 18),
    ChartDataPoint(5, 17),
    ChartDataPoint(6, 22),
    ChartDataPoint(7, 25),
  ];
});

/// Provider for best performer
final bestPerformerProvider = Provider<Holding?>((ref) {
  final holdings = ref.watch(holdingsProvider);
  if (holdings.isEmpty) return null;
  return holdings.reduce((curr, next) => curr.pnlPercentage > next.pnlPercentage ? curr : next);
});

/// Provider for empty state (for testing toggle)
final isEmptyPortfolioProvider = StateProvider<bool>((ref) => false);

/// Provider for time range filter
final selectedTimeRangeProvider = StateProvider<String>((ref) => '1M');

/// Provider for asset toggle
final selectedAssetTypeProvider = StateProvider<String>((ref) => 'Equity');

/// Provider for holdings filter tab
final selectedHoldingsTabProvider = StateProvider<String>((ref) => 'All');
