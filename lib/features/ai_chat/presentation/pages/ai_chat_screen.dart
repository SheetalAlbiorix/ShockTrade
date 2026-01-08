import 'package:flutter/material.dart';
import 'package:shock_app/features/ai_chat/domain/chat_message.dart';
import 'package:shock_app/features/ai_chat/presentation/ai_chat_colors.dart';
import 'package:shock_app/features/ai_chat/presentation/widgets/glass_header.dart';
import 'package:shock_app/features/ai_chat/presentation/widgets/bot_message.dart';
import 'package:shock_app/features/ai_chat/presentation/widgets/user_message.dart';
import 'package:shock_app/features/ai_chat/presentation/widgets/timestamp_chip.dart';
import 'package:shock_app/features/ai_chat/presentation/widgets/suggestion_chips.dart';
import 'package:shock_app/features/ai_chat/presentation/widgets/stock_card_widget.dart';
import 'package:shock_app/features/ai_chat/presentation/widgets/typing_indicator.dart';
import 'package:shock_app/features/ai_chat/presentation/widgets/chat_input_footer.dart';

/// AI Chat Screen - Pixel perfect implementation matching HTML design
class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMockData() {
    final now = DateTime.now();
    setState(() {
      _messages.addAll([
        ChatMessage(
          id: '1',
          content:
              'Hello! I\'m ready to analyze the Indian markets. Ask me about a specific stock like HDFC Bank, check your portfolio health, or explore general market trends.',
          type: MessageType.bot,
          timestamp: now.subtract(const Duration(minutes: 5)),
        ),
        ChatMessage(
          id: '2',
          content: 'How is Tata Motors performing today?',
          type: MessageType.user,
          timestamp: now.subtract(const Duration(minutes: 3)),
          isRead: true,
        ),
        ChatMessage(
          id: '3',
          content:
              'Tata Motors (TATAMOTORS) is showing strong bullish momentum today, driven by positive Q3 earnings expectations.',
          type: MessageType.bot,
          timestamp: now.subtract(const Duration(minutes: 2)),
          metadata: {
            'hasStockCard': true,
            'symbol': 'TATAMOTORS',
            'price': 945.65,
            'change': 1.8,
            'sparkline': [920, 925, 930, 935, 928, 940, 945],
          },
        ),
      ]);
    });
  }

  void _handleSendMessage(String text) {
    if (text.trim().isEmpty) return;

    final newMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: text,
      type: MessageType.user,
      timestamp: DateTime.now(),
      isRead: false,
    );

    setState(() {
      _messages.add(newMessage);
      _isTyping = true;
    });

    // Scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    // Simulate bot response
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isTyping = false;
          _messages.add(
            ChatMessage(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              content:
                  'I understand you\'re asking about "$text". Let me analyze that for you...',
              type: MessageType.bot,
              timestamp: DateTime.now(),
            ),
          );
        });

        Future.delayed(const Duration(milliseconds: 100), () {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AIChatColors.backgroundDark,
      body: Column(
        children: [
          // Glass header
          GlassHeader(
            onBackPressed: () => Navigator.of(context).pop(),
            onMenuPressed: () {
              // Show menu
            },
          ),

          // Chat messages area
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              itemCount: _messages.length + (_isTyping ? 2 : 1),
              itemBuilder: (context, index) {
                // Timestamp at the beginning
                if (index == 0) {
                  return TimestampChip(
                    timestamp: DateTime.now(),
                  );
                }

                final messageIndex = index - 1;

                // Typing indicator
                if (_isTyping && messageIndex == _messages.length) {
                  return const TypingIndicator();
                }

                final message = _messages[messageIndex];

                // User message
                if (message.type == MessageType.user) {
                  return UserMessage(
                    content: message.content,
                    timestamp: message.timestamp,
                    isRead: message.isRead,
                  );
                }

                // Bot message
                if (message.type == MessageType.bot) {
                  Widget? embeddedWidget;

                  // Check for stock card
                  if (message.metadata?['hasStockCard'] == true) {
                    final sparklineData =
                        message.metadata?['sparkline'] as List?;
                    embeddedWidget = StockCardWidget(
                      symbol: message.metadata?['symbol'] ?? '',
                      currentPrice: message.metadata?['price'] ?? 0.0,
                      changePercent: message.metadata?['change'] ?? 0.0,
                      isPositive: (message.metadata?['change'] ?? 0.0) >= 0,
                      sparklineData: sparklineData?.cast<double>(),
                    );
                  }

                  final widget = BotMessage(
                    content: message.content,
                    embeddedWidget: embeddedWidget,
                    showAvatar: messageIndex == 0 ||
                        _messages[messageIndex - 1].type != MessageType.bot,
                  );

                  // Add suggestion chips after first bot message
                  if (messageIndex == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget,
                        SuggestionChips(
                          suggestions: [
                            SuggestionChipData(
                              label: 'Analyze Reliance',
                              icon: Icons.show_chart,
                              onTap: () =>
                                  _handleSendMessage('Analyze Reliance'),
                            ),
                            SuggestionChipData(
                              label: 'Market Sentiment',
                              icon: Icons.sentiment_satisfied,
                              onTap: () => _handleSendMessage(
                                  'What is the market sentiment?'),
                            ),
                            SuggestionChipData(
                              label: 'Top Gainers',
                              icon: Icons.trending_up,
                              onTap: () =>
                                  _handleSendMessage('Show me top gainers'),
                            ),
                          ],
                        ),
                      ],
                    );
                  }

                  return widget;
                }

                return const SizedBox.shrink();
              },
            ),
          ),

          // Input footer
          ChatInputFooter(
            onSendMessage: _handleSendMessage,
            onAttachPressed: () {
              // Handle attach
            },
            onMicPressed: () {
              // Handle voice input
            },
          ),
        ],
      ),
    );
  }
}
