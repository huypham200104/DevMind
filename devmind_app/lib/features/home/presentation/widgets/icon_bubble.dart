import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class IconBubble extends StatelessWidget {
  const IconBubble({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      decoration: const BoxDecoration(
        color: Color(0xFFE8FAF8),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: AppColors.primaryGradientEnd, size: 28),
    );
  }
}
