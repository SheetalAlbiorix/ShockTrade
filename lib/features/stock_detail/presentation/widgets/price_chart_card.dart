import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/stock_detail/domain/models.dart';

/// Price chart card with range selector
class PriceChartCard extends StatelessWidget {
  final List<ChartPoint> chartPoints;
  final StockRange selectedRange;
  final Function(StockRange) onRangeChanged;

  const PriceChartCard({
    super.key,
    required this.chartPoints,
    required this.selectedRange,
    required this.onRangeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.darkCardBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            // Chart area
            SizedBox(
              height: 200,
              child: CustomPaint(
                size: const Size(double.infinity, 200),
                painter: _ChartPainter(chartPoints: chartPoints),
              ),
            ),
            const SizedBox(height: 16),
            // Range selector
            _RangeSelector(
              selectedRange: selectedRange,
              onRangeChanged: onRangeChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class _RangeSelector extends StatelessWidget {
  final StockRange selectedRange;
  final Function(StockRange) onRangeChanged;

  const _RangeSelector({
    required this.selectedRange,
    required this.onRangeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: StockRange.values.map((range) {
        final isSelected = range == selectedRange;
        return GestureDetector(
          onTap: () => onRangeChanged(range),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.navActiveColor : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              range.label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.darkTextSecondary,
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _ChartPainter extends CustomPainter {
  final List<ChartPoint> chartPoints;

  _ChartPainter({required this.chartPoints});

  @override
  void paint(Canvas canvas, Size size) {
    if (chartPoints.isEmpty) return;

    final paint = Paint()
      ..color = const Color(0xFFFFB800).withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = const Color(0xFFFFB800)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Find min and max prices
    double minPrice = chartPoints.first.price;
    double maxPrice = chartPoints.first.price;
    for (final point in chartPoints) {
      if (point.price < minPrice) minPrice = point.price;
      if (point.price > maxPrice) maxPrice = point.price;
    }

    final priceRange = maxPrice - minPrice;
    if (priceRange == 0) return;

    // Create path for area chart
    final path = Path();
    final linePath = Path();

    for (int i = 0; i < chartPoints.length; i++) {
      final x = (i / (chartPoints.length - 1)) * size.width;
      final normalizedPrice = (chartPoints[i].price - minPrice) / priceRange;
      final y = size.height - (normalizedPrice * size.height);

      if (i == 0) {
        path.moveTo(x, size.height);
        path.lineTo(x, y);
        linePath.moveTo(x, y);
      } else {
        path.lineTo(x, y);
        linePath.lineTo(x, y);
      }
    }

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
