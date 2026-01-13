import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/core/providers/navigation_provider.dart';
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
import 'package:shock_app/features/ai_chat/application/chat_controller.dart';

/// AI Chat Screen - Pixel perfect implementation matching HTML design
class AIChatScreen extends ConsumerStatefulWidget {
  const AIChatScreen({super.key});

  @override
  ConsumerState<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends ConsumerState<AIChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();

  bool _isSending = false;

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _handleSendMessage(String text) async {
    if (text.trim().isEmpty || _isSending) return;

    setState(() {
      _isSending = true;
    });

    try {
      _textController.clear();

      // Scroll to bottom immediately to show user message
      Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);

      await ref.read(chatControllerProvider.notifier).sendMessage(text);

      // Scroll to bottom after response
      Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatControllerProvider);
    final messages = chatState.messages;
    final isTyping = chatState.isLoading;

    // Scroll to bottom when new messages arrive or show error
    ref.listen(chatControllerProvider, (previous, next) {
      if (next.messages.length > (previous?.messages.length ?? 0)) {
        Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
      }

      if (next.error != null && next.error != previous?.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: AIChatColors.danger,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: AIChatColors.backgroundDark,
      body: Column(
        children: [
          // Glass header
          GlassHeader(
            onBackPressed: () {
              ref.read(currentTabIndexProvider.notifier).state = 0;
            },
            onMenuPressed: () {
              ref.read(chatControllerProvider.notifier).restartSession();
            },
          ),

          // Chat messages area
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              itemCount: messages.length + (isTyping ? 2 : 1),
              itemBuilder: (context, index) {
                // Timestamp at the beginning
                if (index == 0) {
                  return TimestampChip(
                    timestamp: DateTime.now(),
                  );
                }

                final messageIndex = index - 1;

                // Typing indicator
                if (isTyping && messageIndex == messages.length) {
                  return const TypingIndicator();
                }

                if (messageIndex >= messages.length) {
                  return const SizedBox.shrink();
                }

                final message = messages[messageIndex];

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
                      sparklineData: sparklineData
                          ?.map((e) => (e as num).toDouble())
                          .toList(),
                    );
                  }

                  final widget = BotMessage(
                    content: message.content,
                    embeddedWidget: embeddedWidget,
                    showAvatar: messageIndex == 0 ||
                        (messageIndex > 0 &&
                            messages[messageIndex - 1].type != MessageType.bot),
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
            controller: _textController,
            isListening: chatState.isListening,
            onSendMessage: _handleSendMessage,
            onAttachPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Attachments coming soon!')),
              );
            },
            onMicPressed: () {
              ref.read(chatControllerProvider.notifier).toggleListening((text) {
                if (_isSending) return; // Ignore updates while sending
                _textController.text = text;
                // Set cursor to end
                _textController.selection = TextSelection.fromPosition(
                  TextPosition(offset: _textController.text.length),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
