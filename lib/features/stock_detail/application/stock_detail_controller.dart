import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/features/stock_detail/domain/models.dart';

/// Controller for stock detail screen
class StockDetailController extends StateNotifier<StockDetailState> {
  StockDetailController(String symbol, String name)
      : super(StockDetailState.initial()) {
    _loadStockData(symbol, name);
  }

  void _loadStockData(String symbol, String name) {
    // Generate mock data based on the symbol
    final random = Random(symbol.hashCode);
    final basePrice =
        100 + random.nextDouble() * 500; // Random price between 100-600
    final priceChange =
        (random.nextDouble() - 0.5) * 10; // Random change between -5 to +5
    final percentChange = (priceChange / basePrice) * 100;

    state = state.copyWith(
      symbol: symbol,
      price: basePrice,
      priceChange: priceChange,
      percentChange: percentChange,
    );

    // Generate initial chart data
    final chartPoints = _generateMockChartData(StockRange.oneDay);
    state = state.copyWith(chartPoints: chartPoints);
  }

  /// Toggle watchlist status
  void toggleWatchlist() {
    state = state.copyWith(isInWatchlist: !state.isInWatchlist);
  }

  /// Toggle alert status
  void toggleAlert() {
    state = state.copyWith(hasAlert: !state.hasAlert);
  }

  /// Change time range and regenerate chart data
  void changeRange(StockRange range) {
    final chartPoints = _generateMockChartData(range);
    state = state.copyWith(
      range: range,
      chartPoints: chartPoints,
    );
  }

  /// Generate mock chart data based on range
  List<ChartPoint> _generateMockChartData(StockRange range) {
    final random = Random(state.symbol.hashCode + range.index);
    final now = DateTime.now();
    final basePrice = state.price;

    int dataPoints;
    Duration interval;

    switch (range) {
      case StockRange.oneDay:
        dataPoints = 78; // Trading hours: 6.5 hours * 12 points/hour
        interval = const Duration(minutes: 5);
        break;
      case StockRange.fiveDays:
        dataPoints = 65; // 5 days * 13 points/day
        interval = const Duration(minutes: 30);
        break;
      case StockRange.oneMonth:
        dataPoints = 30;
        interval = const Duration(days: 1);
        break;
      case StockRange.sixMonths:
        dataPoints = 26; // ~26 weeks
        interval = const Duration(days: 7);
        break;
      case StockRange.yearToDate:
        dataPoints = 52; // Weeks in year
        interval = const Duration(days: 7);
        break;
      case StockRange.oneYear:
        dataPoints = 52;
        interval = const Duration(days: 7);
        break;
      case StockRange.fiveYears:
        dataPoints = 60; // 5 years * 12 months
        interval = const Duration(days: 30);
        break;
    }

    final points = <ChartPoint>[];
    double currentPrice = basePrice + (random.nextDouble() - 0.5) * 10;

    for (int i = 0; i < dataPoints; i++) {
      final timestamp = now.subtract(interval * (dataPoints - i));

      // Random walk with slight upward bias
      currentPrice += (random.nextDouble() - 0.48) * 2;
      currentPrice = currentPrice.clamp(basePrice - 15, basePrice + 15);

      points.add(ChartPoint(
        timestamp: timestamp,
        price: currentPrice,
      ));
    }

    return points;
  }
}

/// Provider for stock detail controller (family provider for different symbols)
final stockDetailControllerProvider = StateNotifierProvider.family<
    StockDetailController, StockDetailState, String>((ref, symbol) {
  // Extract name from symbol if needed - for now using symbol as placeholder
  return StockDetailController(symbol, symbol);
});
