import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/portfolio/domain/entities/portfolio_models.dart';

/// Reusable holding row widget for portfolio display
class HoldingRowWidget extends StatelessWidget {
  final Holding holding;
  final VoidCallback? onTap;

  const HoldingRowWidget({
    super.key,
    required this.holding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${holding.symbol}, ${holding.name}, '
          'invested \$${holding.investedValue.toStringAsFixed(2)}, '
          '${holding.shares} shares, '
          '${holding.isPositive ? "up" : "down"} ${holding.changePercent.abs()}%',
      button: true,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
              // Stock info
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      holding.symbol,
                      style: const TextStyle(
                        color: AppColors.darkTextPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      holding.name,
                      style: const TextStyle(
                        color: AppColors.darkTextSecondary,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Value and shares
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${holding.investedValue.toStringAsFixed(2).replaceAllMapped(
                            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            (Match m) => '${m[1]},',
                          )}',
                      style: const TextStyle(
                        color: AppColors.darkTextPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${holding.shares} shares',
                      style: const TextStyle(
                        color: AppColors.darkTextSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Change percentage
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: (holding.isPositive
                          ? AppColors.bullishGreen
                          : AppColors.bearishRed)
                      .withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      holding.isPositive
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      color: holding.isPositive
                          ? AppColors.bullishGreen
                          : AppColors.bearishRed,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${holding.changePercent.abs().toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: holding.isPositive
                            ? AppColors.bullishGreen
                            : AppColors.bearishRed,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
