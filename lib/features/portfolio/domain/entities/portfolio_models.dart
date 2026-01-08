import 'package:flutter/material.dart';

/// Represents a single stock holding in the portfolio
class Holding {
  final String symbol;
  final String name;
  final double investedValue;
  final int shares;
  final double changePercent;
  final bool isPositive;

  const Holding({
    required this.symbol,
    required this.name,
    required this.investedValue,
    required this.shares,
    required this.changePercent,
    required this.isPositive,
  });

  factory Holding.create({
    required String symbol,
    required String name,
    required double investedValue,
    required int shares,
    required double changePercent,
  }) {
    return Holding(
      symbol: symbol,
      name: name,
      investedValue: investedValue,
      shares: shares,
      changePercent: changePercent,
      isPositive: changePercent >= 0,
    );
  }
}

/// Represents an asset category for the donut chart
class AssetCategory {
  final String name;
  final double value;
  final double percentage;
  final Color color;

  const AssetCategory({
    required this.name,
    required this.value,
    required this.percentage,
    required this.color,
  });
}

/// Portfolio summary containing overall metrics
class PortfolioSummary {
  final double totalValue;
  final double invested;
  final double current;
  final double gain;
  final double dailyChangePercent;
  final bool isPositive;

  const PortfolioSummary({
    required this.totalValue,
    required this.invested,
    required this.current,
    required this.gain,
    required this.dailyChangePercent,
    required this.isPositive,
  });

  String get formattedTotalValue => '\$${_formatNumber(totalValue)}';
  String get formattedInvested => '\$${_formatNumber(invested)}';
  String get formattedCurrent => '\$${_formatNumber(current)}';
  String get formattedGain => '\$${_formatNumber(gain)}';
  String get formattedDailyChange => '${isPositive ? "+" : ""}${dailyChangePercent.toStringAsFixed(1)}%';

  String _formatNumber(double value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(2)}M';
    } else if (value >= 1000) {
      return value.toStringAsFixed(2).replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},',
          );
    }
    return value.toStringAsFixed(2);
  }
}
