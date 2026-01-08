import 'package:flutter/material.dart';

/// Modern premium dark color system for trading apps
class AppColors {
  // Brand Colors
  static const Color primaryBlue = Color(0xFF135bec); // Updated from HTML
  static const Color primaryDark = Color(0xFF0D47A1);
  static const Color accentGreen = Color(0xFF00C853);

  // Stock Market Specific Colors
  static const Color bullishGreen = Color(0xFF10b981); // Updated from HTML
  static const Color bearishRed = Color(0xFFef4444); // Updated from HTML
  static const Color neutralGray = Color(0xFF757575);

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFF6F6F8); // Updated from HTML
  static const Color lightSurface = Color(0xFFFFFFFF);

  static const Color lightCardBackground = Color(0xFFF1F3F8);

  static const Color lightTextPrimary = Color(0xFF0F1222);

  static const Color lightTextSecondary = Color(0xFF6B7280);

  static const Color lightDivider = Color(0xFFE3E6EF);

  // Dark Theme Colors (Updated from HTML)
  static const Color darkBackground = Color(0xFF101622); // New from HTML
  static const Color darkSurface = Color(0xFF1A202C); // New from HTML
  static const Color darkCardBackground = Color(0xFF252B48);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0B8C8);
  static const Color darkDivider = Color(0xFF2D3348);

  // Navigation Bar Colors
  static const Color navBackground = Color(0xFF0B0F14);
  static const Color navActiveColor =
      Color(0xFF135bec); // Updated to match primary
  static const Color navInactiveColor = Color(0xFF6B7280);

  // Chart Colors
  static const Color chartGreen = Color(0xFF10b981); // Match bullish
  static const Color chartRed = Color(0xFFef4444); // Match bearish
  static const Color chartBlue = Color(0xFF3b82f6); // For moving average
  static const Color chartOrange = Color(0xFFFF7043);
  static const Color chartPurple = Color(0xFFAB47BC);

  // Glass-morphism effect
  static Color glassBackground = Colors.white.withOpacity(0.03);
  static Color glassBorder = Colors.white.withOpacity(0.05);

  // ─────────────────────────────────────────────
  // Gradients (Modern Depth)
  // ─────────────────────────────────────────────

  static const LinearGradient bullishGradient = LinearGradient(
    colors: [Color(0xFF10b981), Color(0xFF64DD17)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient bearishGradient = LinearGradient(
    colors: [Color(0xFFef4444), Color(0xFFE57373)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF135bec), Color(0xFF1976D2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // 52-week range gradient
  static const LinearGradient weekRangeGradient = LinearGradient(
    colors: [Color(0xFFef4444), Color(0xFFeab308), Color(0xFF10b981)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
