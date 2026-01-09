import 'package:flutter/material.dart';
import 'package:shock_app/features/ai_chat/presentation/ai_chat_colors.dart';

/// Suggestion chip model
class SuggestionChipData {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const SuggestionChipData({
    required this.label,
    required this.icon,
    required this.onTap,
  });
}

/// Horizontal scrollable suggestion chips
class SuggestionChips extends StatelessWidget {
  final List<SuggestionChipData> suggestions;

  const SuggestionChips({
    super.key,
    required this.suggestions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 48, bottom: 32),
      child: SizedBox(
        height: 32,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: suggestions.length,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final suggestion = suggestions[index];
            return _SuggestionChip(
              label: suggestion.label,
              icon: suggestion.icon,
              onTap: suggestion.onTap,
            );
          },
        ),
      ),
    );
  }
}

class _SuggestionChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _SuggestionChip({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9999),
        child: Container(
          height: 32,
          padding: const EdgeInsets.only(left: 12, right: 16),
          decoration: BoxDecoration(
            color: AIChatColors.surfaceDark,
            borderRadius: BorderRadius.circular(9999),
            border: Border.all(
              color: AIChatColors.whiteBorder10,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: AIChatColors.primary,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
