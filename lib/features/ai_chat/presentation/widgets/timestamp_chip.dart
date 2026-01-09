import 'package:flutter/material.dart';
import 'package:shock_app/features/ai_chat/presentation/ai_chat_colors.dart';
import 'package:intl/intl.dart';

/// Timestamp chip for date/time separators
class TimestampChip extends StatelessWidget {
  final DateTime timestamp;

  const TimestampChip({
    super.key,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate =
        DateTime(timestamp.year, timestamp.month, timestamp.day);

    String label;
    if (messageDate == today) {
      label = 'Today, ${DateFormat('h:mm a').format(timestamp)}';
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      label = 'Yesterday, ${DateFormat('h:mm a').format(timestamp)}';
    } else {
      label = DateFormat('MMM d, h:mm a').format(timestamp);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AIChatColors.surfaceDark.withOpacity(0.5),
            borderRadius: BorderRadius.circular(9999),
            border: Border.all(
              color: AIChatColors.whiteBorder5,
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: AIChatColors.textGray500,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
