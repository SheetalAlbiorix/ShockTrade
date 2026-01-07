import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/core/config/app_strings.dart';
import 'package:shock_app/core/config/app_theme.dart';
import 'package:shock_app/core/config/theme_provider.dart';
import 'package:shock_app/di/di.dart';
import 'package:shock_app/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await configureDependencies();

  runApp(
    const ProviderScope(
      child: ShockApp(),
    ),
  );
}

class ShockApp extends ConsumerWidget {
  const ShockApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,

      // Theme Configuration
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      routerConfig: appRouter,
    );
  }
}
