import 'dart:math';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/di/di.dart';
import 'package:shock_app/features/stock_detail/domain/models.dart';
import 'package:shock_app/features/stock_detail/domain/stock_repository.dart';

/// Controller for stock detail screen
class StockDetailController extends StateNotifier<StockDetailState> {
  final StockRepository _repository;

  StockDetailController(String symbol, this._repository,
      {String? name, double? price, double? pChange})
      : super(StockDetailState.fromBasicInfo(
          symbol: symbol,
          name: name ?? symbol,
          price: price,
          pChange: pChange,
        )) {
    _loadStockData(symbol);
  }

  /// Seed the controller with initial data if it's still loading or unitialized
  void seedData({required String name, double? price, double? pChange}) {
    // Only update if we haven't loaded full data yet or if it's the initial placeholder
    if (state.companyName == state.symbol || state.isLoading) {
      state = state.copyWith(
        companyName: name,
        price: price ?? state.price,
        percentChange: pChange ?? state.percentChange,
        isPositive: (pChange ?? state.percentChange) >= 0,
      );
    }
  }

  Future<void> _loadStockData(String symbol) async {
    // Keep current values just in case we have some initial ones
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final details = await _repository.getStockDetails(symbol);

      // Preserve existing chart points if any (or generate mock if API serves none for now)
      // Since Mboum endpoint I used doesn't return charts in the same call,
      // I will keep the mock chart generation for visual continuity until chart API is added.
      // But I will update the price and other details.

      // Generate some consistent chart data matching current price for visual niceness
      // In a full implementation, we would fetch history here too.
      final chartPoints = _generateMockChartData(StockRange.oneDay, details);

      state = details.copyWith(
        chartPoints: chartPoints, // Overlay mock chart on real data
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      print('Error loading stock details: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load stock data: ${e.toString()}',
      );
    }
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
    // In real app, this would fetch history for the new range
    final chartPoints = _generateMockChartData(range, state);
    state = state.copyWith(
      range: range,
      chartPoints: chartPoints,
    );
  }

  /// Generate realistic mock chart data based on OHLC constraints
  List<ChartPoint> _generateMockChartData(
      StockRange range, StockDetailState details) {
    // Only generate realistic intraday for 1D, others can remain random walk or be improved later
    if (range != StockRange.oneDay) {
      return _generateRandomWalk(range, details.price);
    }

    final now = DateTime.now();
    // Market hours: 9:15 AM to 3:30 PM IST
    final marketOpen = DateTime(now.year, now.month, now.day, 9, 15);
    final marketClose = DateTime(now.year, now.month, now.day, 15, 30);

    // Determine end time (now or market close)
    final endTime = now.isAfter(marketClose) ? marketClose : now;
    if (endTime.isBefore(marketOpen)) return []; // Market hasn't opened

    // Parse OHLC
    double open =
        double.tryParse(details.tradingInfo.open.replaceAll(',', '')) ??
            details.price;
    double high =
        double.tryParse(details.tradingInfo.high.replaceAll(',', '')) ??
            details.price;
    double low = double.tryParse(details.tradingInfo.low.replaceAll(',', '')) ??
        details.price;
    double current = details.price;

    // Sanity check
    if (high < low) {
      double temp = high;
      high = low;
      low = temp;
    }
    if (open == 0) open = current;
    if (high == 0) high = current > open ? current : open; // minimal fallback
    if (low == 0) low = current < open ? current : open;

    final points = <ChartPoint>[];
    final totalMinutes = endTime.difference(marketOpen).inMinutes;
    // Generate point every 15 mins
    final step = 15;
    final numPoints = (totalMinutes / step).ceil();

    if (numPoints <= 0) return [];

    // We need to generate a path from Open -> Current
    // That touches High and Low at some random points.

    final random = Random();
    // Decide randomly when High and Low occur (between 0 and numPoints)
    int highIndex = random.nextInt(numPoints);
    int lowIndex = random.nextInt(numPoints);

    // Generate path
    double previousPrice = open;

    for (int i = 0; i <= numPoints; i++) {
      double t = i / numPoints; // 0.0 to 1.0 progress

      double targetPrice;

      // Force endpoints
      if (i == 0)
        targetPrice = open;
      else if (i == numPoints)
        targetPrice = current;
      else if (i == highIndex)
        targetPrice = high;
      else if (i == lowIndex)
        targetPrice = low;
      else {
        // Random walk with drift towards target
        // Drift towards 'current' as time passes
        double trend = open + (current - open) * t;
        // Add noise
        double volatility = (high - low) * 0.2;
        double noise = (random.nextDouble() - 0.5) * volatility;
        targetPrice = trend + noise;
      }

      // Clamp to High/Low constraints
      if (targetPrice > high) targetPrice = high;
      if (targetPrice < low) targetPrice = low;

      // Smooth it a bit (don't jump too wild)
      if (i > 0) {
        targetPrice = previousPrice + (targetPrice - previousPrice) * 0.5;
      }

      // Generate simulated OHLC for this candle
      // We'll use targetPrice as 'Close'
      double c = targetPrice;
      double o = previousPrice; // Previous close is this candle's open
      double h = max(o, c) + random.nextDouble() * (high - low) * 0.05;
      double l = min(o, c) - random.nextDouble() * (high - low) * 0.05;

      points.add(ChartPoint(
        timestamp: marketOpen.add(Duration(minutes: i * step)),
        price: c, // 'price' acts as Close
        open: o,
        high: h,
        low: l,
      ));
      previousPrice = targetPrice;
    }

    return points;
  }

  // Legacy random walk for other ranges
  List<ChartPoint> _generateRandomWalk(StockRange range, double currentPrice) {
    final now = DateTime.now();
    int dataPoints;
    Duration interval;

    switch (range) {
      case StockRange.oneDay:
        dataPoints = 78;
        interval = const Duration(minutes: 5);
        break;
      case StockRange.fiveDays:
        dataPoints = 65;
        interval = const Duration(minutes: 30);
        break;
      case StockRange.oneMonth:
        dataPoints = 30;
        interval = const Duration(days: 1);
        break;
      case StockRange.sixMonths:
        dataPoints = 26;
        interval = const Duration(days: 7);
        break;
      case StockRange.yearToDate:
        dataPoints = 52;
        interval = const Duration(days: 7);
        break;
      case StockRange.oneYear:
        dataPoints = 52;
        interval = const Duration(days: 7);
        break;
      case StockRange.fiveYears:
        dataPoints = 60;
        interval = const Duration(days: 30);
        break;
    }

    final points = <ChartPoint>[];
    double tempPrice = currentPrice;
    final random = Random();

    // Create points in reverse (newest first)
    for (int i = 0; i < dataPoints; i++) {
      points.add(ChartPoint(
        timestamp: now.subtract(interval * i),
        price: tempPrice,
      ));

      // Walk away from current price
      tempPrice += (random.nextDouble() - 0.5) *
          (currentPrice * 0.05); // More volatility
    }

    return points.reversed.toList();
  }
}

/// Provider for stock detail controller (family provider for different symbols)
final stockDetailControllerProvider = StateNotifierProvider.family<
    StockDetailController, StockDetailState, String>((ref, symbol) {
  // Caching: Keep the state alive even if the UI unmounts.
  // This prevents re-fetching API when navigating back to the same stock.
  ref.keepAlive();

  return StockDetailController(
    symbol,
    getIt<StockRepository>(),
  );
});
