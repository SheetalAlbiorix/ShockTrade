import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/watchlist/domain/entities/watchlist_models.dart';

class WatchlistStockCard extends StatelessWidget {
  final Stock stock;
  final VoidCallback? onTap;

  const WatchlistStockCard({
    super.key,
    required this.stock,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.premiumCardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: AppColors.premiumCardBorder,
          width: 0.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            onTap?.call();
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Logo placeholder
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.premiumSurface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.premiumCardBorder,
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    stock.symbol[0],
                    style: TextStyle(
                      color: AppColors.premiumAccentBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                
                // Name and Exchange
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              stock.symbol,
                              style: const TextStyle(
                                color: AppColors.darkTextPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.premiumSurface,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'NSE',
                              style: TextStyle(
                                color: AppColors.darkTextSecondary,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        stock.name,
                        style: const TextStyle(
                          color: AppColors.darkTextSecondary,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                
                // Price and Change
                Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₹${stock.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: AppColors.darkTextPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: (stock.isPositive ? AppColors.premiumAccentGreen : AppColors.premiumAccentRed).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${stock.isPositive ? "+" : ""}${stock.change.toStringAsFixed(2)} (${stock.changePercent.abs().toStringAsFixed(2)}%)',
                          style: TextStyle(
                            color: stock.isPositive
                                ? AppColors.premiumAccentGreen
                                : AppColors.premiumAccentRed,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
