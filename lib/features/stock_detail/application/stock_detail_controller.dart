import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/features/stock_detail/domain/models.dart';

/// Controller for stock detail screen
class StockDetailController extends StateNotifier<StockDetailState> {
  StockDetailController() : super(StockDetailState.initial()) {
    _loadInitialData();
  }

  void _loadInitialData() {
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
    final random = Random(42); // Fixed seed for consistent data
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

/// Provider for stock detail controller
final stockDetailControllerProvider =
    StateNotifierProvider<StockDetailController, StockDetailState>((ref) {
  return StockDetailController();
});
