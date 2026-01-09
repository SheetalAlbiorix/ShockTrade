import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';

class PortfolioSummaryCard extends StatelessWidget {
  const PortfolioSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.premiumCardGradient,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.premiumCardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Portfolio Value',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.darkTextSecondary,
                    ),
              ),
              // Floating + Button (Visual representation in row for alignment, usually floating means atop but here as action button)
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.premiumAccentBlue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.add, color: Colors.white, size: 20),
              )
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '₹ 12,45,000.00',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.darkTextPrimary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.premiumAccentGreen.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.premiumAccentGreen.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.trending_up,
                        color: AppColors.premiumAccentGreen, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '+₹ 12,500 (1.2%)',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.premiumAccentGreen,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Today's P&L",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.darkTextSecondary,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Divider(color: AppColors.premiumCardBorder, thickness: 1),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDetailItem(context, 'Invested', '₹ 10,20,000'),
              _buildDetailItem(context, 'Current', '₹ 12,45,000'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.darkTextSecondary,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.darkTextPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
