import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/di/di.dart';
import 'package:shock_app/features/stocks/domain/models/market_stock.dart';
import 'package:shock_app/features/stocks/domain/repositories/market_repository.dart';

class TopMoversController
    extends StateNotifier<AsyncValue<List<MarketStock>>> {
  final MarketRepository _repository;

  TopMoversController(this._repository) : super(const AsyncValue.loading()) {
    _loadTopMovers();
  }

  Future<void> _loadTopMovers() async {
    try {
      // Fetch trending stocks which contains top gainers
      final stocks = await _repository.getTrendingStocks();
      state = AsyncValue.data(stocks);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() => _loadTopMovers();
}

final topMoversProvider = StateNotifierProvider<TopMoversController,
    AsyncValue<List<MarketStock>>>((ref) {
  return TopMoversController(getIt<MarketRepository>());
});
