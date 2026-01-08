import 'package:flutter/material.dart';

/// Action buttons row for watchlist and alerts
class ActionButtons extends StatelessWidget {
  final bool isInWatchlist;
  final bool hasAlert;
  final VoidCallback onWatchlistTap;
  final VoidCallback onAlertTap;

  const ActionButtons({
    super.key,
    required this.isInWatchlist,
    required this.hasAlert,
    required this.onWatchlistTap,
    required this.onAlertTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: onWatchlistTap,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF00E0FF),
                side: const BorderSide(
                  color: Color(0xFF00E0FF),
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                isInWatchlist ? 'Remove from Watchlist' : 'Add to Watchlist',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: onAlertTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00E0FF),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                hasAlert ? 'Remove Alert' : 'Set Alert',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
