import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final SpeechToText _speech = SpeechToText();
  bool _isInitialized = false;

  // Singleton pattern
  static final SpeechService _instance = SpeechService._internal();
  factory SpeechService() => _instance;

  SpeechService._internal();

  /// Initialize the speech recognition service
  Future<bool> init() async {
    if (_isInitialized) return true;
    try {
      _isInitialized = await _speech.initialize(
        onError: (e) => debugPrint('Speech API Error: $e'),
        onStatus: (s) => debugPrint('Speech API Status: $s'),
        debugLogging: true,
      );

      if (_isInitialized) {
        var locales = await _speech.locales();
        debugPrint(
            'Available Locales: ${locales.map((e) => e.localeId).join(', ')}');
      }

      return _isInitialized;
    } catch (e) {
      debugPrint('Speech initialization failed: $e');
      return false;
    }
  }

  /// Start listening for speech
  Future<bool> startListening({
    required Function(String) onResult,
    String localeId = 'en_IN', // Changed default to en_IN
  }) async {
    // Ensure clean state
    if (_speech.isListening) {
      await _speech.stop();
      await Future.delayed(const Duration(milliseconds: 100));
    }

    if (!_isInitialized) {
      final success = await init();
      if (!success) {
        debugPrint('SpeechService: Init failed');
        return false;
      }
      // Small delay after init before listening (helps on some devices)
      await Future.delayed(const Duration(milliseconds: 100));
    }

    try {
      await _speech.listen(
        onResult: (result) {
          debugPrint(
              'Speech Result: ${result.recognizedWords} (Final: ${result.finalResult})');
          if (result.finalResult || result.recognizedWords.isNotEmpty) {
            onResult(result.recognizedWords);
          }
        },
        localeId: localeId,
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 5), // Increased pause duration
        cancelOnError: false, // Changed to false to be more resilient
        partialResults: true,
      );
      return true;
    } catch (e) {
      debugPrint('SpeechService: Listen failed: $e');
      return false;
    }
  }

  /// Stop listening
  Future<void> stopListening() async {
    if (_speech.isListening) {
      await _speech.stop();
    }
  }

  /// Check if listening
  bool get isListening => _speech.isListening;
}
