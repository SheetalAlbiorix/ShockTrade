import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/features/ai_chat/data/openrouter_service.dart';
import 'package:shock_app/features/ai_chat/domain/chat_message.dart';
import 'package:shock_app/features/ai_chat/data/speech_service.dart';

// Chat State to hold messages and loading status
class ChatState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? error;
  final bool isListening;

  ChatState({
    required this.messages,
    this.isLoading = false,
    this.error,
    this.isListening = false,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? error,
    bool? isListening,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isListening: isListening ?? this.isListening,
    );
  }
}

// Chat Controller
class ChatController extends StateNotifier<ChatState> {
  final OpenRouterService _openRouterService;
  final SpeechService _speechService;

  ChatController(this._openRouterService, this._speechService)
      : super(ChatState(
          messages: [
            ChatMessage(
              id: DateTime.now().toString(),
              content:
                  "Hello! I'm your ShockTrade AI assistant. Ask me anything about Indian stocks, market trends, or portfolio analysis.",
              type: MessageType.bot,
              timestamp: DateTime.now(),
            ),
          ],
        ));

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // Stop listening if active
    if (state.isListening) {
      await _speechService.stopListening();
    }

    // Add user message
    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: text,
      type: MessageType.user,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isLoading: true,
      error: null,
      isListening: false, // Ensure listening is off in UI
    );

    try {
      // Get response from OpenRouter
      final responseText = await _openRouterService.sendMessage(text);

      final botMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: responseText,
        type: MessageType.bot,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(
        messages: [...state.messages, botMessage],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: "Failed to get response. Please try again.",
      );

      // Optionally add an error message to the chat
      final errorMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content:
            "I'm having trouble connecting right now. Please check your internet connection.",
        type: MessageType.bot,
        timestamp: DateTime.now(),
      );
      state = state.copyWith(
        messages: [...state.messages, errorMessage],
      );
    }
  }

  // Toggle voice listening
  Future<void> toggleListening(Function(String) onTextUpdate) async {
    if (state.isListening) {
      await _speechService.stopListening();
      state = state.copyWith(isListening: false);
    } else {
      state = state.copyWith(isListening: true);
      final success = await _speechService.startListening(
        onResult: (text) {
          onTextUpdate(text);
        },
      );

      // If failed to start, revert state and set error
      if (!success) {
        state = state.copyWith(
          isListening: false,
          error: "Voice Unavailable. Please check microphone permissions.",
        );
      } else {
        // If started successfully, ensure state sync
        if (!_speechService.isListening) {
          state = state.copyWith(isListening: false);
        }
      }
    }
  }

  // Method to restart chat or clear history if needed
  void restartSession() {
    _openRouterService.restartSession();
    _addInitialGreeting();
  }

  void _addInitialGreeting() {
    state = state.copyWith(
      messages: [
        ChatMessage(
          id: DateTime.now().toString(),
          content:
              "Hello! I'm your ShockTrade AI assistant. Ask me anything about Indian stocks, market trends, or portfolio analysis.",
          type: MessageType.bot,
          timestamp: DateTime.now(),
        ),
      ],
    );
  }
}

// Provider
final chatControllerProvider =
    StateNotifierProvider<ChatController, ChatState>((ref) {
  return ChatController(OpenRouterService(), SpeechService());
});
