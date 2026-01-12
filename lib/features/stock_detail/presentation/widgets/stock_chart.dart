import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/stock_detail/domain/models.dart';
import 'dart:math';

/// Candlestick Chart with Touch Interaction
class StockChart extends StatefulWidget {
  final List<ChartPoint> chartPoints;
  final double prevClose;

  const StockChart({
    super.key,
    required this.chartPoints,
    required this.prevClose,
  });

  @override
  State<StockChart> createState() => _StockChartState();
}

class _StockChartState extends State<StockChart> {
  ChartPoint? _selectedPoint;
  // Removed unused _touchPosition

  void _handleTouch(Offset localPosition, double width) {
    if (widget.chartPoints.isEmpty) return;

    // Total minutes in trading day = 375
    const int totalTradingMinutes = 375;
    final double normalizedX = (localPosition.dx / width).clamp(0.0, 1.0);
    final int targetMinute = (normalizedX * totalTradingMinutes).round();

    final firstPoint = widget.chartPoints.first;
    final marketOpen = DateTime(firstPoint.timestamp.year,
        firstPoint.timestamp.month, firstPoint.timestamp.day, 9, 15);

    ChartPoint? closest;
    int minDiff = 10000;

    for (var point in widget.chartPoints) {
      final pointMinute = point.timestamp.difference(marketOpen).inMinutes;
      final diff = (pointMinute - targetMinute).abs();
      if (diff < minDiff) {
        minDiff = diff;
        closest = point;
      }
    }

    setState(() {
      _selectedPoint = closest;
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedPoint = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.chartPoints.isEmpty) {
      return const SizedBox(
        height: 280,
        child: Center(
          child: CircularProgressIndicator(color: AppColors.primaryBlue),
        ),
      );
    }

    final double currentPrice = widget.chartPoints.last.price;
    final bool isBullish = currentPrice >= widget.prevClose;
    final Color chartColor =
        isBullish ? AppColors.bullishGreen : AppColors.bearishRed;

    return GestureDetector(
      onHorizontalDragUpdate: (details) =>
          _handleTouch(details.localPosition, context.size!.width),
      onHorizontalDragStart: (details) =>
          _handleTouch(details.localPosition, context.size!.width),
      onHorizontalDragEnd: (_) => _clearSelection(),
      onTapUp: (details) =>
          _handleTouch(details.localPosition, context.size!.width),
      onTapDown: (details) =>
          _handleTouch(details.localPosition, context.size!.width),
      onTapCancel: () => _clearSelection(),
      child: SizedBox(
        height: 280,
        width: double.infinity,
        child: CustomPaint(
          painter: _AreaChartPainter(
            points: widget.chartPoints,
            color: chartColor,
            prevClose: widget.prevClose,
            selectedPoint: _selectedPoint,
          ),
        ),
      ),
    );
  }
}

class _AreaChartPainter extends CustomPainter {
  final List<ChartPoint> points;
  final Color color;
  final double prevClose;
  final ChartPoint? selectedPoint;

