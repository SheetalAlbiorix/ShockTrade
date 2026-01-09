import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';

class TopMoversSection extends StatefulWidget {
  const TopMoversSection({super.key});

  @override
  State<TopMoversSection> createState() => _TopMoversSectionState();
}

class _TopMoversSectionState extends State<TopMoversSection> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Movers',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.darkTextPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.premiumSurface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.premiumCardBorder),
                ),
                child: Row(
                  children: [
                    _buildTab('Gainers', 0),
                    _buildTab('Losers', 1),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.premiumCardBackground,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.premiumCardBorder),
          ),
          child: Column(
            children: [
              if (_selectedIndex == 0) ...[
                 _buildStockItem(
                  'RELIANCE', 'NSE', '₹ 2,456.15', '+1.85%', true, 'https://logo.clearbit.com/reliance.com'),
                 _buildDivider(),
                 _buildStockItem(
                  'TATASTEEL', 'BSE', '₹ 124.50', '+2.40%', true, 'https://logo.clearbit.com/tatasteel.com'),
                 _buildDivider(),
                 _buildStockItem(
                  'ADANIENT', 'NSE', '₹ 2,510.00', '+0.95%', true, 'https://logo.clearbit.com/adani.com'),
              ] else ...[
                 _buildStockItem(
                  'INFY', 'NSE', '₹ 1,380.45', '-0.45%', false, 'https://logo.clearbit.com/infosys.com'),
                 _buildDivider(),
                 _buildStockItem(
                  'WIPRO', 'NSE', '₹ 402.10', '-1.20%', false, 'https://logo.clearbit.com/wipro.com'),
                 _buildDivider(),
                 _buildStockItem(
                  'HCLTECH', 'NSE', '₹ 1,120.30', '-0.90%', false, 'https://logo.clearbit.com/hcltech.com'),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTab(String title, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.premiumCardBorder : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColors.darkTextPrimary : AppColors.darkTextSecondary,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      color: AppColors.premiumCardBorder,
      height: 1,
    );
  }

  Widget _buildStockItem(String name, String exchange, String price, String change, bool isPositive, String logoUrl) {
    return InkWell(
      onTap: () => context.go('/stock-detail?symbol=$name&name=$name'),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.network(
                  logoUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.business,
                      color: AppColors.darkTextSecondary,
                      size: 24,
                    );
                  },
                ),
              ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: AppColors.darkTextPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    exchange,
                    style: const TextStyle(
                      color: AppColors.darkTextSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    color: AppColors.darkTextPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  change,
                  style: TextStyle(
                    color: isPositive ? AppColors.premiumAccentGreen : AppColors.premiumAccentRed,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
