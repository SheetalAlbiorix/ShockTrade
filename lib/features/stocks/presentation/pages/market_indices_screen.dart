import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/stocks/presentation/providers/indices_provider.dart';
import 'package:shock_app/features/stocks/domain/models/market_stock.dart';
import 'package:shock_app/core/utils/stock_logo_mapper.dart';
import 'package:shock_app/core/widgets/error_placeholder.dart';

class MarketIndicesScreen extends StatelessWidget {
  const MarketIndicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.premiumBackgroundDark,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.darkTextPrimary),
            onPressed: () => context.pop(),
          ),
          title: Text(
            'Market Indices',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.darkTextPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          bottom: const TabBar(
            indicatorColor: AppColors.premiumAccentBlue,
            labelColor: AppColors.premiumAccentBlue,
            unselectedLabelColor: AppColors.darkTextSecondary,
            tabs: [
              Tab(text: 'NSE'),
              Tab(text: 'BSE'),
              Tab(text: 'Trending'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MarketStocksList(provider: nseMostActiveProvider, exchange: 'NSE'),
            MarketStocksList(provider: bseMostActiveProvider, exchange: 'BSE'),
            MarketStocksList(provider: trendingStocksProvider, exchange: 'Market'),
          ],
        ),
      ),
    );
  }
}

class MarketStocksList extends ConsumerWidget {
  final FutureProvider<List<MarketStock>> provider;
  final String exchange;

  const MarketStocksList({
    super.key,
    required this.provider,
    required this.exchange,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stocksAsync = ref.watch(provider);

    return stocksAsync.when(
      data: (stocks) {
        if (stocks.isEmpty) {
          return Center(
            child: Text(
              'No data available',
              style: TextStyle(color: AppColors.darkTextSecondary),
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: stocks.length,
          separatorBuilder: (context, index) => const Divider(
            color: AppColors.premiumCardBorder,
            height: 1,
          ),
          itemBuilder: (context, index) {
            final stock = stocks[index];
            return _buildStockItem(context, stock, exchange);
          },
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(AppColors.premiumAccentBlue),
        ),
      ),
      error: (err, stack) => Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ErrorPlaceholder(
            message: 'Unable to load ${exchange}',
            onRetry: () => ref.refresh(provider),
          ),
        ),
      ),
    );
  }

  Widget _buildStockItem(BuildContext context, MarketStock stock, String exchange) {
    String logoUrl = StockLogoMapper.getLogoUrl(stock.symbol.replaceAll('.NS', ''));

    return InkWell(
      onTap: () => context.push(
          '/stock-detail?symbol=${stock.symbol}&name=${stock.name}&price=${stock.lastPrice}&pChange=${stock.pChange}'),
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
                    stock.symbol,
                    style: const TextStyle(
                      color: AppColors.darkTextPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    stock.name,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹${stock.lastPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppColors.darkTextPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${stock.pChange >= 0 ? '+' : ''}${stock.pChange.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: stock.pChange >= 0
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
