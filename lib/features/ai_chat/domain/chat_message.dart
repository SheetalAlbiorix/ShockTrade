/// Message types for AI chat
enum MessageType {
  user,
  bot,
  timestamp,
}

/// Chat message model
class ChatMessage {
  final String id;
  final String content;
  final MessageType type;
  final DateTime timestamp;
  final bool isRead;
  final Map<String, dynamic>? metadata; // For stock cards, suggestions, etc.

  const ChatMessage({
    required this.id,
    required this.content,
    required this.type,
    required this.timestamp,
    this.isRead = false,
    this.metadata,
  });
}
