import 'package:flutter/material.dart';

/// Modern premium dark color system for trading apps
class AppColors {
  // ─────────────────────────────────────────────
  // Brand Colors (Modern, Sharp but Controlled)
  // ─────────────────────────────────────────────

  static const Color primaryBlue =
      Color(0xFF6C7CFF); // Modern Soft Electric Indigo

  static const Color primaryDark =
      Color(0xFF151A2E); // Deep Blue-Black (Premium Base)

  static const Color accentGreen =
      Color(0xFF32D2A2); // Modern Teal-Green Accent

  // ─────────────────────────────────────────────
  // Stock Market Specific Colors
  // ─────────────────────────────────────────────

  static const Color bullishGreen = Color(0xFF2FE0A7); // Luminous but not neon

  static const Color bearishRed = Color(0xFFFF5C5C); // Modern Soft Signal Red

  static const Color neutralGray = Color(0xFF8E95A9); // Modern Cool Neutral

  // ─────────────────────────────────────────────
  // Light Theme (Admin / Rare Use)
  // ─────────────────────────────────────────────

  static const Color lightBackground = Color(0xFFF7F8FC);

  static const Color lightSurface = Color(0xFFFFFFFF);

  static const Color lightCardBackground = Color(0xFFF1F3F8);

  static const Color lightTextPrimary = Color(0xFF0F1222);

  static const Color lightTextSecondary = Color(0xFF6B7280);

  static const Color lightDivider = Color(0xFFE3E6EF);

  // ─────────────────────────────────────────────
  // Dark Theme (Main App)
  // ─────────────────────────────────────────────

  static const Color darkBackground =
      Color(0xFF0A0D1C); // Ultra-dark Navy (Not black)

  static const Color darkSurface = Color(0xFF11162A); // Elevated Layer

  static const Color darkCardBackground = Color(0xFF161C36); // Card Depth

  static const Color darkTextPrimary = Color(0xFFE6E8F0); // Soft White

  static const Color darkTextSecondary =
      Color(0xFF9AA1B7); // Cool Secondary Text

  static const Color darkDivider = Color(0xFF1F2540);

  // ─────────────────────────────────────────────
  // Navigation Bar
  // ─────────────────────────────────────────────

  static const Color navBackground = Color(0xFF0A0D1C);

  static const Color navActiveColor = Color(0xFF6C7CFF); // Sharp focus color

  static const Color navInactiveColor = Color(0xFF6F768E);

  // ─────────────────────────────────────────────
  // Chart Colors (Data-first, Premium)
  // ─────────────────────────────────────────────

  static const Color chartGreen = Color(0xFF2FE0A7);

  static const Color chartRed = Color(0xFFFF5C5C);

  static const Color chartBlue = Color(0xFF6C7CFF);

  static const Color chartOrange = Color(0xFFFFB454);

  static const Color chartPurple = Color(0xFF9A8CFF);

  // ─────────────────────────────────────────────
  // Gradients (Modern Depth)
  // ─────────────────────────────────────────────

  static const LinearGradient bullishGradient = LinearGradient(
    colors: [
      Color(0xFF2FE0A7),
      Color(0xFF1DBF8B),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient bearishGradient = LinearGradient(
    colors: [
      Color(0xFFFF5C5C),
      Color(0xFFE04646),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFF6C7CFF),
      Color(0xFF5A67E8),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
