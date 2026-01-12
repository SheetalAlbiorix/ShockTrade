import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/stock_detail/domain/models.dart';

class RiskMeterWidget extends StatelessWidget {
  final RiskMeter riskMeter;

  const RiskMeterWidget({super.key, required this.riskMeter});

  @override
  Widget build(BuildContext context) {
    // Determine color based on risk category
    Color riskColor = AppColors.bullishGreen;
    if (riskMeter.categoryName.toLowerCase().contains('high')) {
      riskColor = AppColors.bearishRed;
    } else if (riskMeter.categoryName.toLowerCase().contains('moderate') ||
        riskMeter.categoryName.toLowerCase().contains('medium')) {
      riskColor = AppColors.primaryGold;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.glassBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.glassBorder.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Icon(
            Icons.speed,
            color: riskColor,
            size: 18,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'RISK METER',
                style: TextStyle(
                  color: AppColors.darkTextSecondary.withOpacity(0.7),
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    riskMeter.categoryName,
                    style: TextStyle(
                      color: riskColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '(${riskMeter.stdDev.toStringAsFixed(2)})',
                    style: const TextStyle(
                      color: AppColors.darkTextSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
