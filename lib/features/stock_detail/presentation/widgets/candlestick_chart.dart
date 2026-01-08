import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/stock_detail/domain/models.dart';

/// Simple candlestick chart widget
class CandlestickChart extends StatelessWidget {
  final List<ChartPoint> chartPoints;

  const CandlestickChart({
    super.key,
    required this.chartPoints,
  });

  @override
  Widget build(BuildContext context) {
    if (chartPoints.isEmpty) {
      return const SizedBox(
        height: 280,
        child: Center(
          child: Text(
            'No chart data available',
            style: TextStyle(color: AppColors.darkTextSecondary),
          ),
        ),
      );
    }

    return SizedBox(
      height: 280,
      child: CustomPaint(
        painter: _CandlestickPainter(chartPoints),
        child: Container(),
      ),
    );
  }
}

class _CandlestickPainter extends CustomPainter {
  final List<ChartPoint> points;

  _CandlestickPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    // Find min and max prices
    double minPrice =
        points.map((p) => p.price).reduce((a, b) => a < b ? a : b);
    double maxPrice =
        points.map((p) => p.price).reduce((a, b) => a > b ? a : b);
    final priceRange = maxPrice - minPrice;

    // Draw grid lines
    _drawGridLines(canvas, size);

    // Draw candlesticks
    final candleWidth = (size.width / points.length) * 0.6;
    final spacing = size.width / points.length;

    for (int i = 0; i < points.length; i++) {
      final x = i * spacing + spacing / 2;
      final point = points[i];

      // Determine if bullish or bearish (compare with previous)
      final isBullish = i == 0 || point.price >= points[i - 1].price;

      // Normalize price to canvas height
      final normalizedPrice = (point.price - minPrice) / priceRange;
      final y = size.height - (normalizedPrice * size.height);

      // Draw candle
      _drawCandle(
        canvas,
        x,
        y,
        candleWidth,
        isBullish,
      );
    }

    // Draw moving average line
    _drawMovingAverage(canvas, size, minPrice, priceRange);
  }

  void _drawGridLines(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (int i = 0; i <= 4; i++) {
      final y = (size.height / 4) * i;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  void _drawCandle(
      Canvas canvas, double x, double y, double width, bool isBullish) {
    final color = isBullish ? AppColors.chartGreen : AppColors.chartRed;

    // Draw wick (line)
    final wickPaint = Paint()
      ..color = color
      ..strokeWidth = 1;

    final wickHeight = 20.0;
    canvas.drawLine(
      Offset(x, y - wickHeight / 2),
      Offset(x, y + wickHeight / 2),
      wickPaint,
    );

    // Draw body (rectangle)
    final bodyPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final bodyHeight = 12.0;
    final rect = Rect.fromCenter(
      center: Offset(x, y),
      width: width,
      height: bodyHeight,
    );
    canvas.drawRect(rect, bodyPaint);
  }

  void _drawMovingAverage(
      Canvas canvas, Size size, double minPrice, double priceRange) {
    if (points.length < 2) return;

    final paint = Paint()
      ..color = AppColors.chartBlue.withOpacity(0.8)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path();
    final spacing = size.width / points.length;

    for (int i = 0; i < points.length; i++) {
      final x = i * spacing + spacing / 2;
      final normalizedPrice = (points[i].price - minPrice) / priceRange;
      final y = size.height - (normalizedPrice * size.height);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
