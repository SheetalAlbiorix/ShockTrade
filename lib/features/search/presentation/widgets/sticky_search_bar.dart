import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';
import 'dart:async';

class StickySearchBar extends StatefulWidget {
  final ValueChanged<String>? onChanged;

  const StickySearchBar({super.key, this.onChanged});

  @override
  State<StickySearchBar> createState() => _StickySearchBarState();
}

class _StickySearchBarState extends State<StickySearchBar> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  final FocusNode _focusNode = FocusNode();
  final ValueNotifier<bool> _hasText = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    // Auto-focus when screen opens as per requirements
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
    
    // Listen to text changes to show/hide clear button
    _controller.addListener(() {
      _hasText.value = _controller.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    _focusNode.dispose();
    _hasText.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      widget.onChanged?.call(query);
    });
  }

  void _clearSearch() {
    _controller.clear();
    widget.onChanged?.call('');
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        valueListenable: _hasText,
        builder: (context, hasText, child) {
          return TextField(
            controller: _controller,
            focusNode: _focusNode,
            onChanged: _onSearchChanged,
            style: const TextStyle(
              color: AppColors.darkTextPrimary,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              hintText: 'Search for Reliance, Tata Motors…',
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
                      onPressed: _clearSearch,
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
