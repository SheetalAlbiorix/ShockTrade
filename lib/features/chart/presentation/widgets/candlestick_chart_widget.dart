import 'package:flutter/material.dart';

class CandlestickChartWidget extends StatefulWidget {
  final Function(CandlestickData?)? onCrosshairMoved;

  const CandlestickChartWidget({
    super.key,
    this.onCrosshairMoved,
  });

  @override
  State<CandlestickChartWidget> createState() => _CandlestickChartWidgetState();
}

class _CandlestickChartWidgetState extends State<CandlestickChartWidget> {
  Offset? _crosshairOffset;

  // Static data for now (moved from painter)
  static final List<CandlestickData> candlesticks = [
    CandlestickData(
        0.10, 0.24, 0.26, 0.08, true, 2948.10, 2952.45, 2942.00, 2945.60),
    CandlestickData(
        0.20, 0.28, 0.44, 0.12, false, 2945.60, 2948.00, 2930.00, 2935.20),
    CandlestickData(
        0.30, 0.20, 0.32, 0.08, true, 2935.20, 2940.50, 2932.00, 2938.80),
    CandlestickData(
        0.40, 0.16, 0.26, 0.06, true, 2938.80, 2942.00, 2936.50, 2940.10),
    CandlestickData(
        0.50, 0.22, 0.38, 0.10, false, 2940.10, 2941.50, 2925.00, 2928.40),
    CandlestickData(
        0.60, 0.18, 0.30, 0.08, true, 2928.40, 2935.60, 2926.00, 2932.10),
    CandlestickData(
        0.70, 0.24, 0.36, 0.10, false, 2932.10, 2934.00, 2918.00, 2922.50),
    CandlestickData(
        0.80, 0.20, 0.28, 0.08, true, 2922.50, 2930.00, 2920.00, 2928.90),
  ];

  void _handleHover(Offset localPosition, Size size) {
    setState(() {
      _crosshairOffset = localPosition;
    });

    // Find nearest candle based on X position
    final relativeX = localPosition.dx / size.width;
    CandlestickData? nearestCandle;
    double minDistance = double.infinity;

    for (final candle in candlesticks) {
      final distance = (candle.x - relativeX).abs();
      if (distance < minDistance) {
        minDistance = distance;
        nearestCandle = candle;
      }
    }

    // Only update if we are close enough (e.g., within 5% of width)
    if (minDistance < 0.08) {
      widget.onCrosshairMoved?.call(nearestCandle);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onPanStart: (details) =>
              _handleHover(details.localPosition, constraints.biggest),
          onPanUpdate: (details) =>
              _handleHover(details.localPosition, constraints.biggest),
          // Keep crosshair active on end for now, or reset if preferred
          // onPanEnd: (_) => setState(() => _crosshairOffset = null),
          child: CustomPaint(
            painter: CandlestickChartPainter(
              crosshairOffset: _crosshairOffset,
              candlesticks: candlesticks,
            ),
            child: Container(),
          ),
        );
      },
    );
  }
}

class CandlestickChartPainter extends CustomPainter {
  final Offset? crosshairOffset;
  final List<CandlestickData> candlesticks;

  CandlestickChartPainter({
    this.crosshairOffset,
    required this.candlesticks,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw grid background
    _drawGrid(canvas, size);

    // Draw moving averages
    _drawMovingAverages(canvas, size);

    // Draw candlesticks
    _drawCandlesticks(canvas, size);

    // Draw volume histogram
    _drawVolumeHistogram(canvas, size);

    // Draw crosshair
    if (crosshairOffset != null) {
      _drawCrosshair(canvas, size, crosshairOffset!);
    } else {
      // Draw default crosshair or nothing
      _drawCrosshair(
          canvas, size, Offset(size.width * 0.65, size.height * 0.55));
    }

    // Draw price axis labels
    _drawPriceAxis(canvas, size);

    // Draw time axis labels
    _drawTimeAxis(canvas, size);
  }

  // ... (existing _drawGrid, _drawMovingAverages methods remain the same)
  // I will only include changed methods to keep it concise, assuming tool context allows

  void _drawGrid(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0x08FFFFFF)
      ..strokeWidth = 1;

    // Horizontal grid lines
    for (int i = 1; i < 5; i++) {
      final y = size.height * (i / 5);
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    // Vertical grid lines (subtle)
    for (int i = 1; i < 10; i++) {
      final x = size.width * (i / 10);
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        gridPaint,
      );
    }
  }

