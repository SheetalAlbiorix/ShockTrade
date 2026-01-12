import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/watchlist/application/providers/watchlist_provider.dart';
import 'package:shock_app/features/watchlist/presentation/widgets/watchlist_stock_card.dart';

class TrendingStocksPage extends ConsumerWidget {
  const TrendingStocksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // reusing master provider for trending data
    final stocks = ref.watch(masterStocksProvider);
    
    // Sort by absolute change percent to simulate "Trending" (high volatility)
    final trendingStocks = List.of(stocks)
      ..sort((a, b) => b.changePercent.abs().compareTo(a.changePercent.abs()));

    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.premiumDarkGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.darkTextPrimary),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Trending in India',
             style: TextStyle(
              color: AppColors.darkTextPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: trendingStocks.length,
          itemBuilder: (context, index) {
            final stock = trendingStocks[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: WatchlistStockCard(
                stock: stock,
                onTap: () => context.push('/stock-detail?symbol=${stock.symbol}&name=${stock.name}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
