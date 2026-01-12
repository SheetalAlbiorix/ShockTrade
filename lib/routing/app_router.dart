import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shock_app/core/widgets/navigation_shell.dart';
import 'package:shock_app/features/auth/presentation/pages/login_page.dart';
import 'package:shock_app/features/splash/presentation/pages/splash_page.dart';
import 'package:shock_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:shock_app/features/auth/presentation/pages/register_page.dart';
import 'package:shock_app/features/auth/presentation/pages/verify_email_page.dart';
import 'package:shock_app/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:shock_app/features/stock_detail/presentation/stock_detail_screen.dart';
import 'package:shock_app/features/ai_chat/presentation/pages/ai_chat_screen.dart';
import 'package:shock_app/features/chart/presentation/pages/professional_chart_screen.dart';
import 'package:shock_app/features/search/presentation/pages/search_page.dart';
import 'package:shock_app/features/search/presentation/pages/trending_stocks_page.dart';
import 'package:shock_app/features/news/presentation/pages/news_page.dart';
import 'package:shock_app/features/alerts/presentation/pages/alerts_page.dart';
import 'package:shock_app/features/account/presentation/pages/edit_profile_page.dart';
import 'package:shock_app/features/portfolio/presentation/pages/add_holding_page.dart';
import 'package:shock_app/features/portfolio/presentation/pages/edit_holding_page.dart';

/// Application router configuration using GoRouter
final appRouter = GoRouter(
  initialLocation: '/', // Changed from '/' to bypass login for testing
  debugLogDiagnostics: true,
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Router Error: ${state.error}'),
    ),
  ),
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
      path: '/verify-email',
      name: 'verify-email',
      builder: (context, state) => const VerifyEmailPage(),
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
    GoRoute(
      path: '/ai-chat',
      name: 'ai-chat',
      builder: (context, state) => const AIChatScreen(),
    ),
    GoRoute(
      path: '/professional-chart',
      name: 'professional-chart',
      builder: (context, state) {
        final symbol = state.uri.queryParameters['symbol'] ?? 'RELIANCE.NS';
        final name =
            state.uri.queryParameters['name'] ?? 'Reliance Industries Ltd';
        return ProfessionalChartScreen(symbol: symbol, name: name);
      },
    ),

    // Add more routes as features are developed:
    GoRoute(
      path: '/search',
      name: 'search',
      builder: (context, state) => const SearchPage(),
    ),
    GoRoute(
      path: '/trending',
      name: 'trending',
      builder: (context, state) => const TrendingStocksPage(),
    ),
    GoRoute(
      path: '/alerts',
      builder: (context, state) => const AlertsPage(),
    ),
    GoRoute(
      path: '/market-news',
      name: 'market-news',
      builder: (context, state) => const NewsPage(),
    ),
    GoRoute(
      path: '/edit-profile',
      name: 'edit-profile',
      builder: (context, state) => const EditProfilePage(),
    ),
    GoRoute(
      path: '/portfolio-add-holding',
      name: 'portfolio-add-holding',
      builder: (context, state) => const AddHoldingPage(),
    ),
    GoRoute(
      path: '/portfolio-edit-holding/:id',
      name: 'portfolio-edit-holding',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return EditHoldingPage(holdingId: id);
      },
    ),
  ],
);
