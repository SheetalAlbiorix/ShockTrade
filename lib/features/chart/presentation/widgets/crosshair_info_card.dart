import 'package:flutter/material.dart';

class CrosshairInfoCard extends StatelessWidget {
  final double open;
  final double high;
  final double low;
  final double close;

  const CrosshairInfoCard({
    super.key,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0f172a).withOpacity(0.9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0x1AFFFFFF),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildInfoRow('O', open),
          const SizedBox(height: 4),
          _buildInfoRow('H', high),
          const SizedBox(height: 4),
          _buildInfoRow('L', low),
          const SizedBox(height: 4),
          _buildInfoRow('C', close),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, double value) {
    return Row(
      children: [
        SizedBox(
          width: 12,
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF64748b),
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          value.toStringAsFixed(2),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
