import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/portfolio/domain/entities/portfolio_models.dart';
import 'package:intl/intl.dart';

class PortfolioSummaryHeader extends StatelessWidget {
  final PortfolioSummary summary;

  const PortfolioSummaryHeader({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
    
    return Column(
      children: [
        const Text(
          'TOTAL PORTFOLIO VALUE',
          style: TextStyle(
            color: AppColors.darkTextSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          currencyFormat.format(summary.totalValue),
          style: const TextStyle(
            color: AppColors.darkTextPrimary,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: (summary.isTotalPositive ? AppColors.bullishGreen : AppColors.bearishRed).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                summary.isTotalPositive ? Icons.trending_up : Icons.trending_down,
                color: summary.isTotalPositive ? AppColors.bullishGreen : AppColors.bearishRed,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                '${summary.isTotalPositive ? "+" : ""}${currencyFormat.format(summary.totalPnlAmount)} (${summary.totalPnlPercentage.toStringAsFixed(1)}%)',
                style: TextStyle(
                  color: summary.isTotalPositive ? AppColors.bullishGreen : AppColors.bearishRed,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PortfolioMetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final Color? valueColor;

  const PortfolioMetricCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.premiumCardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.premiumCardBorder, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.darkTextSecondary,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? AppColors.darkTextPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: TextStyle(
                color: valueColor ?? AppColors.darkTextSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
