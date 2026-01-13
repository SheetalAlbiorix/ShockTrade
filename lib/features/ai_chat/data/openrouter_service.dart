import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenRouterService {
  final Dio _dio = Dio();
  final List<Map<String, dynamic>> _history = [];

  // Singleton pattern
  static final OpenRouterService _instance = OpenRouterService._internal();
  factory OpenRouterService() => _instance;

  static const String _baseUrl = 'https://openrouter.ai/api/v1/';
  // Using a free model as default, can be changed
  static const String _defaultModel = 'google/gemini-2.0-flash-lite-001';

  // System instruction
  static const String _systemInstruction =
      'You are a helpful and knowledgeable stock market assistant for the "ShockTrade" app. '
      'Your PRIMARY focus is the **Indian Stock Market** (NSE/BSE). '
      'You can also provide updates on **Global Market News** and economic trends that impact the Indian market. '
      'If a user asks about specific non-Indian stocks, briefly answer but try to relate it back to the Indian context if possible. '
      'If a user asks about non-financial topics, politely steer the conversation back to stocks and finance. '
      'Keep your answers concise and easy to read on a mobile device. '
      'Use markdown formatting for lists and bold text.';

  OpenRouterService._internal() {
    _init();
  }

  void _init() {
    final apiKey = dotenv.env['OPENROUTER_API_KEY'];
    if (apiKey == null) {
      throw Exception('OPENROUTER_API_KEY is not defined in .env');
    }

    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.headers = {
      'Authorization': 'Bearer $apiKey',
      'HTTP-Referer':
          'https://github.com/shocktrade', // Required by OpenRouter for ranking
      'X-Title': 'ShockTrade', // Optional
      'Content-Type': 'application/json',
    };

    // Initialize history with system message
    _resetHistory();
  }

  void _resetHistory() {
    _history.clear();
    _history.add({
      'role': 'system',
      'content': _systemInstruction,
    });
  }

  Future<String> sendMessage(String message) async {
    try {
      // Add user message to history
      _history.add({
        'role': 'user',
        'content': message,
      });

      print('OpenRouter Base URL: ${_dio.options.baseUrl}');
      print('OpenRouter Request Path: chat/completions');

      final response = await _dio.post(
        'chat/completions',
        options: Options(
          validateStatus: (status) => true,
        ),
        data: {
          'model': _defaultModel,
          'messages': _history,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['choices'] != null && (data['choices'] as List).isNotEmpty) {
          final content = data['choices'][0]['message']['content'] as String;

          // Add assistant response to history
          _history.add({
            'role': 'assistant',
            'content': content,
          });

          return content;
        }
      }

      return 'I received an empty response. Please try again.';
    } catch (e) {
      print('OpenRouter API Error: $e');
      if (e is DioException) {
        print('Dio Error Response: ${e.response?.data}');
      }
      return 'Error connecting to OpenRouter: $e';
    }
  }

  void restartSession() {
    _resetHistory();
  }
}