  _AreaChartPainter({
    required this.points,
    required this.color,
    required this.prevClose,
    this.selectedPoint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    // 1. Calculate Min/Max for Scaling
    double minPrice =
        points.map((p) => p.low ?? p.price).reduce((a, b) => a < b ? a : b);
    double maxPrice =
        points.map((p) => p.high ?? p.price).reduce((a, b) => a > b ? a : b);

    // Include prevClose in range
    if (prevClose < minPrice) minPrice = prevClose;
    if (prevClose > maxPrice) maxPrice = prevClose;

    final double range = maxPrice - minPrice;
    final double padding = range * 0.1;
    final double effectiveMin = minPrice - padding;
    final double effectiveMax = maxPrice + padding;
    final double effectiveRange = effectiveMax - effectiveMin;

    if (effectiveRange == 0) return;

    // 2. Draw Candles
    final double candleWidth = size.width / points.length;
    final double candleSpacing = 2.0; // Space between candles
    final double bodyWidth = (candleWidth - candleSpacing).clamp(2.0, 10.0);

    const int totalTradingMinutes = 375;
    final firstPoint = points.first;
    final marketOpen = DateTime(firstPoint.timestamp.year,
        firstPoint.timestamp.month, firstPoint.timestamp.day, 9, 15);

    double selectedX = -1.0;
    double selectedY = -1.0;

    for (int i = 0; i < points.length; i++) {
      final point = points[i];

      final difference = point.timestamp.difference(marketOpen).inMinutes;
      final double normalizedX = difference / totalTradingMinutes;
      final double x = normalizedX * size.width;

      if (point == selectedPoint) {
        selectedX = x;
        // Approx Y for tooltip (use Close price)
        selectedY = size.height -
            ((point.price - effectiveMin) / effectiveRange * size.height);
      }

      // OHLC values (fallback to price if missing)
      final double open = point.open ?? point.price;
      final double close = point.price;
      final double high = point.high ?? point.price;
      final double low = point.low ?? point.price;

      final double yHigh =
          size.height - ((high - effectiveMin) / effectiveRange * size.height);
      final double yLow =
          size.height - ((low - effectiveMin) / effectiveRange * size.height);
      final double yOpen =
          size.height - ((open - effectiveMin) / effectiveRange * size.height);
      final double yClose =
          size.height - ((close - effectiveMin) / effectiveRange * size.height);

      final bool isBullish = close >= open;
      final Color candleColor =
          isBullish ? AppColors.bullishGreen : AppColors.bearishRed;

      final paint = Paint()
        ..color = candleColor
        ..style = PaintingStyle.fill;

      // Draw Wick
      canvas.drawLine(
          Offset(x, yHigh), Offset(x, yLow), paint..strokeWidth = 1.0);

      // Draw Body
      // Ensure body has at least some height
      double bodyTop = min(yOpen, yClose);
      double bodyBottom = max(yOpen, yClose);
      if (bodyBottom - bodyTop < 1.0) {
        bodyBottom = bodyTop + 1.0;
      }

      final rect = Rect.fromCenter(
          center: Offset(x, (bodyTop + bodyBottom) / 2),
          width: bodyWidth,
          height: bodyBottom - bodyTop);

      canvas.drawRect(rect, paint..style = PaintingStyle.fill);
    }

    // 3. Draw Dotted Reference Line (Prev Close)
    final double prevCloseY = size.height -
        ((prevClose - effectiveMin) / effectiveRange * size.height);
    _drawDashedLine(canvas, size.width, prevCloseY);

    // 4. Draw Interactions
    if (selectedPoint != null && selectedX >= 0) {
      // Draw Crosshair Line
      final cursorPaint = Paint()
        ..color = Colors.white.withOpacity(0.5)
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;

      canvas.drawLine(
          Offset(selectedX, 0), Offset(selectedX, size.height), cursorPaint);

      final double closeY = size.height -
          ((selectedPoint!.price - effectiveMin) /
              effectiveRange *
              size.height);

      canvas.drawCircle(
          Offset(selectedX, closeY), 4.0, Paint()..color = Colors.white);

      // Draw Tooltip Pill
      _drawTooltip(canvas, selectedX, selectedY, selectedPoint!, size);
    }
  }

  void _drawTooltip(
      Canvas canvas, double x, double y, ChartPoint point, Size size) {
    // ... (Keep existing tooltip logic, maybe update to show OHLC?)
    // For now keep simple Price/Time
    final textSpan = TextSpan(
      text: '₹${point.price.toStringAsFixed(2)}',
      style: const TextStyle(
          color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    // Draw background pill
    final padding = 8.0;
    final width = textPainter.width + padding * 2;
    final height = textPainter.height + padding * 2;

    // Position above the point
    double drawX = x - width / 2;
    if (drawX < 0) drawX = 0;
    if (drawX + width > size.width) drawX = size.width - width;

    double drawY = y - height - 15;
    if (drawY < 0) drawY = y + 15;

    final bgRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(drawX, drawY, width, height),
      const Radius.circular(8),
    );

    canvas.drawRRect(bgRect, Paint()..color = AppColors.darkCardBackground);
    textPainter.paint(canvas, Offset(drawX + padding, drawY + padding));

    // Time label at bottom X axis
    final timeStr =
        "${point.timestamp.hour.toString().padLeft(2, '0')}:${point.timestamp.minute.toString().padLeft(2, '0')}";
    final timeSpan = TextSpan(
      text: timeStr,
      style: const TextStyle(
          color: AppColors.darkTextSecondary,
          fontSize: 11,
          fontWeight: FontWeight.w500),
    );
    final timePainter =
        TextPainter(text: timeSpan, textDirection: TextDirection.ltr);
    timePainter.layout();

    final timeMsgWidth = timePainter.width + 12;
    final timeMsgHeight = timePainter.height + 6;
    double timeX = x - timeMsgWidth / 2;
    if (timeX < 0) timeX = 0;
    if (timeX + timeMsgWidth > size.width) timeX = size.width - timeMsgWidth;

    final timeRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
          timeX, size.height - timeMsgHeight, timeMsgWidth, timeMsgHeight),
      const Radius.circular(4),
    );
    canvas.drawRRect(timeRect,
        Paint()..color = AppColors.darkCardBackground.withOpacity(0.8));
    timePainter.paint(
        canvas, Offset(timeX + 6, size.height - timeMsgHeight + 3));
  }

  void _drawDashedLine(Canvas canvas, double width, double y) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const double dashWidth = 4.0;
    const double dashSpace = 4.0;
    double startX = 0;

    while (startX < width) {
      canvas.drawLine(
        Offset(startX, y),
        Offset(startX + dashWidth, y),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant _AreaChartPainter oldDelegate) {
    return oldDelegate.selectedPoint != selectedPoint ||
        oldDelegate.points != points ||
        oldDelegate.color != color;
  }
}
