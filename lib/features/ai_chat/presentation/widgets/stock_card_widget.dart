import 'package:flutter/material.dart';
import 'package:shock_app/features/ai_chat/presentation/ai_chat_colors.dart';
import 'package:shock_app/features/ai_chat/presentation/widgets/mini_sparkline.dart';

/// Stock card widget for embedding in bot messages
class StockCardWidget extends StatelessWidget {
  final String symbol;
  final double currentPrice;
  final double changePercent;
  final bool isPositive;
  final List<double>? sparklineData;

  const StockCardWidget({
    super.key,
    required this.symbol,
    required this.currentPrice,
    required this.changePercent,
    required this.isPositive,
    this.sparklineData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stock info card
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AIChatColors.black20,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AIChatColors.whiteBorder5,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Price info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CURRENT PRICE',
                    style: TextStyle(
                      color: AIChatColors.textGray400,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '₹${currentPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isPositive
                              ? AIChatColors.success
                              : AIChatColors.danger,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isPositive
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              color: Colors.white,
                              size: 14,
                            ),
                            Text(
                              '${changePercent.abs().toStringAsFixed(1)}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Mini sparkline
              if (sparklineData != null && sparklineData!.isNotEmpty)
                MiniSparkline(
                  dataPoints: sparklineData!,
                  color:
                      isPositive ? AIChatColors.success : AIChatColors.danger,
                  width: 96,
                  height: 40,
                ),
            ],
          ),
        ),

        // Additional info text
        const SizedBox(height: 12),
        const Text(
          'Technical indicators like RSI (62) and MACD suggest continued upside. Resistance is at ₹955.',
          style: TextStyle(
            color: AIChatColors.textGray300,
            fontSize: 14,
            height: 1.5,
          ),
        ),

        // Action buttons
        const SizedBox(height: 12),
        Row(
          children: [
            _ActionButton(
              label: 'View Charts',
              onTap: () {},
            ),
            const SizedBox(width: 8),
            _ActionButton(
              label: 'Set Alert',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AIChatColors.whiteHover5,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AIChatColors.whiteBorder10,
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
