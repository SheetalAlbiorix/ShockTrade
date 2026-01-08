import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';

/// Price header widget showing current price and daily change
class PriceHeader extends StatelessWidget {
  final double price;
  final double priceChange;
  final double percentChange;

  const PriceHeader({
    super.key,
    required this.price,
    required this.priceChange,
    required this.percentChange,
  });

  @override
  Widget build(BuildContext context) {
    final isNegative = priceChange < 0;
    final changeColor =
        isNegative ? AppColors.bearishRed : AppColors.bullishGreen;

    return Container(
      width: double.infinity,
      color: AppColors.darkBackground,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '₹${price.toStringAsFixed(2)}',
            style: const TextStyle(
              color: AppColors.darkTextPrimary,
              fontSize: 48,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                isNegative ? Icons.arrow_downward : Icons.arrow_upward,
                color: changeColor,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                '${priceChange.toStringAsFixed(2)} (${percentChange.toStringAsFixed(2)}%)',
                style: TextStyle(
                  color: changeColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
