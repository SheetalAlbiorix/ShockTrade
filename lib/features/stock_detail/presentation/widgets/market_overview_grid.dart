import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/stock_detail/presentation/widgets/glass_card.dart';

/// Market overview grid showing key stock metrics
class MarketOverviewGrid extends StatelessWidget {
  final String open;
  final String high;
  final String low;
  final String prevClose;
  final String volume;
  final String marketCap;

  const MarketOverviewGrid({
    super.key,
    required this.open,
    required this.high,
    required this.low,
    required this.prevClose,
    required this.volume,
    required this.marketCap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12, // gap-3 from HTML (12px)
      crossAxisSpacing: 12, // gap-3 from HTML (12px)
      childAspectRatio: 0.9, // Slightly taller cards
      children: [
        _buildGridItem('Open', open),
        _buildGridItem('High', high),
        _buildGridItem('Low', low),
        _buildGridItem('Prev. Close', prevClose),
        _buildGridItem('Volume', volume),
        _buildGridItem('Mkt Cap', marketCap),
      ],
    );
  }

  Widget _buildGridItem(String label, String value) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(
          horizontal: 12, vertical: 12), // Reduced vertical padding
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.darkTextSecondary,
              fontSize: 11, // Increased from 10
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6), // Increased gap
          Text(
            value,
            style: const TextStyle(
              color: AppColors.darkTextPrimary,
              fontSize: 16, // Increased from 14
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5, // tracking-tight
            ),
          ),
        ],
      ),
    );
  }
}
