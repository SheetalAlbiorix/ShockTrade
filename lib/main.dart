import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shock_app/core/config/app_strings.dart';
import 'package:shock_app/core/config/app_theme.dart';
import 'package:shock_app/core/config/env.dart';
import 'package:shock_app/core/config/theme_provider.dart';
import 'package:shock_app/di/di.dart';
import 'package:shock_app/core/services/notification_service.dart';
import 'package:shock_app/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    debugPrint('Firebase initialized successfully');
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
    debugPrint('Firebase initialization failed: $e');
    debugPrint(
        'Note: Authentication features will be disabled until Firebase is configured.');
  }

  // Register Background Handler (Must be top-level static)
  // We need to import the handler from notification_service.dart, but it is private there.
  // Actually, standard practice is to define it in main or export it.
  // Let's modify NotificationService to expose it or just define it in main for simplicity if needed.
  // Wait, I put it as private `_` in the previous step. It won't be accessible here.
  // I should make it public in NotificationService or define it here.
  // BETTER PLAN: Define it in `notification_service.dart` as PUBLIC `firebaseMessagingBackgroundHandler`.
  // I need to adjust the previous step or this step.
  // Let's assume I fix the previous step to be public in the next tool call if I made a mistake,
  // OR I can just refer to it if I rename it now.

  // Actually, I can't import private functions.
  // I will update `notification_service.dart` to make it public in the next step.
  // For now, I will add the code assuming it is named `firebaseMessagingBackgroundHandler`.

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnonKey,
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
