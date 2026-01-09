import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/watchlist/application/providers/watchlist_provider.dart';

class IndexSummaryCards extends ConsumerWidget {
  const IndexSummaryCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indices = ref.watch(marketIndicesProvider);
    
    // In case no indices, show empty or default
    if (indices.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Row(
        children: indices.map((index) {
          final isFirst = index == indices.first;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: isFirst ? 0 : 6, right: isFirst ? 6 : 0),
              child: _buildIndexCard(index),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildIndexCard(MarketIndex index) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.premiumCardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: AppColors.premiumCardBorder,
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                index.name,
                style: const TextStyle(
                  color: AppColors.darkTextSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              Icon(
                index.isPositive ? Icons.trending_up : Icons.trending_down,
                color: index.isPositive
                    ? AppColors.premiumAccentGreen
                    : AppColors.premiumAccentRed,
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            // Format number with commas
            index.value.toStringAsFixed(2).replaceAllMapped(
                RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
            style: const TextStyle(
              color: AppColors.darkTextPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                index.isPositive ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: index.isPositive
                    ? AppColors.premiumAccentGreen
                    : AppColors.premiumAccentRed,
                size: 20,
              ),
              Text(
                '${index.change.abs().toStringAsFixed(2)} (${index.changePercent.abs().toStringAsFixed(2)}%)',
                style: TextStyle(
                  color: index.isPositive
                      ? AppColors.premiumAccentGreen
                      : AppColors.premiumAccentRed,
                  fontSize: 13,
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
