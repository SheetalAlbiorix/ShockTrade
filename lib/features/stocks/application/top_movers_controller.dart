import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/di/di.dart';
import 'package:shock_app/features/stock_detail/domain/models.dart';
import 'package:shock_app/features/stock_detail/domain/stock_repository.dart';

class TopMoversController
    extends StateNotifier<AsyncValue<List<StockDetailState>>> {
  final StockRepository _repository;

  TopMoversController(this._repository) : super(const AsyncValue.loading()) {
    _loadTopMovers();
  }

  Future<void> _loadTopMovers() async {
    // List of stocks to display in Top Movers
    final symbols = [
      'RELIANCE.NS',
      'TCS.NS',
      'HDFCBANK.NS',
      'INFY.NS',
      'ICICIBANK.NS',
      'SBIN.NS',
      'BHARTIARTL.NS',
      'ITC.NS',
    ];

    try {
      final futures =
          symbols.map((symbol) => _repository.getStockDetails(symbol));
      final results = await Future.wait(futures);
      state = AsyncValue.data(results);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final topMoversProvider = StateNotifierProvider<TopMoversController,
    AsyncValue<List<StockDetailState>>>((ref) {
  return TopMoversController(getIt<StockRepository>());
});
