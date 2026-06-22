import 'package:flutter/material.dart';

import '../../app/theme/app_theme.dart';

extension ThemeContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => theme.colorScheme;
  TextTheme get texts => theme.textTheme;
  AppColorsExtension get appColors => theme.extension<AppColorsExtension>()!;
}

extension TextStyleExt on TextStyle {
  TextStyle withColor(Color color) => copyWith(color: color);
  TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);
  TextStyle get w700 => copyWith(fontWeight: FontWeight.w700);
  TextStyle get w800 => copyWith(fontWeight: FontWeight.w800);
}

extension AppSemanticTextStyles on BuildContext {
  // Quick Action Card Styles
  TextStyle get cardTitle => texts.titleSmall!.withColor(colors.onSurface).w700.copyWith(letterSpacing: 0);
  TextStyle get cardSubtitle => texts.bodySmall!.withColor(colors.onSurfaceVariant).copyWith(letterSpacing: 0, height: 1.45);
  TextStyle get actionLabel => texts.labelSmall!.withColor(appColors.primaryGradientEnd).w600.copyWith(letterSpacing: 0);

  // Ranking Card Styles
  TextStyle get rankingTitle => texts.titleMedium!.withColor(Colors.white).w700.copyWith(letterSpacing: 0);
  TextStyle get rankingSubtitle => texts.bodySmall!.withColor(Colors.white.withAlpha(200)).copyWith(letterSpacing: 0);
  TextStyle get rankingBadge => const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800, height: 1.1, letterSpacing: -0.5);
  TextStyle get rankingChipLabel => texts.labelSmall!.withColor(Colors.white).w600.copyWith(letterSpacing: 0);
}
