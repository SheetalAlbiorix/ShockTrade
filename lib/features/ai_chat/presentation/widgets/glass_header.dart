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
                  Theme(
                    data: Theme.of(context).copyWith(
                      popupMenuTheme: PopupMenuThemeData(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                              color: AIChatColors.whiteBorder10, width: 1),
                        ),
                        color: AIChatColors.surfaceDark,
                        elevation: 8,
                        textStyle:
                            const TextStyle(color: AIChatColors.textWhite),
                      ),
                    ),
                    child: PopupMenuButton<String>(
                      offset: const Offset(0, 48),
                      onSelected: (value) {
                        if (value == 'clear_chat') {
                          onMenuPressed?.call();
                        }
                      },
                      icon: const Icon(Icons.more_vert, size: 24),
                      color: AIChatColors.surfaceDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                            color: AIChatColors.whiteBorder10, width: 1),
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: AIChatColors.whiteHover5,
                        foregroundColor:
                            AIChatColors.textWhite.withOpacity(0.8),
                      ),
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem<String>(
                          value: 'clear_chat',
                          height: 48,
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AIChatColors.danger.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.delete_outline_rounded,
                                  color: AIChatColors.danger,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Clear Chat',
                                style: TextStyle(
                                  color: AIChatColors.textWhite,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
