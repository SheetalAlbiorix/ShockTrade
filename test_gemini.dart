import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {
  // Hardcoding key for test as .env loading in raw script might need setup
  final apiKey = 'AIzaSyDLZi4uBIwW1As5faPcFsGeQk9PcQ3jDwo';

  print('Testing Gemini API with key: \${apiKey.substring(0, 10)}...');

  // Create a client purely for listing models (not part of GenerativeModel class directly)
  // Note: listModels is a top-level function or on a specific client class depending on package version.
  // Actually, checking documentation or source, listModels might not be readily available on GenerativeModel.
  // Let's try a direct raw REST call if package doesn't support it easily,
  // OR just try 'gemini-1.0-pro' which is often the fallback.

  // Reverting to test a known valid model name.
  print('Retrying with "gemini-1.0-pro" (stable version)...');
  final modelStable = GenerativeModel(
    model: 'gemini-1.0-pro',
    apiKey: apiKey,
  );

  try {
    print('Sending "Hello" to gemini-1.0-pro...');
    final response = await modelStable.generateContent([Content.text('Hello')]);
    print('Response: \${response.text}');
  } catch (e) {
    print('gemini-1.0-pro failed: $e');
  }
}
