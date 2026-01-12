import 'package:flutter/material.dart';
import 'package:shock_app/core/config/app_colors.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final Color iconBgColor;
  final String? trailingText;
  final Color? trailingTextColor;
  final bool isSwitch;
  final bool switchValue;
  final IconData? trailingIcon;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.iconBgColor,
    this.trailingText,
    this.trailingTextColor,
    this.isSwitch = false,
    this.switchValue = false,
    this.trailingIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  // In dark mode we use white for icon inside the bubble mostly, 
                  // but passing color is supported if we want to mimic the light mode behavior 
                  // or specific colored icons.
                  // For this implementation I'll respect the passed color if distinct,
                  // but the design used white in dark mode.
                  // Let's use the passed iconColor but maybe adjust opacity if needed.
                  // Actually the previous implementation used `Colors.white` hardcoded.
                  // The user liked the previous implementation. I will stick to Colors.white
                  // for the icon inside the dark bubble, or maybe use the iconColor if it's vibrant.
                  // In the provided HTML: dark:text-white inside the bubble.
                  // So I will keep it white.
                  color: Colors.white, 
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              
              // Title
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              
              // Trailing
              if (isSwitch)
                Switch(
                  value: switchValue,
                  onChanged: (val) {
                    if (onTap != null) onTap!();
                  },
                  activeColor: AppColors.primaryBlue,
                )
              else if (trailingText != null)
                Row(
                  children: [
                    Text(
                      trailingText!,
                      style: TextStyle(
                        color: trailingTextColor ?? AppColors.darkTextSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right,
                      color: AppColors.darkTextSecondary,
                      size: 20,
                    ),
                  ],
                )
              else
                Icon(
                  trailingIcon ?? Icons.chevron_right,
                  color: AppColors.darkTextSecondary,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
