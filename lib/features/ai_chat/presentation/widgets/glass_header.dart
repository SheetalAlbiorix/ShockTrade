import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shock_app/features/ai_chat/presentation/ai_chat_colors.dart';

/// Glass header with blur effect for AI chat
class GlassHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onMenuPressed;

  const GlassHeader({
    super.key,
    this.onBackPressed,
    this.onMenuPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: AIChatColors.glassHeader,
            border: Border(
              bottom: BorderSide(
                color: AIChatColors.whiteBorder5,
                width: 1,
              ),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Container(
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button
                  IconButton(
                    onPressed: onBackPressed,
                    icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                    color: AIChatColors.textWhite.withOpacity(0.8),
                    style: IconButton.styleFrom(
                      backgroundColor: AIChatColors.whiteHover5,
                    ),
                  ),

                  // Title and status
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'ShockTrade AI',
                        style: TextStyle(
                          color: AIChatColors.textWhite,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AIChatColors.success,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Online',
                        style: TextStyle(
                          color: Color(0xFF22c55e),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  // Menu button
                  IconButton(
                    onPressed: onMenuPressed,
                    icon: const Icon(Icons.more_vert, size: 24),
                    color: AIChatColors.textWhite.withOpacity(0.8),
                    style: IconButton.styleFrom(
                      backgroundColor: AIChatColors.whiteHover5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
