import 'package:flutter/material.dart';

abstract final class AppSpacing {
  /// 4.0
  static const double xxs = 4;
  
  /// 8.0
  static const double xs = 8;
  
  /// 12.0
  static const double sm = 12;
  
  /// 16.0
  static const double md = 16;
  
  /// 20.0
  static const double lg = 20;
  
  /// 24.0
  static const double xl = 24;
  
  /// 32.0
  static const double xxl = 32;
  
  /// 40.0
  static const double xxxl = 40;
  
  /// 48.0
  static const double huge = 48;

  // --- Vertical Spacing (Height) ---
  static const hGapXXS = SizedBox(height: xxs);
  static const hGapXS = SizedBox(height: xs);
  static const hGapSM = SizedBox(height: sm);
  static const hGapMD = SizedBox(height: md);
  static const hGapLG = SizedBox(height: lg);
  static const hGapXL = SizedBox(height: xl);
  static const hGapXXL = SizedBox(height: xxl);
  static const hGapXXXL = SizedBox(height: xxxl);
  static const hGapHuge = SizedBox(height: huge);

  // --- Horizontal Spacing (Width) ---
  static const wGapXXS = SizedBox(width: xxs);
  static const wGapXS = SizedBox(width: xs);
  static const wGapSM = SizedBox(width: sm);
  static const wGapMD = SizedBox(width: md);
  static const wGapLG = SizedBox(width: lg);
  static const wGapXL = SizedBox(width: xl);
  static const wGapXXL = SizedBox(width: xxl);
  static const wGapXXXL = SizedBox(width: xxxl);
  static const wGapHuge = SizedBox(width: huge);
}
