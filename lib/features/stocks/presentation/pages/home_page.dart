import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/core/config/app_strings.dart';
import 'package:shock_app/core/config/theme_provider.dart';

/// Home page - placeholder for main app content
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('${AppStrings.appName} - ${AppStrings.home}'),
        actions: [
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: () {
              ref.read(themeModeProvider.notifier).toggleTheme();
            },
            tooltip: themeMode == ThemeMode.light
                ? AppStrings.darkMode
                : AppStrings.lightMode,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // TODO: Implement logout functionality
              // ref.read(authControllerProvider.notifier).logout();
            },
            tooltip: AppStrings.logout,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.green,
            ),
            const SizedBox(height: 24),
            Text(
              '${AppStrings.welcomeToShock}!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'You are now authenticated',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 48),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'This is a placeholder home page. '
                'Add your stock market features here:\n\n'
                '• Real-time ${AppStrings.stocks.toLowerCase()} prices\n'
                '• ${AppStrings.watchlist}\n'
                '• ${AppStrings.portfolio}\n'
                '• ${AppStrings.aiChat}\n'
                '• ${AppStrings.alerts}\n'
                '• ${AppStrings.news}',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