  void _drawMovingAverages(Canvas canvas, Size size) {
    // Blue MA
    final blueMAPaint = Paint()
      ..color = const Color(0xFF135bec).withOpacity(0.6)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final bluePath = Path();
    bluePath.moveTo(0, size.height * 0.3);
    bluePath.quadraticBezierTo(
      size.width * 0.2,
      size.height * 0.26,
      size.width * 0.4,
      size.height * 0.32,
    );
    bluePath.quadraticBezierTo(
      size.width * 0.6,
      size.height * 0.28,
      size.width * 0.8,
      size.height * 0.3,
    );
    bluePath.lineTo(size.width, size.height * 0.36);

    canvas.drawPath(bluePath, blueMAPaint);

    // Orange MA
    final orangeMAPaint = Paint()
      ..color = const Color(0xFFf59e0b).withOpacity(0.4)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final orangePath = Path();
    orangePath.moveTo(0, size.height * 0.36);
    orangePath.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.32,
      size.width * 0.6,
      size.height * 0.34,
    );
    orangePath.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.4,
      size.width,
      size.height * 0.38,
    );

    canvas.drawPath(orangePath, orangeMAPaint);
  }

  void _drawCandlesticks(Canvas canvas, Size size) {
    for (final candle in candlesticks) {
      _drawCandlestick(canvas, size, candle);
    }
  }

  void _drawCandlestick(
    Canvas canvas,
    Size size,
    CandlestickData candle,
  ) {
    final x = size.width * candle.x;
    final wickTop = size.height * candle.wickTop;
    final wickBottom = size.height * candle.wickBottom;
    final bodyHeight = size.height * candle.bodyHeight;

    final color =
        candle.isUp ? const Color(0xFF26a69a) : const Color(0xFFef5350);

    // Draw wick
    final wickPaint = Paint()
      ..color = color
      ..strokeWidth = 1;

    canvas.drawLine(
      Offset(x, wickTop),
      Offset(x, wickBottom),
      wickPaint,
    );

    // Draw body
    final bodyPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final bodyTop = candle.isUp
        ? wickTop + (wickBottom - wickTop) * 0.2
        : wickTop + (wickBottom - wickTop) * 0.3;

    canvas.drawRect(
      Rect.fromLTWH(
        x - 6,
        bodyTop,
        12,
        bodyHeight,
      ),
      bodyPaint,
    );
  }

  void _drawCrosshair(Canvas canvas, Size size, Offset offset) {
    final crosshairPaint = Paint()
      ..color = const Color(0xFF135bec)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Horizontal line
    canvas.drawLine(
      Offset(0, offset.dy),
      Offset(size.width, offset.dy),
      crosshairPaint,
    );

    // Vertical line
    canvas.drawLine(
      Offset(offset.dx, 0),
      Offset(offset.dx, size.height),
      crosshairPaint,
    );

    // Draw dot at intersection
    canvas.drawCircle(offset, 3, Paint()..color = const Color(0xFF135bec));
  }

  void _drawVolumeHistogram(Canvas canvas, Size size) {
    final volumes = [
      VolumeData(0.05, 0.15, true),
      VolumeData(0.10, 0.12, true),
      VolumeData(0.15, 0.20, false),
      VolumeData(0.20, 0.10, false),
      VolumeData(0.25, 0.18, true),
      VolumeData(0.30, 0.15, true),
      VolumeData(0.35, 0.12, false),
      VolumeData(0.40, 0.20, true),
      VolumeData(0.45, 0.10, false),
      VolumeData(0.50, 0.18, true),
      VolumeData(0.55, 0.15, true),
      VolumeData(0.60, 0.12, false),
      VolumeData(0.65, 0.20, true),
      VolumeData(0.70, 0.10, false),
      VolumeData(0.75, 0.18, true),
      VolumeData(0.80, 0.15, true),
      VolumeData(0.85, 0.12, false),
      VolumeData(0.90, 0.20, true),
    ];

    for (final volume in volumes) {
      final x = size.width * volume.x;
      final barHeight =
          size.height * volume.height * 0.25; // Increased for visibility
      final bottomY = size.height * 0.85; // Start from 85% to leave space
      final topY = bottomY - barHeight; // Draw upward

      final color = volume.isUp
          ? const Color(0xFF26a69a).withOpacity(0.3)
          : const Color(0xFFef5350).withOpacity(0.3);

      final volumePaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      canvas.drawRect(
        Rect.fromLTWH(x, topY, 8, barHeight),
        volumePaint,
      );
    }
  }

  void _drawPriceAxis(Canvas canvas, Size size) {
    // Price labels are drawn in the main widget
  }

  void _drawTimeAxis(Canvas canvas, Size size) {
    // Time labels are drawn in the main widget
  }

  @override
  bool shouldRepaint(covariant CandlestickChartPainter oldDelegate) {
    return oldDelegate.crosshairOffset != crosshairOffset;
  }
}

class CandlestickData {
  final double x;
  final double wickTop;
  final double wickBottom;
  final double bodyHeight;
  final bool isUp;
  final double open;
  final double high;
  final double low;
  final double close;

  CandlestickData(
    this.x,
    this.wickTop,
    this.wickBottom,
    this.bodyHeight,
    this.isUp,
    this.open,
    this.high,
    this.low,
    this.close,
  );
}

class VolumeData {
  final double x;
  final double height;
  final bool isUp;

  VolumeData(this.x, this.height, this.isUp);
}
