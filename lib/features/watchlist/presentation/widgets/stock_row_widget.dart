import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/watchlist/domain/entities/watchlist_models.dart';

/// Reusable stock row widget for watchlist display
class StockRowWidget extends StatelessWidget {
  final Stock stock;
  final VoidCallback? onTrade;
  final VoidCallback? onDetails;

  const StockRowWidget({
    super.key,
    required this.stock,
    this.onTrade,
    this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${stock.symbol}, ${stock.name}, price ${stock.price}, '
          '${stock.isPositive ? "up" : "down"} ${stock.changePercent.abs()}%',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.darkDivider,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            // Stock info (symbol + name)
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        stock.symbol,
                        style: const TextStyle(
                          color: AppColors.darkTextPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          stock.name,
                          style: const TextStyle(
                            color: AppColors.darkTextSecondary,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Price and change
                  Row(
                    children: [
                      Text(
                        '\$${stock.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: AppColors.darkTextPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        stock.isPositive
                            ? Icons.trending_up
                            : Icons.trending_down,
                        color: stock.isPositive
                            ? AppColors.bullishGreen
                            : AppColors.bearishRed,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${stock.isPositive ? "+" : ""}${stock.change.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: stock.isPositive
                              ? AppColors.bullishGreen
                              : AppColors.bearishRed,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${stock.changePercent.abs().toStringAsFixed(2)}%)',
                        style: TextStyle(
                          color: stock.isPositive
                              ? AppColors.bullishGreen
                              : AppColors.bearishRed,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Action buttons
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Trade button
                TextButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    onTrade?.call();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.darkTextPrimary,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    minimumSize: const Size(48, 48),
                  ),
                  child: const Text(
                    'Trade',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                const SizedBox(width: 4),
                // Details button
                OutlinedButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    onDetails?.call();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.darkTextPrimary,
                    side: const BorderSide(color: AppColors.darkDivider),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    minimumSize: const Size(48, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    'Details',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
