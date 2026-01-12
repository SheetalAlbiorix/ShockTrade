import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';

class WatchlistSearchBar extends StatefulWidget {
  final ValueChanged<String>? onChanged;

  const WatchlistSearchBar({
    super.key,
    this.onChanged,
  });

  @override
  State<WatchlistSearchBar> createState() => _WatchlistSearchBarState();
}

class _WatchlistSearchBarState extends State<WatchlistSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<bool> _showClear = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _showClear.value = _controller.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _showClear.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.premiumSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.premiumCardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ValueListenableBuilder<bool>(
        valueListenable: _showClear,
        builder: (context, hasText, _) {
          return TextField(
            controller: _controller,
            onChanged: widget.onChanged,
            style: const TextStyle(
              color: AppColors.darkTextPrimary,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              hintText: 'Search stocks (e.g., RELIANCE, TCS)',
              hintStyle: TextStyle(
                color: AppColors.darkTextSecondary.withOpacity(0.7),
                fontSize: 15,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.darkTextSecondary,
              ),
              suffixIcon: hasText
                  ? IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.darkTextSecondary,
                        size: 20,
                      ),
                      onPressed: () {
                        _controller.clear();
                        widget.onChanged?.call('');
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              isDense: true,
            ),
            cursorColor: AppColors.premiumAccentBlue,
          );
        },
      ),
    );
  }
}
