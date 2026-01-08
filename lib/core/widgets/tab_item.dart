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

  static const watchlist = TabItem(
    label: 'Watchlist',
    icon: Icons.star_outline,
    activeIcon: Icons.star,
    semanticLabel: 'Watchlist tab',
  );

  static const portfolio = TabItem(
    label: 'Portfolio',
    icon: Icons.pie_chart_outline,
    activeIcon: Icons.pie_chart,
    semanticLabel: 'Portfolio tab',
  );

  static const aiChat = TabItem(
    label: 'AI Chat',
    icon: Icons.chat_bubble_outline,
    activeIcon: Icons.chat_bubble,
    semanticLabel: 'AI Chat tab',
  );

  static const news = TabItem(
    label: 'News',
    icon: Icons.article_outlined,
    activeIcon: Icons.article,
    semanticLabel: 'News tab',
  );

  static const List<TabItem> all = [home, watchlist, portfolio, aiChat, news];
}
