import 'package:shock_app/features/stock_detail/domain/models.dart';

abstract class StockRepository {
  /// Fetch comprehensive details for a stock
  Future<StockDetailState> getStockDetails(String symbol);
}
