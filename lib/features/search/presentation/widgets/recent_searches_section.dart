import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/watchlist/domain/entities/watchlist_models.dart';

class RecentSearchesSection extends StatelessWidget {
  final List<Stock> items;
  final VoidCallback onClear;

  const RecentSearchesSection({
    super.key,
    required this.items,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Searches',
                style: TextStyle(
                  color: AppColors.darkTextPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: onClear,
                child: const Text(
                  'Clear',
                  style: TextStyle(
                    color: AppColors.premiumAccentBlue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        // List
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: items.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = items[index];
            return InkWell(
              onTap: () => context.push('/stock-detail?symbol=${item.symbol}&name=${item.name}'),
              child: Row(
                children: [
                  // Icon
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.premiumCardBackground,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.premiumCardBorder),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      item.symbol.substring(0, 1), // Initials
                      style: const TextStyle(
                        color: AppColors.darkTextSecondary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.symbol,
                          style: const TextStyle(
                            color: AppColors.darkTextPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                color: AppColors.darkTextSecondary,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Change
                  Text(
                    '${item.isPositive ? '↗' : '↘'} ${item.changePercent.abs().toStringAsFixed(2)}%',
                    style: TextStyle(
                      color: item.isPositive ? AppColors.premiumAccentGreen : AppColors.premiumAccentRed,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
