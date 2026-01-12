import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';

class TrendingStocksSection extends StatelessWidget {
  const TrendingStocksSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final trendingItems = [
      _TrendingItem(symbol: 'ADANIENT', name: 'Adani Enterprises', price: 3150.45, change: 4.5, isPositive: true),
      _TrendingItem(symbol: 'ZOMATO', name: 'Zomato Ltd', price: 148.20, change: -1.2, isPositive: false),
      _TrendingItem(symbol: 'TATASTEEL', name: 'Tata Steel', price: 154.60, change: 0.8, isPositive: true),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Trending in India',
                style: TextStyle(
                  color: AppColors.darkTextPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () => context.push('/trending'),
                child: Row(
                  children: [
                    const Text(
                      'View all',
                      style: TextStyle(
                        color: AppColors.premiumAccentBlue,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_forward_ios, size: 10, color: AppColors.premiumAccentBlue),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Horizontal List
        SizedBox(
          height: 140, // Height for cards
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: trendingItems.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = trendingItems[index];
              return InkWell(
                onTap: () => context.push('/stock-detail?symbol=${item.symbol}&name=${item.name}'),
                child: Container(
                  width: 160,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.premiumCardBackground,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.premiumCardBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Top Row: Icon + Badge
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: item.isPositive ? AppColors.premiumAccentGreen.withOpacity(0.2) : AppColors.premiumAccentRed.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: (item.isPositive ? AppColors.premiumAccentGreen : AppColors.premiumAccentRed).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '${item.isPositive ? '+' : ''}${item.change}%',
                              style: TextStyle(
                                color: item.isPositive ? AppColors.premiumAccentGreen : AppColors.premiumAccentRed,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      // Middle: Names
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.symbol,
                            style: const TextStyle(
                              color: AppColors.darkTextPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            item.name,
                            style: const TextStyle(
                              color: AppColors.darkTextSecondary,
                              fontSize: 10,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),

                      // Bottom: Price
                      Text(
                        '₹${item.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: AppColors.darkTextPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TrendingItem {
  final String symbol;
  final String name;
  final double price;
  final double change;
  final bool isPositive;

  _TrendingItem({
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
    required this.isPositive,
  });
}
