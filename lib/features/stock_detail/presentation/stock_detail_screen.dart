import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/features/stock_detail/application/stock_detail_controller.dart';
import 'package:shock_app/features/stock_detail/presentation/widgets/action_buttons.dart';
import 'package:shock_app/features/stock_detail/presentation/widgets/info_section.dart';
import 'package:shock_app/features/stock_detail/presentation/widgets/price_chart_card.dart';
import 'package:shock_app/features/stock_detail/presentation/widgets/price_header.dart';
import 'package:shock_app/features/stock_detail/presentation/widgets/stats_cards.dart';

/// Stock detail screen for AAPL with dark iOS-style design
class StockDetailScreen extends ConsumerWidget {
  const StockDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(stockDetailControllerProvider);
    final controller = ref.read(stockDetailControllerProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          state.symbol,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              state.isInWatchlist ? Icons.star : Icons.star_border,
              color:
                  state.isInWatchlist ? const Color(0xFF00E0FF) : Colors.white,
            ),
            onPressed: controller.toggleWatchlist,
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            // Price header
            PriceHeader(
              price: state.price,
              priceChange: state.priceChange,
              percentChange: state.percentChange,
            ),

            // Action buttons
            ActionButtons(
              isInWatchlist: state.isInWatchlist,
              hasAlert: state.hasAlert,
              onWatchlistTap: controller.toggleWatchlist,
              onAlertTap: controller.toggleAlert,
            ),

            // Stats cards
            const StatsCards(),

            const SizedBox(height: 8),

            // Price chart
            PriceChartCard(
              chartPoints: state.chartPoints,
              selectedRange: state.range,
              onRangeChanged: controller.changeRange,
            ),

            const SizedBox(height: 16),

            // Fundamentals section
            InfoSection(
              title: 'Fundamentals',
              items: [
                InfoItem(
                    label: 'Market Cap', value: state.fundamentals.marketCap),
                InfoItem(label: 'P/E Ratio', value: state.fundamentals.peRatio),
                InfoItem(label: 'EPS (TTM)', value: state.fundamentals.eps),
                InfoItem(
                    label: 'Dividend Yield',
                    value: state.fundamentals.dividendYield),
                InfoItem(label: 'Beta', value: state.fundamentals.beta),
                InfoItem(
                    label: 'Revenue (TTM)', value: state.fundamentals.revenue),
              ],
            ),

            const SizedBox(height: 16),

            // Trading Information section
            InfoSection(
              title: 'Trading Information',
              items: [
                InfoItem(label: 'Open', value: state.tradingInfo.open),
                InfoItem(label: 'High', value: state.tradingInfo.high),
                InfoItem(label: 'Low', value: state.tradingInfo.low),
                InfoItem(
                    label: 'Prev. Close', value: state.tradingInfo.prevClose),
                InfoItem(label: 'Bid', value: state.tradingInfo.bid),
                InfoItem(label: 'Ask', value: state.tradingInfo.ask),
              ],
            ),

            const SizedBox(height: 24),

            // Footer
            const Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: Text(
                'Made with Visily',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF8E8E93),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
