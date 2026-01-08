import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/core/providers/navigation_provider.dart';
import 'package:shock_app/core/widgets/bottom_tab_navigation.dart';
import 'package:shock_app/features/ai_chat/presentation/pages/ai_chat_page.dart';
import 'package:shock_app/features/news/presentation/pages/news_page.dart';
import 'package:shock_app/features/portfolio/presentation/pages/portfolio_page.dart';
import 'package:shock_app/features/stocks/presentation/pages/home_page.dart';
import 'package:shock_app/features/watchlist/presentation/pages/watchlist_page.dart';

/// Main navigation shell that wraps the bottom tab navigation
/// with lazy-loaded tab screens and state preservation.
class NavigationShell extends ConsumerWidget {
  const NavigationShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentTabIndexProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: IndexedStack(
        index: currentIndex,
        children: const [
          HomePage(),
          WatchlistPage(),
          PortfolioPage(),
          AIChatPage(),
          NewsPage(),
        ],
      ),
      bottomNavigationBar: BottomTabNavigation(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(currentTabIndexProvider.notifier).state = index;
        },
      ),
    );
  }
}
