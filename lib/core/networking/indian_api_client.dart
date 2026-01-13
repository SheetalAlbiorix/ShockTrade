import 'package:dio/dio.dart';
import 'package:shock_app/core/config/env.dart';

class IndianApiClient {
  final Dio _dio;
  static const String _baseUrl = 'https://stock.indianapi.in';

  IndianApiClient(this._dio) {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.headers = {
      'X-Api-Key': Env.indianStockApiKey,
      'Content-Type': 'application/json',
    };
  }

  Future<List<dynamic>> getNSEMostActive() async {
    try {
      final response = await _dio.get('/NSE_most_active');
      if (response.statusCode == 200 && response.data != null) {
        return response.data as List<dynamic>;
      } else {
        throw Exception('Failed to load NSE most active stocks');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> getBSEMostActive() async {
    try {
      final response = await _dio.get('/BSE_most_active');
      if (response.statusCode == 200 && response.data != null) {
        return response.data as List<dynamic>;
      } else {
        throw Exception('Failed to load BSE most active stocks');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> getTrendingStocks() async {
    try {
      final response = await _dio.get('/trending');
      if (response.statusCode == 200 && response.data != null) {
        if (response.data is Map<String, dynamic>) {
          final trendingData = response.data['trending_stocks'] as Map<String, dynamic>?;
          return trendingData?['top_gainers'] as List<dynamic>? ?? [];
        }
        return response.data as List<dynamic>;
      } else {
        throw Exception('Failed to load trending stocks');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getStockDetails(String name) async {
    try {
      final response = await _dio.get(
        '/stock',
        queryParameters: {
          'name': name,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load stock data: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 404 || e.response?.statusCode == 422) {
          throw Exception('Stock not found or API error: ${e.response?.data}');
        }
      }
      rethrow;
    }
  }
}
