import 'package:dio/dio.dart';

class IndianApiClient {
  final Dio _dio;
  // TODO: Move this to environment variables in production
  static const String _apiKey =
      'sk-live-xAQ6loMs8DHtSawG2ThEkSJumtWvEOF4wxeCA1iG';
  static const String _baseUrl = 'https://stock.indianapi.in';

  IndianApiClient(this._dio) {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.headers = {
      'X-Api-Key': _apiKey,
      'Content-Type': 'application/json',
    };
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
          // Handle specific API errors if needed
          throw Exception('Stock not found or API error: ${e.response?.data}');
        }
      }
      rethrow;
    }
  }
}
