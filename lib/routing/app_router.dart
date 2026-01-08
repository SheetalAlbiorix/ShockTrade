import 'package:go_router/go_router.dart';
import 'package:shock_app/core/widgets/navigation_shell.dart';
import 'package:shock_app/features/auth/presentation/pages/login_page.dart';
import 'package:shock_app/features/auth/presentation/pages/splash_page.dart';
import 'package:shock_app/features/stock_detail/presentation/stock_detail_screen.dart';

/// Application router configuration using GoRouter
final appRouter = GoRouter(
  initialLocation: '/home', // Changed from '/' to bypass login for testing
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const NavigationShell(),
    ),
    GoRoute(
      path: '/stock-detail',
      name: 'stock-detail',
      builder: (context, state) => const StockDetailScreen(),
    ),

    // Add more routes as features are developed:
    // GoRoute(path: '/stocks/:symbol', ...),
  ],
);
