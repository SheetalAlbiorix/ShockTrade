import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height = 56,
    this.backgroundColor = AppColors.navActiveColor, // Default to Cyan
    this.textColor = Colors.black, // Cyan usually has black text for contrast
    this.borderRadius = 16,
    this.padding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          textStyle: textStyle ??
              const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
        ),
        child: Text(text),
      ),
    );
  }
}
