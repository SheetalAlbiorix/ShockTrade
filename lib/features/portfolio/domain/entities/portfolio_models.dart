import 'package:flutter/material.dart';

/// Represents a single stock holding in the portfolio
class Holding {
  final String symbol;
  final String name;
  final String logoUrl;
  final double quantity;
  final double avgPrice;
  final double currentPrice;
  final double pnlAmount;
  final double pnlPercentage;
  final bool isPositive;

  const Holding({
    required this.symbol,
    required this.name,
    required this.logoUrl,
    required this.quantity,
    required this.avgPrice,
    required this.currentPrice,
    required this.pnlAmount,
    required this.pnlPercentage,
    required this.isPositive,
  });

  double get currentValue => quantity * currentPrice;
  double get investedValue => quantity * avgPrice;

  factory Holding.mock({
    required String symbol,
    required String name,
    required String logoUrl,
    required double quantity,
    required double avgPrice,
    required double currentPrice,
  }) {
    final pnlAmount = (currentPrice - avgPrice) * quantity;
    final pnlPercentage = ((currentPrice - avgPrice) / avgPrice) * 100;
    return Holding(
      symbol: symbol,
      name: name,
      logoUrl: logoUrl,
      quantity: quantity,
      avgPrice: avgPrice,
      currentPrice: currentPrice,
      pnlAmount: pnlAmount,
      pnlPercentage: pnlPercentage,
      isPositive: pnlAmount >= 0,
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
