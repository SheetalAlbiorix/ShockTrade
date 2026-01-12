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
    double? open,
    double? high,
    double? low,
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
    required String week52High,
    required String week52Low,
    required String bid,
    required String ask,
    // New fields for Markets Today
    required String lowerCircuit,
    required String upperCircuit,
    required String volume,
    required String avgPrice,
    required String lastTradedQty,
    required String lastTradedTime,
  }) = _TradingInfo;
}

/// News article model
@freezed
class StockNews with _$StockNews {
  const factory StockNews({
    required String title,
    required String source,
    required String timeAgo,
    String? imageUrl,
    String? url,
  }) = _StockNews;
}

/// Stock detail state
@freezed
class StockDetailState with _$StockDetailState {
  const factory StockDetailState({
    required String symbol,
    required String companyName,
    required double price,
    required double priceChange,
    required double percentChange,
    required bool isPositive,
    required StockRange range,
    required List<ChartPoint> chartPoints,
    required Fundamentals fundamentals,
    required TradingInfo tradingInfo,
    required List<StockNews> news,
    required bool isInWatchlist,
    required bool hasAlert,
    String? errorMessage,
    @Default(false) bool isLoading,
    String? imageUrl,
    RiskMeter? riskMeter,
  }) = _StockDetailState;

  factory StockDetailState.initial() => StockDetailState(
        symbol: 'AAPL',
        companyName: 'Apple Inc.',
        price: 175.45,
        priceChange: -1.20,
        percentChange: -0.68,
        isPositive: false,
        range: StockRange.oneDay,
        chartPoints: [],
        fundamentals: const Fundamentals(
          marketCap: '₹2.73T',
          peRatio: '28.5x',
          eps: '₹6.12',
          dividendYield: '0.54%',
          beta: '1.28',
          revenue: '₹383.3B',
        ),
        tradingInfo: const TradingInfo(
          open: '₹176.00',
          high: '₹176.50',
          low: '₹174.90',
          prevClose: '₹176.65',
          week52High: '₹198.23',
          week52Low: '₹124.17',
          bid: '₹175.40',
          ask: '₹175.50',
          lowerCircuit: '₹158.98',
          upperCircuit: '₹194.32',
          volume: '6,64,98,246',
          avgPrice: '₹176.25',
          lastTradedQty: '120',
          lastTradedTime: '15:59:18',
        ),
        news: [],
        isInWatchlist: false,
        hasAlert: false,
        imageUrl: null,
        riskMeter: null,
      );
}

/// Risk meter model
@freezed
class RiskMeter with _$RiskMeter {
  const factory RiskMeter({
    required String categoryName,
    required double stdDev,
  }) = _RiskMeter;
}
