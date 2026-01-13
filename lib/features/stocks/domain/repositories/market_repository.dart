import 'package:shock_app/features/stocks/domain/models/market_stock.dart';

abstract class MarketRepository {
  Future<List<MarketStock>> getNSEMostActive();
  Future<List<MarketStock>> getBSEMostActive();
  Future<List<MarketStock>> getTrendingStocks();
}
