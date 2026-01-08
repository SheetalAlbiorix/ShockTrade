import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/core/widgets/tab_item.dart';

/// A modern, reusable bottom tab navigation component
/// with dark theme styling, smooth animations, and accessibility support.
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

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.navBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              tabItems.length,
              (index) => _TabItemWidget(
                item: tabItems[index],
                isActive: currentIndex == index,
                onTap: () {
                  HapticFeedback.lightImpact();
                  onTap(index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabItemWidget extends StatelessWidget {
  final TabItem item;
  final bool isActive;
  final VoidCallback onTap;

  const _TabItemWidget({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: item.semanticLabel,
      selected: isActive,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 64,
            minHeight: 48,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
                      child: child,
                    ),
                  ),
                  child: Icon(
                    isActive ? item.activeIcon : item.icon,
                    key: ValueKey(isActive),
                    color: isActive
                        ? AppColors.navActiveColor
                        : AppColors.navInactiveColor,
                    size: 24,
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isActive ? 1.0 : 0.0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: isActive ? 18 : 0,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        item.label,
                        style: TextStyle(
                          color: AppColors.navActiveColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
