import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/stocks/application/top_movers_controller.dart';
import 'package:shock_app/features/stock_detail/domain/models.dart';
import 'package:shock_app/core/utils/stock_logo_mapper.dart';

class TopMoversSection extends ConsumerStatefulWidget {
  const TopMoversSection({super.key});

  @override
  ConsumerState<TopMoversSection> createState() => _TopMoversSectionState();
}

class _TopMoversSectionState extends ConsumerState<TopMoversSection> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final topMoversState = ref.watch(topMoversProvider);

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
          child: topMoversState.when(
            data: (stocks) {
              final filteredStocks = stocks
                  .where((s) {
                    if (_selectedTabIndex == 0) return s.isPositive;
                    return !s.isPositive;
                  })
                  .take(4)
                  .toList();

              if (filteredStocks.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      _selectedTabIndex == 0
                          ? 'No gainers right now'
                          : 'No losers right now',
                      style:
                          const TextStyle(color: AppColors.darkTextSecondary),
                    ),
                  ),
                );
              }

              return Column(
                children: [
                  for (int i = 0; i < filteredStocks.length; i++) ...[
                    _buildStockItem(context, filteredStocks[i]),
                    if (i < filteredStocks.length - 1) _buildDivider(),
                  ]
                ],
              );
            },
            loading: () => const Center(
                child: Padding(
              padding: EdgeInsets.all(20.0),
              child:
                  CircularProgressIndicator(color: AppColors.premiumAccentBlue),
            )),
            error: (e, st) => Center(
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Failed to load data',
                  style: TextStyle(color: AppColors.premiumAccentRed)),
            )),
          ),
        ),
      ],
    );
  }

  Widget _buildTab(String title, int index) {
    final isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.premiumCardBorder : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected
                ? AppColors.darkTextPrimary
                : AppColors.darkTextSecondary,
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

  Widget _buildStockItem(BuildContext context, StockDetailState stock) {
    // Use API image if available, else fallback to StockLogoMapper
    String logoUrl = stock.imageUrl ??
        StockLogoMapper.getLogoUrl(stock.symbol.replaceAll('.NS', ''));

    // Exchange logic
    String exchange = 'NSE';

    return InkWell(
      onTap: () => context.push(
          '/stock-detail?symbol=${stock.symbol}&name=${stock.companyName}'),
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
                  return const Icon(
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
                    stock.symbol.replaceAll('.NS', ''),
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
                  '₹ ${stock.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppColors.darkTextPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${stock.isPositive ? '+' : ''}${stock.percentChange.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: stock.isPositive
                        ? AppColors.premiumAccentGreen
                        : AppColors.premiumAccentRed,
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
