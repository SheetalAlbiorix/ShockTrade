import 'package:shock_app/core/networking/indian_api_client.dart';
import 'package:shock_app/features/stocks/domain/models/market_stock.dart';
import 'package:shock_app/features/stocks/domain/repositories/market_repository.dart';

class MarketRepositoryImpl implements MarketRepository {
  final IndianApiClient _apiClient;

  MarketRepositoryImpl(this._apiClient);

  @override
  Future<List<MarketStock>> getNSEMostActive() async {
    try {
      final data = await _apiClient.getNSEMostActive();
      return data.map((item) => MarketStock.fromJson(item as Map<String, dynamic>)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MarketStock>> getBSEMostActive() async {
    try {
      final data = await _apiClient.getBSEMostActive();
      return data.map((item) => MarketStock.fromJson(item as Map<String, dynamic>)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MarketStock>> getTrendingStocks() async {
    try {
      final data = await _apiClient.getTrendingStocks();
      return data.map((item) => MarketStock.fromJson(item as Map<String, dynamic>)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
