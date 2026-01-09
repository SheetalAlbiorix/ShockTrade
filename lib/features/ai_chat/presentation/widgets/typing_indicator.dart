import 'package:flutter/material.dart';
import 'package:shock_app/features/ai_chat/presentation/ai_chat_colors.dart';

/// Typing indicator animation for bot
class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Avatar (faded)
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF135bec).withOpacity(0.5),
                  const Color(0xFF4F46E5).withOpacity(0.5),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.smart_toy,
              color: Colors.white.withOpacity(0.5),
              size: 20,
            ),
          ),

          const SizedBox(width: 12),

          // Typing bubble
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _BouncingDot(controller: _controller, delay: 0),
                const SizedBox(width: 4),
                _BouncingDot(controller: _controller, delay: 150),
                const SizedBox(width: 4),
                _BouncingDot(controller: _controller, delay: 300),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BouncingDot extends StatelessWidget {
  final AnimationController controller;
  final int delay;

  const _BouncingDot({
    required this.controller,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final animation = Tween<double>(begin: 0, end: -8).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          delay / 1200,
          (delay + 400) / 1200,
          curve: Curves.easeInOut,
        ),
      ),
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, animation.value),
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AIChatColors.textGray400,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
