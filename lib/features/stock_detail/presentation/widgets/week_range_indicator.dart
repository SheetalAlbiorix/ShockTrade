import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/stock_detail/presentation/widgets/glass_card.dart';

/// 52-week range indicator with progress bar
class WeekRangeIndicator extends StatelessWidget {
  final double low;
  final double high;
  final double current;

  const WeekRangeIndicator({
    super.key,
    required this.low,
    required this.high,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate position percentage (0-1)
    final position = (current - low) / (high - low);
    final clampedPosition = position.clamp(0.0, 1.0);

    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '52W Low',
                    style: TextStyle(
                      color: AppColors.darkTextSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '₹${low.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: AppColors.darkTextPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    '52W High',
                    style: TextStyle(
                      color: AppColors.darkTextSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '₹${high.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: AppColors.darkTextPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Progress bar
          Container(
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              gradient: AppColors.weekRangeGradient,
            ),
          ),
          const SizedBox(height: 4),
          // Position indicator
          Align(
            alignment: Alignment(clampedPosition * 2 - 1, 0),
            child: CustomPaint(
              size: const Size(8, 6),
              painter: _TrianglePainter(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
