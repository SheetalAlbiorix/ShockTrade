import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  late final GenerativeModel _model;
  late final ChatSession _chatSession;

  // Singleton pattern
  static final GeminiService _instance = GeminiService._internal();
  factory GeminiService() => _instance;

  GeminiService._internal() {
    _initModel();
  }

  void _initModel() {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null) {
      throw Exception('GEMINI_API_KEY is not defined in .env');
    }

    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: apiKey,
      // System instruction to guide the model's behavior
      systemInstruction: Content.system(
          'You are a helpful and knowledgeable stock market assistant for the "ShockTrade" app. '
          'Your goal is to help users understand stock market trends, analyze specific stocks, and provide financial insights. '
          'Focus on Indian and US markets. '
          'If a user asks about non-financial topics, politely steer the conversation back to stocks and finance. '
          'Keep your answers concise and easy to read on a mobile device. '
          'Use markdown formatting for lists and bold text.'),
    );

    _chatSession = _model.startChat();
  }

  Future<String> sendMessage(String message) async {
    try {
      final response = await _chatSession.sendMessage(Content.text(message));
      final text = response.text;

      if (text == null) {
        return 'I apologize, but I couldn\'t generate a response. Please try again.';
      }

      return text;
    } catch (e) {
      print('Gemini API Error: $e');
      // Return the actual error for debugging
      return 'Error connecting to Gemini: $e\n\nPlease check if your API key has access to "gemini-pro" and billing is enabled if required.';
    }
  }

  // Method to restart chat or clear history if needed
  void restartSession() {
    _chatSession = _model.startChat();
  }
}
