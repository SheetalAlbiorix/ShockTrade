import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/features/portfolio/domain/entities/portfolio_models.dart';
import 'dart:async';
import 'dart:math';

/// Provider for portfolio summary (derived from holdings)
final portfolioSummaryProvider = Provider<PortfolioSummary>((ref) {
  final holdings = ref.watch(holdingsProvider);
  
  if (holdings.isEmpty) {
    return const PortfolioSummary(
      totalValue: 0,
      investedValue: 0,
      dayPnlAmount: 0,
      dayPnlPercentage: 0,
      totalPnlAmount: 0,
      totalPnlPercentage: 0,
    );
  }

  double totalValue = 0;
  double investedValue = 0;
  double totalPnl = 0;
  
  for (var h in holdings) {
    totalValue += h.currentValue;
    investedValue += h.investedValue;
    totalPnl += h.pnlAmount;
  }

  final totalPnlPercent = investedValue != 0 ? (totalPnl / investedValue) * 100 : 0.0;
  
  // Dynamic day P&L: simulated as a small portion of total value for mock feel
  // In a real app, this would be sum(holding.currentPrice - holding.previousClose) * quantity
  final dayPnl = totalValue * 0.041; // Simulating 4.1% day gain as seen in screenshots
  final dayPnlPercent = totalValue != 0 ? (dayPnl / totalValue) * 100 : 0.0;

  return PortfolioSummary(
    totalValue: totalValue,
    investedValue: investedValue,
    dayPnlAmount: dayPnl,
    dayPnlPercentage: dayPnlPercent,
    totalPnlAmount: totalPnl,
    totalPnlPercentage: totalPnlPercent,
  );
});

/// Notifier for managing holdings
class HoldingsNotifier extends StateNotifier<List<Holding>> {
  Timer? _timer;
  final _random = Random();

  HoldingsNotifier() : super(_initialHoldings) {
    _startPriceSimulation();
  }

  void _startPriceSimulation() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (state.isEmpty) return;
      
      state = [
        for (final h in state)
          h.copyWith(
            currentPrice: h.currentPrice * (1 + (_random.nextDouble() * 0.002 - 0.001)), // +/- 0.1% fluctuation
          )
      ];
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  static final List<Holding> _initialHoldings = [
    Holding.mock(
      id: '1',
      symbol: 'HDFCBANK',
      name: 'HDFC Bank',
      logoUrl: 'https://logo.clearbit.com/hdfcbank.com',
      quantity: 50,
      avgPrice: 1500,
      currentPrice: 1650,
      purchaseDate: DateTime.now().subtract(const Duration(days: 30)),
    ),
    Holding.mock(
      id: '2',
      symbol: 'TATAMOTORS',
      name: 'Tata Motors',
      logoUrl: 'https://logo.clearbit.com/tatamotors.com',
      quantity: 100,
      avgPrice: 950,
      currentPrice: 937.5,
      purchaseDate: DateTime.now().subtract(const Duration(days: 15)),
    ),
    Holding.mock(
      id: '3',
      symbol: 'RELIANCE',
      name: 'Reliance Ind.',
      logoUrl: 'https://logo.clearbit.com/reliance.com',
      quantity: 45,
      avgPrice: 2400,
      currentPrice: 2742.22,
      purchaseDate: DateTime.now().subtract(const Duration(days: 60)),
    ),
  ];

  void addHolding(Holding holding) {
    state = [...state, holding];
  }

  void updateHolding(String id, double quantity, double avgPrice, DateTime purchaseDate) {
    state = [
      for (final h in state)
        if (h.id == id)
          h.copyWith(quantity: quantity, avgPrice: avgPrice, purchaseDate: purchaseDate)
        else
          h,
    ];
  }

  void deleteHolding(String id) {
    state = state.where((h) => h.id != id).toList();
  }
}

final holdingsProvider = StateNotifierProvider<HoldingsNotifier, List<Holding>>((ref) {
  return HoldingsNotifier();
});

/// Provider for chart data (now includes mock points)
final portfolioChartDataProvider = Provider<List<ChartDataPoint>>((ref) {
  return const [
    ChartDataPoint(0, 10),
    ChartDataPoint(1, 14),
    ChartDataPoint(2, 12),
    ChartDataPoint(3, 18),
    ChartDataPoint(4, 16),
    ChartDataPoint(5, 22),
    ChartDataPoint(6, 26),
    ChartDataPoint(7, 24),
    ChartDataPoint(8, 30),
    ChartDataPoint(9, 32),
  ];
});

/// Provider for best performer
final bestPerformerProvider = Provider<Holding?>((ref) {
  final holdings = ref.watch(holdingsProvider);
  if (holdings.isEmpty) return null;
  return holdings.reduce((curr, next) => curr.pnlPercentage > next.pnlPercentage ? curr : next);
});

/// Search logic for stocks
class StockSuggestion {
  final String symbol;
  final String name;
  final String logoUrl;
  final double currentPrice;

  StockSuggestion(this.symbol, this.name, this.logoUrl, this.currentPrice);
}

final stockSearchQueryProvider = StateProvider<String>((ref) => '');

final stockSearchProvider = Provider<List<StockSuggestion>>((ref) {
  final query = ref.watch(stockSearchQueryProvider).toUpperCase();
  if (query.isEmpty) return [];

  final allStocks = [
    StockSuggestion('HDFCBANK', 'HDFC Bank Ltd', 'https://logo.clearbit.com/hdfcbank.com', 1650.45),
    StockSuggestion('RELIANCE', 'Reliance Industries', 'https://logo.clearbit.com/reliance.com', 2742.22),
    StockSuggestion('TATAMOTORS', 'Tata Motors Ltd', 'https://logo.clearbit.com/tatamotors.com', 937.50),
    StockSuggestion('INFY', 'Infosys Ltd', 'https://logo.clearbit.com/infosys.com', 1540.20),
    StockSuggestion('TCS', 'Tata Consultancy Services', 'https://logo.clearbit.com/tcs.com', 3850.15),
    StockSuggestion('ICICIBANK', 'ICICI Bank Ltd', 'https://logo.clearbit.com/icicibank.com', 1080.40),
    StockSuggestion('SBI', 'State Bank of India', 'https://logo.clearbit.com/sbi.co.in', 760.30),
    StockSuggestion('WIPRO', 'Wipro Ltd', 'https://logo.clearbit.com/wipro.com', 480.10),
    StockSuggestion('ADANIENT', 'Adani Enterprises Ltd', 'https://logo.clearbit.com/adani.com', 3200.75),
    StockSuggestion('ZOMATO', 'Zomato Ltd', 'https://logo.clearbit.com/zomato.com', 185.20),
  ];

  return allStocks.where((s) => s.symbol.contains(query) || s.name.toUpperCase().contains(query)).toList();
});

/// UI States
final isEmptyPortfolioProvider = StateProvider<bool>((ref) => false);
final selectedTimeRangeProvider = StateProvider<String>((ref) => '1Y');
final selectedAssetTypeProvider = StateProvider<String>((ref) => 'Equity');
final selectedHoldingsTabProvider = StateProvider<String>((ref) => 'All');

/// Sorting options for holdings
enum PortfolioSortOption { value, pnl, name, quantity }

final portfolioSortProvider = StateProvider<PortfolioSortOption>((ref) => PortfolioSortOption.value);
