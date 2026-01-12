import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';

class MostActiveSection extends StatelessWidget {
  const MostActiveSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data
    final activeItems = [
      _ActiveItem(symbol: 'RELIANCE', name: 'Reliance Industries', price: 2980.15, change: 1.15, isPositive: true),
      _ActiveItem(symbol: 'TATAMOTORS', name: 'Tata Motors Ltd', price: 980.50, change: -0.45, isPositive: false),
      _ActiveItem(symbol: 'HDFCBANK', name: 'HDFC Bank', price: 1650.00, change: -1.2, isPositive: false),
      _ActiveItem(symbol: 'SBIN', name: 'State Bank of India', price: 750.30, change: 2.1, isPositive: true),
      _ActiveItem(symbol: 'ICICIBANK', name: 'ICICI Bank', price: 1080.40, change: 0.5, isPositive: true),
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Most Active',
              style: TextStyle(
                color: AppColors.darkTextPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // List
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: activeItems.length,
            separatorBuilder: (context, index) => Divider(color: AppColors.premiumCardBorder.withOpacity(0.5), height: 16),
            itemBuilder: (context, index) {
              final item = activeItems[index];
              return InkWell(
                onTap: () => context.push('/stock-detail?symbol=${item.symbol}&name=${item.name}'),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      // Icon
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.premiumSurface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.premiumCardBorder),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          item.symbol.substring(0, 3), 
                          style: const TextStyle(
                            color: AppColors.darkTextSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      
                      // Name
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.symbol,
                              style: const TextStyle(
                                color: AppColors.darkTextPrimary,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
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
                      ),

                      // Price & Change
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '₹${item.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: AppColors.darkTextPrimary,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${item.isPositive ? '+' : ''}${item.change}%',
                            style: TextStyle(
                              color: item.isPositive ? AppColors.premiumAccentGreen : AppColors.premiumAccentRed,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ActiveItem {
  final String symbol;
  final String name;
  final double price;
  final double change;
  final bool isPositive;

  _ActiveItem({
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
    required this.isPositive,
  });
}
