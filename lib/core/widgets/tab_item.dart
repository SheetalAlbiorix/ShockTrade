import 'package:flutter/material.dart';

/// Tab item model for bottom navigation
class TabItem {
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String semanticLabel;

  const TabItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.semanticLabel,
  });
}

/// Predefined tab items for the app
class AppTabs {
  static const home = TabItem(
    label: 'Home',
    icon: Icons.home_outlined,
    activeIcon: Icons.home,
    semanticLabel: 'Home tab',
  );

  static const portfolio = TabItem(
    label: 'Portfolio',
    icon: Icons.pie_chart_outline,
    activeIcon: Icons.pie_chart,
    semanticLabel: 'Portfolio tab',
  );

  static const aiChat = TabItem(
    label: 'AI Chat',
    icon: Icons.auto_awesome_outlined,
    activeIcon: Icons.auto_awesome,
    semanticLabel: 'AI Chat tab',
  );

  static const watchlist = TabItem(
    label: 'Watchlist',
    icon: Icons.bookmark_border,
    activeIcon: Icons.bookmark,
    semanticLabel: 'Watchlist tab',
  );

  static const account = TabItem(
    label: 'Account',
    icon: Icons.person_outline,
    activeIcon: Icons.person,
    semanticLabel: 'Account tab',
  );

  static const List<TabItem> all = [
    home,
    portfolio,
    aiChat,
    watchlist,
    account
  ];
}
