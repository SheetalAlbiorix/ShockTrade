import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/stocks/domain/models/market_stock.dart';
import 'package:shock_app/features/stocks/presentation/providers/indices_provider.dart';
import 'package:shock_app/core/widgets/error_placeholder.dart';

class MarketIndicesSection extends ConsumerWidget {
  const MarketIndicesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nseAsync = ref.watch(nseMostActiveProvider);
    final bseAsync = ref.watch(bseMostActiveProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Market Indices',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.darkTextPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextButton(
                onPressed: () => context.push('/market-indices'),
                child: Text(
                  'View All',
                  style: TextStyle(color: AppColors.premiumAccentBlue),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 150,
          child: nseAsync.when(
            data: (nseStocks) {
              final bseStocks = bseAsync.value ?? [];
              
              // Combine or pick specific items for the home screen
              // For demonstration, taking first 2 from NSE and first 1 from BSE
              final displayList = [
                ...nseStocks.take(2),
                ...bseStocks.take(1),
              ];

              if (displayList.isEmpty) {
                return Center(
                  child: Text(
                    'No data available',
                    style: TextStyle(color: AppColors.darkTextSecondary),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: displayList.length,
                itemBuilder: (context, index) {
                  final stock = displayList[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: _buildIndexCard(
                      context,
                      name: stock.symbol,
                      value: stock.lastPrice.toStringAsFixed(2),
                      change: '${stock.pChange >= 0 ? '+' : ''}${stock.pChange.toStringAsFixed(2)}%',
                      isPositive: stock.pChange >= 0,
                      onTap: () => context.push(
                        '/stock-detail?symbol=${stock.symbol}&name=${stock.name}&price=${stock.lastPrice}&pChange=${stock.pChange}',
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _buildShimmerCard(),
              ),
            ),
            error: (err, stack) => ErrorPlaceholder(
              height: 150,
              onRetry: () => ref.refresh(nseMostActiveProvider),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerCard() {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: AppColors.premiumCardBackground.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.premiumCardBorder),
      ),
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(AppColors.premiumAccentBlue),
        ),
      ),
    );
  }

  Widget _buildIndexCard(
    BuildContext context, {
    required String name,
    required String value,
    required String change,
    required bool isPositive,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.premiumCardBackground,
          borderRadius: BorderRadius.circular(20),
          border:
              Border.all(color: AppColors.premiumCardBorder.withOpacity(0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.darkTextSecondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: (isPositive
                            ? AppColors.premiumAccentGreen
                            : AppColors.premiumAccentRed)
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    change,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: isPositive
                              ? AppColors.premiumAccentGreen
                              : AppColors.premiumAccentRed,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '₹$value',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.darkTextPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
            ),
            const Spacer(),
            // Chart placeholder
            SizedBox(
              height: 44,
              width: double.infinity,
              child: CustomPaint(
                painter: _IndexChartPainter(isPositive: isPositive),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IndexChartPainter extends CustomPainter {
  final bool isPositive;

  _IndexChartPainter({required this.isPositive});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isPositive ? AppColors.premiumAccentGreen : AppColors.premiumAccentRed
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    
    final verticalPadding = size.height * 0.15;
    final contentHeight = size.height - (verticalPadding * 2);
    
    // Draw sparkline with padding
    if (isPositive) {
       path.moveTo(0, size.height - verticalPadding);
       path.quadraticBezierTo(size.width * 0.3, size.height - verticalPadding, size.width * 0.5, verticalPadding + contentHeight * 0.4);
       path.quadraticBezierTo(size.width * 0.7, verticalPadding + contentHeight * 0.1, size.width, verticalPadding);
    } else {
       path.moveTo(0, verticalPadding + contentHeight * 0.3);
       path.quadraticBezierTo(size.width * 0.3, verticalPadding + contentHeight * 0.3, size.width * 0.5, verticalPadding + contentHeight * 0.7);
       path.quadraticBezierTo(size.width * 0.7, size.height - verticalPadding, size.width, size.height - verticalPadding);
    }

    canvas.drawPath(path, paint);
    
    // Gradient fill
    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
      
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
         (isPositive ? AppColors.premiumAccentGreen : AppColors.premiumAccentRed).withOpacity(0.2),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;
      
   canvas.drawPath(fillPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
