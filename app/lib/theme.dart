import 'package:flutter/material.dart';

abstract final class WmiColors {
  static const kajal = Color(0xFF19120F);
  static const lac = Color(0xFF641F35);
  static const deepLac = Color(0xFF2D1018);
  static const kora = Color(0xFFF4EEE4);
  static const paper = Color(0xFFFCF9F2);
  static const kansa = Color(0xFFC89A54);
  static const oldGold = Color(0xFF9B713A);
  static const neel = Color(0xFF18373B);
  static const neem = Color(0xFF607064);
  static const mitti = Color(0xFFD8C3A3);
  static const mutedInk = Color(0xFF6D625B);
  static const line = Color(0xFFD7CCBD);
  static const studio = Color(0xFFF1ECE3);
  static const studioInset = Color(0xFFE5DCCF);
  static const studioShadow = Color(0x332D2018);
}

abstract final class WmiTheme {
  static const _displayFallback = <String>[
    'Noto Serif Devanagari',
    'Noto Serif',
    'Georgia',
    'serif',
  ];

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'Anek',
      scaffoldBackgroundColor: WmiColors.kora,
      colorScheme: const ColorScheme.light(
        primary: WmiColors.lac,
        onPrimary: WmiColors.paper,
        secondary: WmiColors.kansa,
        onSecondary: WmiColors.kajal,
        surface: WmiColors.paper,
        onSurface: WmiColors.kajal,
        outline: WmiColors.line,
      ),
    );

    final display = base.textTheme.copyWith(
      displayLarge: const TextStyle(
        fontFamily: 'Tiro',
        fontFamilyFallback: _displayFallback,
        fontSize: 64,
        height: .94,
        letterSpacing: -2.4,
        fontWeight: FontWeight.w500,
      ),
      displayMedium: const TextStyle(
        fontFamily: 'Tiro',
        fontFamilyFallback: _displayFallback,
        fontSize: 48,
        height: 1,
        letterSpacing: -1.6,
        fontWeight: FontWeight.w500,
      ),
      headlineLarge: const TextStyle(
        fontFamily: 'Tiro',
        fontFamilyFallback: _displayFallback,
        fontSize: 36,
        height: 1.04,
        letterSpacing: -.9,
        fontWeight: FontWeight.w500,
      ),
      headlineMedium: const TextStyle(
        fontFamily: 'Tiro',
        fontFamilyFallback: _displayFallback,
        fontSize: 28,
        height: 1.08,
        letterSpacing: -.5,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: const TextStyle(
        fontFamily: 'Tiro',
        fontFamilyFallback: _displayFallback,
        fontSize: 22,
        height: 1.1,
        fontWeight: FontWeight.w600,
      ),
    );

    return base.copyWith(
      textTheme: display.copyWith(
        bodyLarge: const TextStyle(
          fontSize: 17,
          height: 1.55,
          color: WmiColors.mutedInk,
        ),
        bodyMedium: const TextStyle(
          fontSize: 15,
          height: 1.48,
          color: WmiColors.mutedInk,
        ),
        labelLarge: const TextStyle(
          fontSize: 13,
          height: 1.2,
          letterSpacing: 1.1,
          fontWeight: FontWeight.w700,
        ),
      ),
      dividerColor: WmiColors.line,
      cardTheme: const CardThemeData(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: WmiColors.paper,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: WmiColors.line),
          borderRadius: BorderRadius.zero,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, 54),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          textStyle: const TextStyle(
            fontSize: 13,
            letterSpacing: 1.1,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, 54),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          side: const BorderSide(color: WmiColors.kajal),
          textStyle: const TextStyle(
            fontSize: 13,
            letterSpacing: 1.1,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: WmiColors.kansa,
        linearTrackColor: Color(0xFFE0D5C5),
      ),
    );
  }
}
