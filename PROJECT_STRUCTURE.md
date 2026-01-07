# SHOCK App - Flutter Project Structure

## Overview

This is a production-grade Flutter project structure for the SHOCK stock market app, built using Clean Architecture principles with modern Flutter best practices.

## Architecture Layers

### 1. **Domain Layer** (`features/*/domain/`)
Contains business logic and entities, independent of any framework or external dependencies.

- **entities/**: Immutable data models (using Freezed)
- **repositories/**: Abstract repository interfaces
- **usecases/**: Business logic operations

### 2. **Infrastructure Layer** (`infrastructure/*/`)
Implements domain interfaces with concrete implementations using external dependencies.

- Concrete repository implementations
- API clients and data sources
- External service integrations

### 3. **Application Layer** (`features/*/application/`)
Manages application state and coordinates between domain and presentation layers.

- **providers/**: Riverpod providers
- **controllers/**: StateNotifiers for state management
- **state/**: State classes (using Freezed)

### 4. **Presentation Layer** (`features/*/presentation/`)
UI components and user interaction logic.

- **pages/**: Full-screen views
- **widgets/**: Reusable UI components

---

## Folder Structure

```
lib/
├── core/                           # Shared utilities and configurations
│   ├── config/                     # App configuration (API URLs, constants)
│   ├── errors/                     # Error handling (Failure classes)
│   ├── networking/                 # HTTP client setup (Dio configuration)
│   └── utils/                      # Helper functions and extensions
│
├── features/                       # Feature modules (Clean Architecture)
│   ├── auth/                       # Authentication feature
│   │   ├── domain/
│   │   │   ├── entities/          # User entity
│   │   │   ├── repositories/      # AuthRepository interface
│   │   │   └── usecases/          # LoginUseCase
│   │   ├── application/
│   │   │   ├── providers/         # Riverpod providers
│   │   │   ├── controllers/       # AuthController (StateNotifier)
│   │   │   └── state/             # AuthState (Freezed)
│   │   └── presentation/
│   │       ├── pages/             # LoginPage, SplashPage
│   │       └── widgets/           # Auth-specific widgets
│   │
│   ├── stocks/                     # Stock market data feature
│   │   ├── domain/
│   │   ├── application/
│   │   └── presentation/
│   │
│   ├── portfolio/                  # Portfolio management
│   ├── alerts/                     # Price alerts
│   ├── ai_chat/                    # AI chat feature
│   └── news/                       # Market news
│
├── infrastructure/                 # Implementation of domain repositories
│   ├── auth/                       # AuthRepositoryImpl
│   ├── stocks/
│   ├── portfolio/
│   ├── alerts/
│   ├── ai_chat/
│   └── news/
│
├── routing/                        # Navigation configuration
│   └── app_router.dart            # GoRouter setup
│
├── di/                            # Dependency Injection
│   └── di.dart                    # GetIt configuration
│
└── main.dart                      # App entry point
```

---

## Key Technologies

- **Flutter 3.x** with Dart null-safety
- **Riverpod 2.x** - State management (ONLY state management solution)
- **GetIt** - Dependency injection for services
- **GoRouter** - Declarative routing
- **Dio** - HTTP client
- **Freezed** - Immutable models and unions
- **JsonSerializable** - JSON serialization

---

## Dependency Injection Pattern

The app uses **GetIt** for service registration and **Riverpod** for state management:

1. Services (repositories, use cases) are registered in `di/di.dart` using GetIt
2. Riverpod providers access GetIt instances: `Provider((ref) => getIt<AuthRepository>())`
3. UI components watch Riverpod providers for reactive state updates

### Example Flow:

```
UI (LoginPage)
  ↓ watches
Riverpod Provider (authControllerProvider)
  ↓ uses
StateNotifier (AuthController)
  ↓ calls
UseCase (LoginUseCase)
  ↓ uses
Repository Interface (AuthRepository)
  ↓ implemented by
