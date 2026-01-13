import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_stock.freezed.dart';

@Freezed(toJson: false, fromJson: false)
class MarketStock with _$MarketStock {
  const factory MarketStock({
    required String symbol,
    required String name,
    required double lastPrice,
    required double change,
    required double pChange,
    @Default(true) bool isPositive,
  }) = _MarketStock;

  factory MarketStock.fromJson(Map<String, dynamic> json) {
    // Robust parsing for different API formats
    final symbol = (json['symbol'] ?? json['ticker'] ?? json['ric'] ?? '') as String;
    final name = (json['name'] ?? json['company'] ?? json['company_name'] ?? '') as String;
    
    double parseDouble(dynamic value) {
      if (value == null) return 0.0;
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    final lastPrice = parseDouble(json['lastPrice'] ?? json['price']);
    final change = parseDouble(json['change'] ?? json['net_change']);
    final pChange = parseDouble(json['pChange'] ?? json['percent_change']);
    final isPositive = json['isPositive'] as bool? ?? (pChange >= 0);

    return MarketStock(
      symbol: symbol,
      name: name,
      lastPrice: lastPrice,
      change: change,
      pChange: pChange,
      isPositive: isPositive,
    );
  }
}
