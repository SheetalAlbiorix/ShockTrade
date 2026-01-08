import 'package:go_router/go_router.dart';
import 'package:shock_app/core/widgets/navigation_shell.dart';
import 'package:shock_app/features/auth/presentation/pages/login_page.dart';
import 'package:shock_app/features/splash/presentation/pages/splash_page.dart';
import 'package:shock_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:shock_app/features/auth/presentation/pages/register_page.dart';
import 'package:shock_app/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:shock_app/features/stock_detail/presentation/stock_detail_screen.dart';

/// Application router configuration using GoRouter
final appRouter = GoRouter(
  initialLocation: '/', // Start with splash screen
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/forgot-password',
      name: 'forgot-password',
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const NavigationShell(),
    ),
    GoRoute(
      path: '/stock-detail',
      name: 'stock-detail',
      builder: (context, state) {
        final symbol = state.uri.queryParameters['symbol'] ?? 'AAPL';
        final name = state.uri.queryParameters['name'] ?? 'Apple Inc.';
        // Use symbol as the key for the provider
        return StockDetailScreen(symbol: symbol, name: name);
      },
    ),

    // Add more routes as features are developed:
    // GoRoute(path: '/stocks/:symbol', ...),
  ],
);