Repository Implementation (AuthRepositoryImpl) [from GetIt]
  ↓ uses
Dio Client [from GetIt]
```

---

## Getting Started

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Generate Code (Freezed & JsonSerializable)

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Run the App

```bash
flutter run
```

---

## Code Generation

This project uses code generation for:

- **Freezed**: Immutable models, unions, and copyWith methods
- **JsonSerializable**: JSON serialization/deserialization

Files requiring code generation have:
- `part 'filename.freezed.dart';` for Freezed
- `part 'filename.g.dart';` for JsonSerializable

Run build_runner whenever you modify these files:

```bash
# One-time build
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (auto-rebuild on changes)
flutter pub run build_runner watch --delete-conflicting-outputs
```

---

## Adding New Features

To add a new feature (e.g., "watchlist"):

1. **Create folder structure**:
   ```
   features/watchlist/
   ├── domain/
   │   ├── entities/
   │   ├── repositories/
   │   └── usecases/
   ├── application/
   │   ├── providers/
   │   ├── controllers/
   │   └── state/
   └── presentation/
       ├── pages/
       └── widgets/
   ```

2. **Create infrastructure**:
   ```
   infrastructure/watchlist/
   └── watchlist_repository_impl.dart
   ```

3. **Register in DI** (`di/di.dart`):
   ```dart
   getIt.registerLazySingleton<WatchlistRepository>(
     () => WatchlistRepositoryImpl(dio: getIt<Dio>()),
   );
   ```

4. **Create Riverpod providers** (`features/watchlist/application/providers/`):
   ```dart
   final watchlistRepositoryProvider = Provider<WatchlistRepository>((ref) {
     return getIt<WatchlistRepository>();
   });
   ```

5. **Add routes** (`routing/app_router.dart`):
   ```dart
   GoRoute(
     path: '/watchlist',
     builder: (context, state) => const WatchlistPage(),
   ),
   ```

---

## Project Conventions

### Naming

- **Files**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Variables/Functions**: `camelCase`
- **Constants**: `camelCase` or `SCREAMING_SNAKE_CASE` for compile-time constants

### State Management

- Use **Riverpod** for ALL state management
- Use `StateNotifier` for complex state logic
- Use `Provider` for dependency injection
- Use `FutureProvider` / `StreamProvider` for async data

### Error Handling

- Use `Failure` classes (Freezed unions) for domain errors
- Throw exceptions in infrastructure layer
- Catch and convert to `Failure` in use cases or controllers

### Code Style

- Enable `flutter_lints` for consistent code style
- Use `final` wherever possible
- Prefer composition over inheritance
- Keep functions small and focused

---

## Example: Auth Feature Walkthrough

The auth feature demonstrates the complete architecture:

1. **Domain Layer**:
   - `User` entity (Freezed model)
   - `AuthRepository` interface
   - `LoginUseCase` business logic

2. **Infrastructure Layer**:
   - `AuthRepositoryImpl` using Dio for API calls

3. **Application Layer**:
   - `AuthState` (Freezed union: loading, authenticated, error, etc.)
   - `AuthController` (StateNotifier managing auth state)
   - `authControllerProvider` (Riverpod provider)

4. **Presentation Layer**:
   - `LoginPage` watches `authControllerProvider`
   - Displays UI based on current `AuthState`
   - Calls `controller.login()` on button press

---

## Next Steps

1. Replace API base URL in `core/networking/api_client.dart`
2. Implement actual API endpoints in repository implementations
3. Add features: stocks, portfolio, alerts, AI chat, news
4. Add authentication token storage (e.g., using `flutter_secure_storage`)
5. Implement proper error handling and user feedback
6. Add unit tests for use cases and controllers
7. Add widget tests for UI components
8. Set up CI/CD pipeline

---

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Riverpod Documentation](https://riverpod.dev/)
- [GetIt Documentation](https://pub.dev/packages/get_it)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Freezed Documentation](https://pub.dev/packages/freezed)
- [Clean Architecture Guide](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
