import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/di/di.dart';
import 'package:shock_app/features/stocks/domain/models/market_stock.dart';
import 'package:shock_app/features/stocks/domain/repositories/market_repository.dart';

final nseMostActiveProvider = FutureProvider<List<MarketStock>>((ref) async {
  final repository = getIt<MarketRepository>();
  return repository.getNSEMostActive();
});

final bseMostActiveProvider = FutureProvider<List<MarketStock>>((ref) async {
  final repository = getIt<MarketRepository>();
  return repository.getBSEMostActive();
});

final trendingStocksProvider = FutureProvider<List<MarketStock>>((ref) async {
  final repository = getIt<MarketRepository>();
  return repository.getTrendingStocks();
});
