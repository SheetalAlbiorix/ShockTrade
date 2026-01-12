import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shock_app/core/config/app_colors.dart';

class FilterChipsSelector extends StatefulWidget {
  final ValueChanged<String> onFilterChanged;

  const FilterChipsSelector({super.key, required this.onFilterChanged});

  @override
  State<FilterChipsSelector> createState() => _FilterChipsSelectorState();
}

class _FilterChipsSelectorState extends State<FilterChipsSelector> {
  final List<String> _filters = ['All', 'Stocks', 'F&O', 'Indices'];
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = _selectedFilter == filter;
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedFilter = filter;
              });
              HapticFeedback.lightImpact();
              widget.onFilterChanged(filter);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected 
                    ? AppColors.premiumAccentBlue 
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected 
                      ? AppColors.premiumAccentBlue 
                      : AppColors.premiumCardBorder,
                ),
              ),
              child: Center(
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected 
                        ? Colors.white 
                        : AppColors.darkTextSecondary,
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
