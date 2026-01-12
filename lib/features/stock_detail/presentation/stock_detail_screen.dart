import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/stock_detail/application/stock_detail_controller.dart';
import 'package:shock_app/features/stock_detail/presentation/widgets/candlestick_chart.dart';
import 'package:shock_app/features/stock_detail/presentation/widgets/glass_card.dart';
import 'package:shock_app/features/stock_detail/presentation/widgets/market_overview_grid.dart';
import 'package:shock_app/features/stock_detail/presentation/widgets/news_card.dart';
import 'package:shock_app/features/stock_detail/presentation/widgets/time_filter_tabs.dart';
import 'package:shock_app/features/stock_detail/presentation/widgets/week_range_indicator.dart';

/// Stock detail screen with modern HTML-inspired design
class StockDetailScreen extends ConsumerWidget {
  final String symbol;
  final String name;

  const StockDetailScreen({
    super.key,
    required this.symbol,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(stockDetailControllerProvider(symbol));
    final controller = ref.read(stockDetailControllerProvider(symbol).notifier);

    final isPositive = state.priceChange >= 0;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: CustomScrollView(
        clipBehavior: Clip.hardEdge,
        slivers: [
          // Header
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBackground,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.transparent,
            forceElevated: false,
            toolbarHeight: kToolbarHeight,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.5),
              child: Container(
                color: AppColors.glassBorder,
                height: 0.5,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: AppColors.darkTextPrimary),
              onPressed: () => context.pop(),
            ),
            title: Column(
              children: [
                Text(
                  state.symbol,
                  style: const TextStyle(
                    color: AppColors.darkTextPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.glassBackground,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'NSE',
                    style: TextStyle(
                      color: AppColors.darkTextSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon:
                    const Icon(Icons.search, color: AppColors.darkTextPrimary),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  state.isInWatchlist ? Icons.star : Icons.star_border,
                  color: state.isInWatchlist
                      ? AppColors.primaryBlue
                      : AppColors.darkTextPrimary,
                ),
                onPressed: controller.toggleWatchlist,
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price Section
                  const Text(
                    'CURRENT PRICE',
                    style: TextStyle(
                      color: AppColors.darkTextSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '₹${state.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: AppColors.darkTextPrimary,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isPositive
                              ? AppColors.bullishGreen.withOpacity(0.1)
                              : AppColors.bearishRed.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isPositive
                                  ? Icons.trending_up
                                  : Icons.trending_down,
                              color: isPositive
                                  ? AppColors.bullishGreen
                                  : AppColors.bearishRed,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${isPositive ? '+' : ''}${state.priceChange.toStringAsFixed(2)} (${state.percentChange.toStringAsFixed(2)}%)',
                              style: TextStyle(
                                color: isPositive
                                    ? AppColors.bullishGreen
                                    : AppColors.bearishRed,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Last updated: 15:30:00 IST',
                    style: TextStyle(
                      color: AppColors.darkTextSecondary,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Time Filter Tabs
                  TimeFilterTabs(
                    selectedRange: state.range,
                    onRangeChanged: controller.changeRange,
                  ),

                  const SizedBox(height: 16),

                  // Candlestick Chart
                  CandlestickChart(chartPoints: state.chartPoints),

                  // X-axis labels
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('09:15',
                            style: TextStyle(
                                color: AppColors.darkTextSecondary,
                                fontSize: 10)),
                        Text('11:00',
                            style: TextStyle(
                                color: AppColors.darkTextSecondary,
                                fontSize: 10)),
                        Text('13:00',
                            style: TextStyle(
                                color: AppColors.darkTextSecondary,
                                fontSize: 10)),
                        Text('15:30',
                            style: TextStyle(
                                color: AppColors.darkTextSecondary,
                                fontSize: 10)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Market Overview
                  const Text(
                    'Market Overview',
                    style: TextStyle(
                      color: AppColors.darkTextPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  MarketOverviewGrid(
                    open: state.tradingInfo.open,
                    high: state.tradingInfo.high,
                    low: state.tradingInfo.low,
                    prevClose: state.tradingInfo.prevClose,
                    volume: '12.45L',
                    marketCap: state.fundamentals.marketCap,
                  ),

                  const SizedBox(height: 24),

                  // 52 Week Range
                  WeekRangeIndicator(
                    low: 2000.00,
                    high: 2800.00,
                    current: state.price,
                  ),

                  const SizedBox(height: 24),

                  // Fundamentals
                  const Text(
                    'Fundamentals',
                    style: TextStyle(
                      color: AppColors.darkTextPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GlassCard(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildFundamentalItem(
                            'P/E RATIO', state.fundamentals.peRatio),
                        Container(
                            width: 1, height: 40, color: AppColors.glassBorder),
                        _buildFundamentalItem('P/B RATIO', '2.1'),
                        Container(
                            width: 1, height: 40, color: AppColors.glassBorder),
                        _buildFundamentalItem(
                          'DIV YIELD',
                          state.fundamentals.dividendYield,
                          valueColor: AppColors.bullishGreen,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // News Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Latest News',
                        style: TextStyle(
                          color: AppColors.darkTextPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'View All',
                          style: TextStyle(
                            color: AppColors.primaryBlue,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const NewsCard(
                    title:
                        'Reliance Industries to acquire major stake in solar energy startup, boosting green portfolio.',
                    source: 'Mint',
                    timeAgo: '1 hour ago',
                  ),
                  const NewsCard(
                    title:
                        'Sensex, Nifty open higher led by Reliance and IT stocks; global cues positive.',
                    source: 'Economic Times',
                    timeAgo: '3 hours ago',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFundamentalItem(String label, String value,
      {Color? valueColor}) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.darkTextSecondary,
            fontSize: 10,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? AppColors.darkTextPrimary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
