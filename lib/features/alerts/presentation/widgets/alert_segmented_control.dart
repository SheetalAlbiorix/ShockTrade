import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';

class AlertSegmentedControl extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onValueChanged;

  const AlertSegmentedControl({
    super.key,
    required this.selectedIndex,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.premiumCardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.premiumCardBorder),
      ),
      child: Row(
        children: [
          Expanded(
            child: _SegmentButton(
              label: 'Active',
              isSelected: selectedIndex == 0,
              onTap: () => onValueChanged(0),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: _SegmentButton(
              label: 'History',
              isSelected: selectedIndex == 1,
              onTap: () => onValueChanged(1),
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SegmentButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.premiumSurface : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.darkTextSecondary,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
