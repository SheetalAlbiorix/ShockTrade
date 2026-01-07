import 'package:flutter/material.dart';

/// App-wide color constants for stock market theme
class AppColors {
  // Brand Colors
  static const Color primaryBlue = Color(0xFF1E88E5);
  static const Color primaryDark = Color(0xFF0D47A1);
  static const Color accentGreen = Color(0xFF00C853);

  // Stock Market Specific Colors
  static const Color bullishGreen = Color(0xFF00C853);
  static const Color bearishRed = Color(0xFFD32F2F);
  static const Color neutralGray = Color(0xFF757575);

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFF5F7FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCardBackground = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF212121);
  static const Color lightTextSecondary = Color(0xFF757575);
  static const Color lightDivider = Color(0xFFE0E0E0);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF0A0E27);
  static const Color darkSurface = Color(0xFF1A1F3A);
  static const Color darkCardBackground = Color(0xFF252B48);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0B8C8);
  static const Color darkDivider = Color(0xFF2D3348);

  // Chart Colors
  static const Color chartGreen = Color(0xFF26A69A);
  static const Color chartRed = Color(0xFFEF5350);
  static const Color chartBlue = Color(0xFF42A5F5);
  static const Color chartOrange = Color(0xFFFF7043);
  static const Color chartPurple = Color(0xFFAB47BC);

  // Gradient Colors
  static const LinearGradient bullishGradient = LinearGradient(
    colors: [Color(0xFF00C853), Color(0xFF64DD17)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient bearishGradient = LinearGradient(
    colors: [Color(0xFFD32F2F), Color(0xFFE57373)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF1E88E5), Color(0xFF1976D2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
