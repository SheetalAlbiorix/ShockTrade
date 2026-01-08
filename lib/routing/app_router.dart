import 'package:go_router/go_router.dart';
import 'package:shock_app/core/widgets/navigation_shell.dart';
import 'package:shock_app/features/auth/presentation/pages/login_page.dart';
import 'package:shock_app/features/splash/presentation/pages/splash_page.dart';
import 'package:shock_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:shock_app/features/auth/presentation/pages/register_page.dart';

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
      path: '/home',
      name: 'home',
      builder: (context, state) => const NavigationShell(),
    ),

    // Add more routes as features are developed:
    // GoRoute(path: '/stocks/:symbol', ...),
  ],
);
