import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/features/stock_detail/domain/models.dart';

/// Time filter tabs for chart range selection
class TimeFilterTabs extends StatelessWidget {
  final StockRange selectedRange;
  final Function(StockRange) onRangeChanged;

  const TimeFilterTabs({
    super.key,
    required this.selectedRange,
    required this.onRangeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.glassBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: StockRange.values.map((range) {
          final isSelected = range == selectedRange;
          return Expanded(
            child: GestureDetector(
              onTap: () => onRangeChanged(range),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: BoxDecoration(
                  color:
                      isSelected ? AppColors.primaryBlue : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.primaryBlue.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  range.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:
                        isSelected ? Colors.white : AppColors.darkTextSecondary,
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
