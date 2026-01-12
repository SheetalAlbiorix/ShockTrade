import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/stock_detail/domain/models.dart';
import 'package:shock_app/features/stock_detail/presentation/widgets/glass_card.dart';

/// "Markets Today" Card matching the reference design
class MarketsTodayCard extends StatelessWidget {
  final TradingInfo tradingInfo;
  final double currentPrice;
  final bool isPositive;

  const MarketsTodayCard({
    super.key,
    required this.tradingInfo,
    required this.currentPrice,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Markets Today',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),

            // 1. OHLC Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildColumnItem('Open', tradingInfo.open),
                _buildColumnItem('High', tradingInfo.high),
                _buildColumnItem('Low', tradingInfo.low),
                _buildColumnItem('Prev. Close', tradingInfo.prevClose,
                    isEnd: true),
              ],
            ),
            const SizedBox(height: 24),

            // 2. Range Slider
            _buildRangeSlider(),
            const SizedBox(height: 8),

            // 3. Downside/Upside Labels
            Builder(builder: (context) {
              double low =
                  double.tryParse(tradingInfo.low.replaceAll(',', '')) ?? 0;
              double high =
                  double.tryParse(tradingInfo.high.replaceAll(',', '')) ?? 0;

              double downside = 0.0;
              double upside = 0.0;

              if (currentPrice != 0) {
                downside = ((currentPrice - low) / currentPrice) * 100;
                upside = ((high - currentPrice) / currentPrice) * 100;
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '↘ ${downside.toStringAsFixed(2)}% down side',
                    style: const TextStyle(
                      color: AppColors.bearishRed,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'up side ${upside.toStringAsFixed(2)}% ↗',
                    style: const TextStyle(
                      color: AppColors.bullishGreen,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 24),

            // 4. Details Grid
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Volume', tradingInfo.volume),
                      const SizedBox(height: 12),
                      _buildDetailRow(
                          'Lower Circuit', tradingInfo.lowerCircuit),
                      const SizedBox(height: 12),
                      // Last Traded
                      const Text(
                        'Last Traded',
                        style: TextStyle(
                          color: AppColors.darkTextSecondary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _buildDetailRow('Quantity', tradingInfo.lastTradedQty,
                          valueSize: 13),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Avg Price', tradingInfo.avgPrice),
                      const SizedBox(height: 12),
                      _buildDetailRow(
                          'Upper Circuit', tradingInfo.upperCircuit),
                      const SizedBox(
                          height: 30), // Align with Last Traded Quantity
                      _buildDetailRow('Time', tradingInfo.lastTradedTime,
                          valueSize: 13),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRangeSlider() {
    double low = double.tryParse(tradingInfo.low.replaceAll(',', '')) ?? 0;
    double high = double.tryParse(tradingInfo.high.replaceAll(',', '')) ?? 100;
    // Slider uses Low to High range.
    if (low == 0) low = currentPrice * 0.95;
    if (high == 0) high = currentPrice * 1.05;

    // Normalize current price 0..1
    double progress = 0.5;
    if (high > low) {
      progress = (currentPrice - low) / (high - low);
    }
    progress = progress.clamp(0.0, 1.0);

    return Column(
      children: [
        // Label Bubble
        LayoutBuilder(builder: (context, constraints) {
          return Align(
            alignment: Alignment(progress * 2 - 1, 0), // Map 0..1 to -1..1
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: AppColors.primaryGold, // Approximating the orange/yellow
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                currentPrice.toStringAsFixed(2),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          );
        }),

        Stack(
          alignment: Alignment.centerLeft,
          children: [
            // Bar Background
            Container(
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                gradient: const LinearGradient(
                  colors: [
                    AppColors.bearishRed,
                    AppColors.bullishGreen
                  ], // Red to Green
                ),
              ),
            ),
            // Knobs (Indicators for Low/High/PrevClose?) -> Image just has one knob at current price
            Align(
              alignment: Alignment(progress * 2 - 1, 0),
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primaryGold, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                      )
                    ]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(tradingInfo.low,
                style: const TextStyle(color: Colors.white, fontSize: 12)),
            Text(tradingInfo.high,
                style: const TextStyle(color: Colors.white, fontSize: 12)),
          ],
        )
      ],
    );
  }

  Widget _buildColumnItem(String label, String value, {bool isEnd = false}) {
    return Column(
      crossAxisAlignment:
          isEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.darkTextSecondary,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {double valueSize = 14}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.darkTextSecondary,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: valueSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
