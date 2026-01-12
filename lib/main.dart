import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shock_app/core/config/app_strings.dart';
import 'package:shock_app/core/config/app_theme.dart';
import 'package:shock_app/core/config/theme_provider.dart';
import 'package:shock_app/di/di.dart';
import 'package:shock_app/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Supabase.initialize(
    url: 'https://hhlojydanygoaxwawtpb.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhobG9qeWRhbnlnb2F4d2F3dHBiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njc5NTk4MzAsImV4cCI6MjA4MzUzNTgzMH0.cuzRoGNm0xFGbzIK76aYiCw1OB0lSepM3yR8zZS9aA4',
  );

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
