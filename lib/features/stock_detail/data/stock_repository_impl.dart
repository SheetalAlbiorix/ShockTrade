import 'package:shock_app/core/networking/indian_api_client.dart';
import 'package:shock_app/features/stock_detail/domain/models.dart';
import 'package:shock_app/features/stock_detail/domain/stock_repository.dart';

class StockRepositoryImpl implements StockRepository {
  final IndianApiClient _apiClient;

  StockRepositoryImpl(this._apiClient);

  @override
  Future<StockDetailState> getStockDetails(String symbol) async {
    try {
      // API expects name without suffix (e.g. 'TCS' instead of 'TCS.NS')
      final cleanSymbol = symbol.endsWith('.NS')
          ? symbol.substring(0, symbol.length - 3)
          : symbol;

      // 1. Fetch Quote (internally contains recentNews)
      final data = await _apiClient.getStockDetails(cleanSymbol);

      // 2. Map to Domain Model
      return _mapToStockDetail(cleanSymbol, data);
    } catch (e) {
      print('Error in repository: $e');
      rethrow;
    }
  }

  StockDetailState _mapToStockDetail(String symbol, Map<String, dynamic> json) {
    try {
      final reusableData =
          json['stockDetailsReusableData'] as Map<String, dynamic>?;
      final currentPriceMap = json['currentPrice'] as Map<String, dynamic>?;
      final recentNewsRaw = json['recentNews'] as List<dynamic>?;
      final riskMeterRaw = json['riskMeter'] as Map<String, dynamic>?;

      // ... (rest of the mapping logic) ...

      if (reusableData == null && currentPriceMap == null) {
        throw Exception('Price data not available for this symbol');
      }

      double price = 0.0;
      double priceChange = 0.0;
      double percentChange = 0.0;
      double prevClose = 0.0;
      double high = 0.0;
      double low = 0.0;
      double open = 0.0;

      // Primary Source: StockDetailsReusableData (BSE usually, but contains change/trend)
      if (reusableData != null) {
        price =
            double.tryParse(reusableData['price']?.toString() ?? '0') ?? 0.0;
        percentChange =
            double.tryParse(reusableData['percentChange']?.toString() ?? '0') ??
                0.0;
        prevClose =
            double.tryParse(reusableData['close']?.toString() ?? '0') ?? 0.0;
        high = double.tryParse(reusableData['high']?.toString() ?? '0') ?? 0.0;
        low = double.tryParse(reusableData['low']?.toString() ?? '0') ?? 0.0;
        open = double.tryParse(reusableData['open']?.toString() ?? '0') ?? 0.0;

        // Calculate change if not provided explicitly
        if (price != 0 && prevClose != 0) {
          priceChange = price - prevClose;
        }

        // Fallback for Open if missing (use Prev Close)
        if (open == 0 && prevClose != 0) {
          open = prevClose;
        }
      }
      // Fallback Source: CurrentPrice (LTP only)
      else if (currentPriceMap != null) {
        final nsePriceStr = currentPriceMap['NSE']?.toString();
        final bsePriceStr = currentPriceMap['BSE']?.toString();
        final priceStr = nsePriceStr ?? bsePriceStr ?? '0.0';
        price = double.tryParse(priceStr) ?? 0.0;
      }

      // Ensure valid price
      if (price == 0.0) {
        // Try finding it in the other source if primary failed to parse
        if (currentPriceMap != null) {
          final nsePriceStr = currentPriceMap['NSE']?.toString();
          final bsePriceStr = currentPriceMap['BSE']?.toString();
          price = double.tryParse(nsePriceStr ?? bsePriceStr ?? '0.0') ?? 0.0;
        }
      }

      final isPositive = percentChange >= 0;

      // Map News
      final newsList = recentNewsRaw?.take(5).map((item) {
            final pubDateStr = item['date'] as String?;
            String timeAgo = 'Just now';

            if (pubDateStr != null) {
              try {
                final pubDate = DateTime.parse(pubDateStr);
                final diff = DateTime.now().difference(pubDate);
                if (diff.inDays > 0) {
                  timeAgo =
                      '${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago';
                } else if (diff.inHours > 0) {
                  timeAgo =
                      '${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago';
                } else {
                  timeAgo =
                      '${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago';
                }
              } catch (_) {}
            }

            // Handle relative URLs
            String url = item['url'] ?? '';
            if (url.startsWith('/')) {
              url = 'https://www.livemint.com$url';
            }

            return StockNews(
              title: item['headline'] ?? 'No Title',
              source: 'LiveMint', // Inferred from image source logic
              timeAgo: timeAgo,
              url: url,
              imageUrl: item['listimage'] ?? item['thumbnailImage'],
            );
          }).toList() ??
          [];

      return StockDetailState(
        symbol: symbol,
        companyName: json['companyName'] ?? symbol,
        price: price,
        priceChange: priceChange,
        percentChange: percentChange,
        isPositive: isPositive,
        range: StockRange.oneDay,
        chartPoints: [],
        fundamentals: Fundamentals(
          marketCap: reusableData?['marketCap']?.toString() ?? '-',
          peRatio: reusableData?['pPerEBasicExcludingExtraordinaryItemsTTM']
                  ?.toString() ??
              '-',
          dividendYield:
              reusableData?['currentDividendYieldCommonStockPrimaryIssueLTM']
                      ?.toString() ??
                  '-',
          eps: '-',
          beta: '-',
          revenue: '-',
        ),
        tradingInfo: TradingInfo(
          open: open != 0 ? open.toStringAsFixed(2) : '-',
          high: high != 0 ? high.toStringAsFixed(2) : '-',
          low: low != 0 ? low.toStringAsFixed(2) : '-',
          prevClose: prevClose != 0 ? prevClose.toStringAsFixed(2) : '-',
          week52High: reusableData?['yhigh']?.toString() ?? '-',
          week52Low: reusableData?['ylow']?.toString() ?? '-',
          bid: '-',
          ask: '-',
          lowerCircuit: reusableData?['lowerCircuit']?.toString() ??
              (prevClose != 0
                  ? (prevClose * 0.9).toStringAsFixed(2)
                  : '-'), // Estimate 10% LC
          upperCircuit: reusableData?['upperCircuit']?.toString() ??
              (prevClose != 0
                  ? (prevClose * 1.1).toStringAsFixed(2)
                  : '-'), // Estimate 10% UC
          volume: reusableData?['volume']?.toString() ?? '-',
          avgPrice: reusableData?['averagePrice']?.toString() ?? '-',
          lastTradedQty: reusableData?['lastTradedQuantity']?.toString() ?? '-',
          lastTradedTime: reusableData?['lastTradedTime']?.toString() ?? '-',
        ),
        isInWatchlist: false,
        hasAlert: false,
        imageUrl: json['imageUrl'] ?? reusableData?['imageUrl'],
        news: newsList,
        riskMeter: riskMeterRaw != null
            ? RiskMeter(
                categoryName:
                    riskMeterRaw['categoryName']?.toString() ?? 'Low risk',
                stdDev: double.tryParse(
                        riskMeterRaw['stdDev']?.toString() ?? '0') ??
                    0.0,
              )
            : null,
      );
    } catch (e) {
      rethrow;
    }
  }
}
