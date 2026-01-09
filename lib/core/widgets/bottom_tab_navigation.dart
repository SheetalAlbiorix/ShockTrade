import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/core/widgets/tab_item.dart';

/// A modern, reusable bottom tab navigation component
/// with dark theme styling, smooth animations, and a floating trade button.
class BottomTabNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<TabItem> tabs;

  const BottomTabNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.tabs = const [],
  });

  @override
  Widget build(BuildContext context) {
    final tabItems = tabs.isEmpty ? AppTabs.all : tabs;
    // Ensure we have 5 tabs for this design
    if (tabItems.length != 5) {
      return const SizedBox();
    }

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        // Navigation Bar Container
        Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          margin: const EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF151B2B), // Premium card background likely
                Color(0xFF0F1525), // Darker shade
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
              const BoxShadow(
                color: Color(0xFF2A3245), // Top border color simulation
                blurRadius: 0,
                spreadRadius: 0,
                offset: Offset(0, 1),
              ),
              const BoxShadow(
                color: Color(0xFF2A3245), // Top border color simulation
                blurRadius: 0,
                spreadRadius: 0.5,
                offset: Offset(0, -0.5),
              ),
            ],
          ),
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(context, tabItems[0], 0),
                _buildNavItem(context, tabItems[1], 1),
                const SizedBox(width: 48), // Space for center button
                _buildNavItem(context, tabItems[3], 3),
                _buildNavItem(context, tabItems[4], 4),
              ],
            ),
          ),
        ),

        // Floating Center Button (AI Chat)
        Positioned(
          bottom: 25 +
              MediaQuery.of(context)
                  .padding
                  .bottom, // Adjusted for dynamic height
          child: GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              onTap(2); // AI Chat index
            },
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.premiumBlueGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.premiumAccentBlue.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(BuildContext context, TabItem item, int index) {
    final isActive = currentIndex == index;

    return Semantics(
      label: item.semanticLabel,
      selected: isActive,
      button: true,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap(index);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          constraints: const BoxConstraints(minWidth: 64),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: child,
                ),
                child: Icon(
                  isActive ? item.activeIcon : item.icon,
                  key: ValueKey(isActive),
                  size: 24,
                  color: isActive
                      ? AppColors.premiumAccentBlue
                      : AppColors.darkTextSecondary,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: isActive
                      ? AppColors.premiumAccentBlue
                      : AppColors.darkTextSecondary,
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  fontFamily: 'Roboto', // Assuming default font or system font
                ),
                child: Text(item.label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
