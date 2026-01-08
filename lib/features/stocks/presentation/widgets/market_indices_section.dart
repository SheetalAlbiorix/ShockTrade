import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';

class MarketIndicesSection extends StatelessWidget {
  const MarketIndicesSection({super.key});

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(color: AppColors.premiumAccentBlue),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 150,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            children: [
              _buildIndexCard(
                context,
                name: 'NIFTY 50',
                value: '19,435.00',
                change: '+0.50%',
                isPositive: true,
              ),
              const SizedBox(width: 12),
              _buildIndexCard(
                context,
                name: 'SENSEX',
                value: '65,340.00',
                change: '-0.20%',
                isPositive: false,
              ),
              const SizedBox(width: 12),
              _buildIndexCard(
                context,
                name: 'BANK NIFTY',
                value: '44,500.20',
                change: '+0.35%',
                isPositive: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIndexCard(
    BuildContext context, {
    required String name,
    required String value,
    required String change,
    required bool isPositive,
  }) {
    return Container(
      width: 160,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0), // Bottom padding handled by chart
      decoration: BoxDecoration(
        color: AppColors.premiumCardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.premiumCardBorder),
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
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: (isPositive ? AppColors.premiumAccentGreen : AppColors.premiumAccentRed).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  change,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: isPositive ? AppColors.premiumAccentGreen : AppColors.premiumAccentRed,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.darkTextPrimary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Spacer(),
          // Chart placeholder
          SizedBox(
            height: 50,
            child: CustomPaint(
              size: const Size(double.infinity, 50),
              painter: _IndexChartPainter(isPositive: isPositive),
            ),
          ),
        ],
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
    
    // Draw from bottom left to top right (approx)
    if (isPositive) {
       path.moveTo(0, size.height);
       path.quadraticBezierTo(size.width * 0.3, size.height, size.width * 0.5, size.height * 0.6);
       path.quadraticBezierTo(size.width * 0.7, size.height * 0.3, size.width, size.height * 0.2);
    } else {
       path.moveTo(0, size.height * 0.4);
       path.quadraticBezierTo(size.width * 0.3, size.height * 0.4, size.width * 0.5, size.height * 0.7);
       path.quadraticBezierTo(size.width * 0.7, size.height, size.width, size.height * 0.9);
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
