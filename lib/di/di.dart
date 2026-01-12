import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shock_app/core/networking/api_client.dart';
import 'package:shock_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:shock_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:shock_app/infrastructure/auth/auth_repository_impl.dart';
import 'package:shock_app/core/networking/indian_api_client.dart';
import 'package:shock_app/features/stock_detail/domain/stock_repository.dart';
import 'package:shock_app/features/stock_detail/data/stock_repository_impl.dart';

final getIt = GetIt.instance;

/// Configure all dependencies for the application
Future<void> configureDependencies() async {
  // Core - Networking
  getIt.registerLazySingleton<Dio>(() => createDioClient());

  // Networking
  getIt.registerLazySingleton<IndianApiClient>(
      () => IndianApiClient(getIt<Dio>()));

  // Infrastructure - Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(dio: getIt<Dio>()),
  );

  // Stock Feature
  getIt.registerLazySingleton<StockRepository>(
    () => StockRepositoryImpl(getIt<IndianApiClient>()),
  );

  // Domain - Use Cases
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(repository: getIt<AuthRepository>()),
  );

  // Add more feature dependencies here as the app grows
  // Example:
  // getIt.registerLazySingleton<StocksRepository>(() => StocksRepositoryImpl(...));
}
