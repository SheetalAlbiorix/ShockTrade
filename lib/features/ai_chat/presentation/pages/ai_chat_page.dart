import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'package:shock_app/core/config/app_strings.dart';

/// AI Chat page - chat interface for AI-powered stock insights
class AIChatPage extends ConsumerStatefulWidget {
  const AIChatPage({super.key});

  @override
  ConsumerState<AIChatPage> createState() => _AIChatPageState();
}

class _AIChatPageState extends ConsumerState<AIChatPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkSurface,
        title: const Text(
          AppStrings.aiAssistant,
          style: TextStyle(color: AppColors.darkTextPrimary),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: AppColors.darkTextSecondary),
            onPressed: () {
              // TODO: Show chat history
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat messages area
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.navActiveColor.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.auto_awesome,
                      size: 48,
                      color: AppColors.navActiveColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'AI Stock Assistant',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColors.darkTextPrimary,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'Ask me anything about stocks, market trends, or investment strategies',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.darkTextSecondary,
                          ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Quick suggestion chips
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      _buildSuggestionChip('Top gainers today?'),
                      _buildSuggestionChip('Explain P/E ratio'),
                      _buildSuggestionChip('Analyze RELIANCE'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Message input area
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.darkSurface,
              border: Border(
                top: BorderSide(
                  color: AppColors.darkDivider,
                  width: 1,
                ),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: const TextStyle(color: AppColors.darkTextPrimary),
                      decoration: InputDecoration(
                        hintText: AppStrings.typeMessage,
                        hintStyle:
                            const TextStyle(color: AppColors.darkTextSecondary),
                        filled: true,
                        fillColor: AppColors.darkCardBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.navActiveColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        // TODO: Send message
                        _messageController.clear();
                      },
                      icon: const Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(String text) {
    return ActionChip(
      label: Text(
        text,
        style: const TextStyle(
          color: AppColors.navActiveColor,
          fontSize: 12,
        ),
      ),
      backgroundColor: AppColors.navActiveColor.withOpacity(0.15),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onPressed: () {
        _messageController.text = text;
      },
    );
  }
}
