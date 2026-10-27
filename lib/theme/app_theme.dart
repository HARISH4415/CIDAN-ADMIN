import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Indian Bank Corporate Colors
  static const Color indianBankBlue = Color(0xFF004195); // Exact RGB(0, 65, 149)
  static const Color indianBankYellow = Color(0xFFFDB813);
  
  // UI Colors
  static const Color primaryBlue = Color(0xFF1E6BFF);
  static const Color backgroundLight = Color(0xFFF4F7FC);
  static const Color cardBackground = Colors.white;
  static const Color textDark = Color(0xFF0F172A);
  static const Color textMuted = Color(0xFF64748B);
  static const Color textLight = Color(0xFF94A3B8);
  static const Color borderLight = Color(0xFFE2E8F0);
  
  // Status & Category Colors
  static const Color successGreen = Color(0xFF10B981);
  static const Color successGreenBg = Color(0xFFE6F9F0);
  static const Color warningAmber = Color(0xFFF59E0B);
  static const Color warningAmberBg = Color(0xFFFEF3C7);
  static const Color purpleAccent = Color(0xFF8B5CF6);
  static const Color purpleAccentBg = Color(0xFFF3E8FF);
  static const Color roseAccent = Color(0xFFF43F5E);
  static const Color roseAccentBg = Color(0xFFFFE4E6);
  static const Color tealAccent = Color(0xFF0D9488);
  static const Color tealAccentBg = Color(0xFFCCFBF1);
  static const Color orangeAccent = Color(0xFFF97316);
  static const Color orangeAccentBg = Color(0xFFFFEDD5);

  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.interTextTheme();

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundLight,
      colorScheme: ColorScheme.fromSeed(
        seedColor: indianBankBlue,
        primary: indianBankBlue,
        secondary: primaryBlue,
        surface: cardBackground,
      ),
      textTheme: baseTextTheme.copyWith(
        titleLarge: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 13,
          color: textMuted,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 11,
          color: textLight,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: Color(0x1F004195), width: 0.8),
        ),
      ),
    );
  }

  static BoxDecoration cardDecoration({
    double radius = 14,
    Color borderColor = const Color(0x1F004195),
    Color backgroundColor = Colors.white,
  }) {
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor, width: 0.8),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF0F172A).withValues(alpha: 0.03),
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }
}
