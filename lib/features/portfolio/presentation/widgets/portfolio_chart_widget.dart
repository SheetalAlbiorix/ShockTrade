import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/portfolio/domain/entities/portfolio_models.dart';

class PortfolioChartWidget extends StatelessWidget {
  final List<ChartDataPoint> dataPoints;

  const PortfolioChartWidget({super.key, required this.dataPoints});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.premiumCardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.premiumCardBorder, width: 1),
      ),
      child: Stack(
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: _LineChartPainter(dataPoints: dataPoints),
          ),
          // Highlight dot (mocked as per image)
          Positioned(
            left: 180,
            top: 60,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.navActiveColor, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.navActiveColor.withValues(alpha: 0.5),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<ChartDataPoint> dataPoints;

  _LineChartPainter({required this.dataPoints});

  @override
  void paint(Canvas canvas, Size size) {
    if (dataPoints.length < 2) return;

    final paint = Paint()
      ..color = AppColors.navActiveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final areaPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, 0),
        Offset(0, size.height),
        [
          AppColors.navActiveColor.withValues(alpha: 0.35),
          AppColors.navActiveColor.withValues(alpha: 0.0),
        ],
      )
      ..style = PaintingStyle.fill;

    final path = Path();
    final areaPath = Path();

    final double xInterval = size.width / (dataPoints.length - 1);
    final double maxY = dataPoints.map((p) => p.y).reduce((a, b) => a > b ? a : b);
    final double minY = dataPoints.map((p) => p.y).reduce((a, b) => a < b ? a : b);
    final double yRange = maxY - minY;
    
    // Normalize Y values to fit in the chart area (leaving some padding)
    double normalizeY(double y) {
      if (yRange == 0) return size.height / 2;
      return size.height - ((y - minY) / yRange * (size.height * 0.7) + (size.height * 0.15));
    }

    path.moveTo(0, normalizeY(dataPoints[0].y));
    areaPath.moveTo(0, size.height);
    areaPath.lineTo(0, normalizeY(dataPoints[0].y));

    for (int i = 1; i < dataPoints.length; i++) {
      final x = i * xInterval;
      final y = normalizeY(dataPoints[i].y);
      
      // Use cubic bezier for smooth effect
      final prevX = (i - 1) * xInterval;
      final prevY = normalizeY(dataPoints[i-1].y);
      
      path.cubicTo(
        prevX + xInterval / 2,
        prevY,
        prevX + xInterval / 2,
        y,
        x,
        y,
      );
      
      areaPath.cubicTo(
        prevX + xInterval / 2,
        prevY,
        prevX + xInterval / 2,
        y,
        x,
        y,
      );
    }

    areaPath.lineTo(size.width, size.height);
    areaPath.close();

    canvas.drawPath(areaPath, areaPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
