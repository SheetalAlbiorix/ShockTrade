import 'package:flutter/material.dart';

class TimeframeSelector extends StatelessWidget {
  final String selectedTimeframe;
  final ValueChanged<String> onTimeframeChanged;

  const TimeframeSelector({
    super.key,
    required this.selectedTimeframe,
    required this.onTimeframeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0x1AFFFFFF),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTimeframeChip('1m'),
          const SizedBox(width: 6),
          _buildTimeframeChip('5m'),
          const SizedBox(width: 6),
          _buildTimeframeChip('1h'),
          const SizedBox(width: 6),
          _buildTimeframeChip('1D'),
          const SizedBox(width: 6),
          Container(
            width: 1,
            height: 16,
            color: const Color(0x33FFFFFF),
          ),
          const SizedBox(width: 6),
          _buildIconChip(),
        ],
      ),
    );
  }

  Widget _buildTimeframeChip(String timeframe) {
    final isSelected = selectedTimeframe == timeframe;

    return GestureDetector(
      onTap: () => onTimeframeChanged(timeframe),
      child: Container(
        height: 24,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF135bec) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF135bec).withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            timeframe,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconChip() {
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Icon(
        Icons.candlestick_chart,
        color: Colors.white,
        size: 14,
      ),
    );
  }
}
