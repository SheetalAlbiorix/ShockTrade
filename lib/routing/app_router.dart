import 'package:go_router/go_router.dart';
import 'package:shock_app/features/auth/presentation/pages/login_page.dart';
import 'package:shock_app/features/auth/presentation/pages/splash_page.dart';
import 'package:shock_app/features/stock_detail/presentation/stock_detail_screen.dart';
import 'package:shock_app/features/stocks/presentation/pages/home_page.dart';

/// Application router configuration using GoRouter
final appRouter = GoRouter(
  initialLocation: '/',
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
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/stock-detail',
      name: 'stock-detail',
      builder: (context, state) => const StockDetailScreen(),
    ),

    // Add more routes as features are developed:
    // GoRoute(path: '/stocks/:symbol', ...),
    // GoRoute(path: '/portfolio', ...),
    // GoRoute(path: '/alerts', ...),
    // GoRoute(path: '/ai-chat', ...),
  ],
);
