# SHOCK App - Quick Start Guide

## Initial Setup

### 1. Install Dependencies
```bash
cd /Users/hardikthakker/Documents/FlutterProjects/ShockTrade
flutter pub get
```

### 2. Generate Code
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Run the App
```bash
flutter run
```

## Testing the Auth Flow

The app includes a complete authentication example:

1. **Splash Screen** (`/`) - Shows for 2 seconds, then navigates to login
2. **Login Screen** (`/login`) - Enter any email/password to test
3. **Home Screen** (`/home`) - Displayed after successful login

### Note on API
The current implementation uses a placeholder API URL. To test with a real backend:

1. Update the base URL in `lib/core/networking/api_client.dart`:
   ```dart
   baseUrl: 'https://your-api.com',
   ```

2. Ensure your API has these endpoints:
   - `POST /auth/login` - Accepts `{email, password}`, returns `{user: {...}}`
   - `POST /auth/logout`
   - `GET /auth/me`

## Project Structure Overview

```
lib/
├── main.dart                    # App entry point
├── di/di.dart                   # Dependency injection setup
├── routing/app_router.dart      # Navigation routes
├── core/                        # Shared utilities
│   ├── networking/              # Dio HTTP client
│   └── errors/                  # Error handling
└── features/                    # Feature modules
    └── auth/                    # Authentication example
        ├── domain/              # Business logic
        ├── infrastructure/      # API implementation
        ├── application/         # State management
        └── presentation/        # UI
```

## Key Files to Understand

1. **`lib/main.dart`** - App initialization with ProviderScope and GetIt
2. **`lib/di/di.dart`** - Service registration
3. **`lib/features/auth/application/providers/auth_providers.dart`** - Riverpod providers
4. **`lib/features/auth/presentation/pages/login_page.dart`** - UI example

## Adding Your First Feature

See `PROJECT_STRUCTURE.md` for detailed instructions on adding new features.

## Common Commands

```bash
# Install dependencies
flutter pub get

# Generate code (Freezed/JsonSerializable)
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (auto-regenerate on file changes)
flutter pub run build_runner watch --delete-conflicting-outputs

# Run app
flutter run

# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
dart format .
```

## Troubleshooting

### Build errors after adding Freezed models
Run: `flutter pub run build_runner build --delete-conflicting-outputs`

### Import errors
Run: `flutter pub get` and restart your IDE

### Hot reload not working
Press `R` in terminal or restart the app

## Next Steps

1. Review `PROJECT_STRUCTURE.md` for architecture details
2. Customize the API base URL in `lib/core/networking/api_client.dart`
3. Add your stock market features following the auth example
4. Replace placeholder UI with your designs
