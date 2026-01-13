import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:shock_app/features/ai_chat/presentation/ai_chat_colors.dart';

/// Bot message bubble with avatar and content
class BotMessage extends StatelessWidget {
  final String content;
  final Widget? embeddedWidget;
  final bool showAvatar;

  const BotMessage({
    super.key,
    required this.content,
    this.embeddedWidget,
    this.showAvatar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Avatar
          if (showAvatar)
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF135bec), Color(0xFF4F46E5)],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF135bec).withOpacity(0.2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const Icon(
                Icons.smart_toy,
                color: Colors.white,
                size: 20,
              ),
            )
          else
            const SizedBox(width: 36),

          const SizedBox(width: 12),

          // Message content
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bot name label
                if (showAvatar)
                  const Padding(
                    padding: EdgeInsets.only(left: 4, bottom: 4),
                    child: Text(
                      'ShockBot',
                      style: TextStyle(
                        color: AIChatColors.textGray400,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                // Message bubble
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width *
                        (embeddedWidget != null ? 0.90 : 0.85),
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AIChatColors.bubbleReceived,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(16),
                    ),
                    border: Border.all(
                      color: AIChatColors.whiteBorder5,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Main text content
                      MarkdownBody(
                        data: content,
                        styleSheet: MarkdownStyleSheet(
                          p: const TextStyle(
                            color: AIChatColors.textGray100,
                            fontSize: 15,
                            height: 1.5,
                          ),
                          strong: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          code: const TextStyle(
                            color: AIChatColors.primary,
                            backgroundColor: Color(0x206366F1),
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),

                      // Embedded widget (stock card, etc.)
                      if (embeddedWidget != null) ...[
                        const SizedBox(height: 12),
                        embeddedWidget!,
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
