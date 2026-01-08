import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';

/// Stock price range enum
enum StockRange {
  oneDay('1D'),
  fiveDays('5D'),
  oneMonth('1M'),
  sixMonths('6M'),
  yearToDate('YTD'),
  oneYear('1Y'),
  fiveYears('5Y');

  const StockRange(this.label);
  final String label;
}

/// Chart data point
@freezed
class ChartPoint with _$ChartPoint {
  const factory ChartPoint({
    required DateTime timestamp,
    required double price,
  }) = _ChartPoint;
}

/// Fundamentals data
@freezed
class Fundamentals with _$Fundamentals {
  const factory Fundamentals({
    required String marketCap,
    required String peRatio,
    required String eps,
    required String dividendYield,
    required String beta,
    required String revenue,
  }) = _Fundamentals;
}

/// Trading information
@freezed
class TradingInfo with _$TradingInfo {
  const factory TradingInfo({
    required String open,
    required String high,
    required String low,
    required String prevClose,
    required String bid,
    required String ask,
  }) = _TradingInfo;
}

/// Stock detail state
@freezed
class StockDetailState with _$StockDetailState {
  const factory StockDetailState({
    required String symbol,
    required double price,
    required double priceChange,
    required double percentChange,
    required StockRange range,
    required List<ChartPoint> chartPoints,
    required Fundamentals fundamentals,
    required TradingInfo tradingInfo,
    required bool isInWatchlist,
    required bool hasAlert,
  }) = _StockDetailState;

  factory StockDetailState.initial() => StockDetailState(
        symbol: 'AAPL',
        price: 175.45,
        priceChange: -1.20,
        percentChange: -0.68,
        range: StockRange.oneDay,
        chartPoints: [],
        fundamentals: const Fundamentals(
          marketCap: '\$2.73T',
          peRatio: '28.5x',
          eps: '\$6.12',
          dividendYield: '0.54%',
          beta: '1.28',
          revenue: '\$383.3B',
        ),
        tradingInfo: const TradingInfo(
          open: '\$176.00',
          high: '\$176.50',
          low: '\$174.90',
          prevClose: '\$176.65',
          bid: '\$175.40',
          ask: '\$175.50',
        ),
        isInWatchlist: false,
        hasAlert: false,
      );
}
