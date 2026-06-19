import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app/theme/app_colors.dart';

class IconBubble extends StatelessWidget {
  const IconBubble({
    super.key,
    this.icon,
    this.svgAsset,
  }) : assert(icon != null || svgAsset != null);

  final IconData? icon;
  final String? svgAsset;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      decoration: const BoxDecoration(
        color: Color(0xFFE8FAF8),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: svgAsset != null
            ? SvgPicture.asset(
                svgAsset!,
                width: 28,
                height: 28,
                colorFilter: const ColorFilter.mode(
                  AppColors.primaryGradientEnd,
                  BlendMode.srcIn,
                ),
              )
            : Icon(icon, color: AppColors.primaryGradientEnd, size: 28),
      ),
    );
  }
}
