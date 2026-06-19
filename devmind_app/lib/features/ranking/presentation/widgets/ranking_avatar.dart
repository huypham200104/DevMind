import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class RankingAvatar extends StatelessWidget {
  const RankingAvatar({
    super.key,
    required this.photoUrl,
    required this.size,
    this.fallbackSeed = 1,
  });

  final String? photoUrl;
  final double size;
  /// Seed 1-70 để chọn ảnh mặt người cố định từ pravatar.cc
  final int fallbackSeed;

  @override
  Widget build(BuildContext context) {
    final normalizedPhotoUrl = photoUrl?.trim();
    final imageUrl = normalizedPhotoUrl != null && normalizedPhotoUrl.isNotEmpty
        ? normalizedPhotoUrl
        : 'https://i.pravatar.cc/150?img=$fallbackSeed';

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFE1E1E1), width: 4),
      ),
      child: ClipOval(
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: AppColors.primaryGradientEnd.withValues(alpha: 0.15),
              child: Icon(
                Icons.person_rounded,
                size: size * 0.5,
                color: AppColors.primaryGradientEnd,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
