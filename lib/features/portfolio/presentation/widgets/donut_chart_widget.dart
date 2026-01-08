import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/portfolio/domain/entities/portfolio_models.dart';

/// Custom donut chart widget for asset distribution
class DonutChartWidget extends StatelessWidget {
  final List<AssetCategory> categories;
  final double size;
  final double strokeWidth;

  const DonutChartWidget({
    super.key,
    required this.categories,
    this.size = 160,
    this.strokeWidth = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Asset distribution chart showing ${categories.map((c) => "${c.name} ${c.percentage}%").join(", ")}',
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.darkCardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.darkDivider, width: 0.5),
        ),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Asset Distribution',
                style: TextStyle(
                  color: AppColors.darkTextPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: size,
              height: size,
              child: CustomPaint(
                size: Size(size, size),
                painter: _DonutChartPainter(
                  categories: categories,
                  strokeWidth: strokeWidth,
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: categories.map((category) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: category.color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              category.name,
              style: const TextStyle(
                color: AppColors.darkTextSecondary,
                fontSize: 13,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  final List<AssetCategory> categories;
  final double strokeWidth;

  _DonutChartPainter({
    required this.categories,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    
    double startAngle = -math.pi / 2; // Start from top
    
    for (final category in categories) {
      final sweepAngle = (category.percentage / 100) * 2 * math.pi;
      
      final paint = Paint()
        ..color = category.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;
      
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
