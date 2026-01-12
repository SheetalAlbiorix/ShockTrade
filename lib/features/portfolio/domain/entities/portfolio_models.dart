
/// Represents a single stock holding in the portfolio
class Holding {
  final String id;
  final String symbol;
  final String name;
  final String logoUrl;
  final double quantity;
  final double avgPrice;
  final double currentPrice;
  final double pnlAmount;
  final double pnlPercentage;
  final bool isPositive;
  final DateTime purchaseDate;

  const Holding({
    required this.id,
    required this.symbol,
    required this.name,
    required this.logoUrl,
    required this.quantity,
    required this.avgPrice,
    required this.currentPrice,
    required this.pnlAmount,
    required this.pnlPercentage,
    required this.isPositive,
    required this.purchaseDate,
  });

  double get currentValue => quantity * currentPrice;
  double get investedValue => quantity * avgPrice;

  factory Holding.mock({
    required String id,
    required String symbol,
    required String name,
    required String logoUrl,
    required double quantity,
    required double avgPrice,
    required double currentPrice,
    DateTime? purchaseDate,
  }) {
    final pnlAmount = (currentPrice - avgPrice) * quantity;
    final pnlPercentage = avgPrice != 0 ? ((currentPrice - avgPrice) / avgPrice) * 100 : 0;
    return Holding(
      id: id,
      symbol: symbol,
      name: name,
      logoUrl: logoUrl,
      quantity: quantity,
      avgPrice: avgPrice,
      currentPrice: currentPrice,
      pnlAmount: pnlAmount,
      pnlPercentage: pnlPercentage.toDouble(),
      isPositive: pnlAmount >= 0,
      purchaseDate: purchaseDate ?? DateTime.now(),
    );
  }

  Holding copyWith({
    String? id,
    String? symbol,
    String? name,
    String? logoUrl,
    double? quantity,
    double? avgPrice,
    double? currentPrice,
    DateTime? purchaseDate,
  }) {
    return Holding.mock(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      logoUrl: logoUrl ?? this.logoUrl,
      quantity: quantity ?? this.quantity,
      avgPrice: avgPrice ?? this.avgPrice,
      currentPrice: currentPrice ?? this.currentPrice,
      purchaseDate: purchaseDate ?? this.purchaseDate,
    );
  }
}

/// Portfolio summary containing overall metrics
class PortfolioSummary {
  final double totalValue;
  final double investedValue;
  final double dayPnlAmount;
  final double dayPnlPercentage;
  final double totalPnlAmount;
  final double totalPnlPercentage;

  const PortfolioSummary({
    required this.totalValue,
    required this.investedValue,
    required this.dayPnlAmount,
    required this.dayPnlPercentage,
    required this.totalPnlAmount,
    required this.totalPnlPercentage,
  });

  bool get isDayPositive => dayPnlAmount >= 0;
  bool get isTotalPositive => totalPnlAmount >= 0;
}

/// Chart data point
class ChartDataPoint {
  final double x;
  final double y;

  const ChartDataPoint(this.x, this.y);
}
