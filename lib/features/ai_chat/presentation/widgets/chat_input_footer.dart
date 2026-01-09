import 'package:flutter/material.dart';
import 'package:shock_app/features/ai_chat/presentation/ai_chat_colors.dart';

/// Chat input footer with expandable textarea
class ChatInputFooter extends StatefulWidget {
  final Function(String) onSendMessage;
  final VoidCallback? onAttachPressed;
  final VoidCallback? onMicPressed;

  const ChatInputFooter({
    super.key,
    required this.onSendMessage,
    this.onAttachPressed,
    this.onMicPressed,
  });

  @override
  State<ChatInputFooter> createState() => _ChatInputFooterState();
}

class _ChatInputFooterState extends State<ChatInputFooter> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSendMessage(text);
      _controller.clear();
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AIChatColors.backgroundDark,
        border: Border(
          top: BorderSide(
            color: AIChatColors.whiteBorder10,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Attach button
                  IconButton(
                    onPressed: widget.onAttachPressed,
                    icon: const Icon(Icons.add_circle_outline),
                    color: AIChatColors.textGray400,
                    iconSize: 24,
                    style: IconButton.styleFrom(
                      fixedSize: const Size(44, 44),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Text input
                  Expanded(
                    child: Container(
                      constraints: const BoxConstraints(
                        minHeight: 44,
                        maxHeight: 128,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: const Color(0xFF2D3748), // Dark gray border
                          width: 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              focusNode: _focusNode,
                              maxLines: null,
                              textInputAction: TextInputAction.newline,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Ask about stocks...',
                                hintStyle: TextStyle(
                                  color: AIChatColors.textGray500,
                                  fontSize: 15,
                                ),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                filled: false,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                          // Mic button
                          IconButton(
                            onPressed: widget.onMicPressed,
                            icon: const Icon(Icons.mic_none),
                            color: AIChatColors.textGray400,
                            iconSize: 20,
                            padding: const EdgeInsets.all(8),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Send button
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: _hasText
                          ? AIChatColors.primary
                          : AIChatColors.textGray600,
                      shape: BoxShape.circle,
                      boxShadow: _hasText
                          ? [
                              BoxShadow(
                                color: AIChatColors.primary.withOpacity(0.25),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _hasText ? _sendMessage : null,
                        borderRadius: BorderRadius.circular(22),
                        child: const Center(
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Disclaimer
              const SizedBox(height: 12),
              const Text(
                'AI insights are for informational purposes only, not financial advice.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AIChatColors.textGray600,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
