import 'package:flutter/material.dart';

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
        isNegative ? const Color(0xFFFF4D4F) : const Color(0xFF00E0FF);

    return Container(
      width: double.infinity,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '\$${price.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
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
