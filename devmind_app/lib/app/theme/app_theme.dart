import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static const fontFamily = 'Plus Jakarta Sans';

  static TextTheme get _textTheme {
    return const TextTheme(
      displayLarge: TextStyle(
        fontSize: 36,
        height: 1.16,
        fontWeight: FontWeight.w800,
        letterSpacing: 0,
      ),
      displayMedium: TextStyle(
        fontSize: 32,
        height: 1.18,
        fontWeight: FontWeight.w800,
        letterSpacing: 0,
      ),
      displaySmall: TextStyle(
        fontSize: 28,
        height: 1.2,
        fontWeight: FontWeight.w800,
        letterSpacing: 0,
      ),
      headlineLarge: TextStyle(
        fontSize: 26,
        height: 1.24,
        fontWeight: FontWeight.w800,
        letterSpacing: 0,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        height: 1.25,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
      ),
      headlineSmall: TextStyle(
        fontSize: 21,
        height: 1.28,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        height: 1.32,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
      ),
      titleMedium: TextStyle(
        fontSize: 15,
        height: 1.38,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        height: 1.36,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      ),
      bodyLarge: TextStyle(
        fontSize: 15,
        height: 1.48,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        height: 1.45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        height: 1.42,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        height: 1.25,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        height: 1.28,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        height: 1.3,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
      ),
    ).apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
      fontFamily: fontFamily,
    );
  }

  static ThemeData get light {
    final textTheme = _textTheme;
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      error: AppColors.danger,
      onSurface: AppColors.textPrimary,
      onSurfaceVariant: AppColors.textSecondary,
      outline: AppColors.border,
      outlineVariant: AppColors.border,
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      textTheme: textTheme,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: AppColors.headerBackground,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(48),
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size.fromHeight(48),
          side: const BorderSide(color: AppColors.border),
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputSurface,
        labelStyle: textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
        hintStyle: textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
        helperStyle: textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
        errorStyle: textTheme.bodySmall?.copyWith(color: AppColors.danger),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      extensions: const [
        AppColorsExtension(
          primaryGradientEnd: AppColors.primaryGradientEnd,
          headerBackground: AppColors.headerBackground,
          inputSurface: AppColors.inputSurface,
          borderStrong: AppColors.borderStrong,
          navInactive: AppColors.navInactive,
          navInactiveAlt: AppColors.navInactiveAlt,
          googleBlue: AppColors.googleBlue,
          googleRed: AppColors.googleRed,
          googleYellow: AppColors.googleYellow,
          googleGreen: AppColors.googleGreen,
        ),
      ],
    );
  }
}

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.primaryGradientEnd,
    required this.headerBackground,
    required this.inputSurface,
    required this.borderStrong,
    required this.navInactive,
    required this.navInactiveAlt,
    required this.googleBlue,
    required this.googleRed,
    required this.googleYellow,
    required this.googleGreen,
  });

  final Color primaryGradientEnd;
  final Color headerBackground;
  final Color inputSurface;
  final Color borderStrong;
  final Color navInactive;
  final Color navInactiveAlt;
  final Color googleBlue;
  final Color googleRed;
  final Color googleYellow;
  final Color googleGreen;

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? primaryGradientEnd,
    Color? headerBackground,
    Color? inputSurface,
    Color? borderStrong,
    Color? navInactive,
    Color? navInactiveAlt,
    Color? googleBlue,
    Color? googleRed,
    Color? googleYellow,
    Color? googleGreen,
  }) {
    return AppColorsExtension(
      primaryGradientEnd: primaryGradientEnd ?? this.primaryGradientEnd,
      headerBackground: headerBackground ?? this.headerBackground,
      inputSurface: inputSurface ?? this.inputSurface,
      borderStrong: borderStrong ?? this.borderStrong,
      navInactive: navInactive ?? this.navInactive,
      navInactiveAlt: navInactiveAlt ?? this.navInactiveAlt,
      googleBlue: googleBlue ?? this.googleBlue,
      googleRed: googleRed ?? this.googleRed,
      googleYellow: googleYellow ?? this.googleYellow,
      googleGreen: googleGreen ?? this.googleGreen,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) {
      return this;
    }
    return AppColorsExtension(
      primaryGradientEnd: Color.lerp(primaryGradientEnd, other.primaryGradientEnd, t)!,
      headerBackground: Color.lerp(headerBackground, other.headerBackground, t)!,
      inputSurface: Color.lerp(inputSurface, other.inputSurface, t)!,
      borderStrong: Color.lerp(borderStrong, other.borderStrong, t)!,
      navInactive: Color.lerp(navInactive, other.navInactive, t)!,
      navInactiveAlt: Color.lerp(navInactiveAlt, other.navInactiveAlt, t)!,
      googleBlue: Color.lerp(googleBlue, other.googleBlue, t)!,
      googleRed: Color.lerp(googleRed, other.googleRed, t)!,
      googleYellow: Color.lerp(googleYellow, other.googleYellow, t)!,
      googleGreen: Color.lerp(googleGreen, other.googleGreen, t)!,
    );
  }
}
