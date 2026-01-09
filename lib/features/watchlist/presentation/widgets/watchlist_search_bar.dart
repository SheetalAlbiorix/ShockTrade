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
      color: AppColors.premiumBackgroundDark,
      // Removed vertical padding as it's handled by parent or can be minimized
      padding: const EdgeInsets.symmetric(vertical: 4), 
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.premiumSurface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.premiumCardBorder,
            width: 1,
          ),
        ),
        child: ValueListenableBuilder<bool>(
          valueListenable: _showClear,
          builder: (context, hasText, _) {
            return TextField(
              controller: _controller,
              onChanged: widget.onChanged,
              style: const TextStyle(
                color: AppColors.darkTextPrimary,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                hintText: 'Search stocks (e.g., RELIANCE, TCS)',
                hintStyle: const TextStyle(
                  color: AppColors.darkTextSecondary,
                  fontSize: 15,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.darkTextSecondary,
                  size: 22,
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
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
              ),
              cursorColor: AppColors.premiumAccentBlue,
            );
          },
        ),
      ),
    );
  }
}
