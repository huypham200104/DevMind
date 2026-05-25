import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app/theme/app_colors.dart';

class RankingAvatar extends StatelessWidget {
  const RankingAvatar({super.key, required this.photoUrl, required this.size});

  final String? photoUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    final normalizedPhotoUrl = photoUrl?.trim();

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFE1E1E1), width: 4),
      ),
      child: ClipOval(
        child: normalizedPhotoUrl != null && normalizedPhotoUrl.isNotEmpty
            ? Image.network(normalizedPhotoUrl, fit: BoxFit.cover)
            : Container(
                color: const Color(0xFFE5FAF8),
                padding: EdgeInsets.all(size * 0.23),
                child: SvgPicture.asset('assets/icons/profile-logo.svg'),
              ),
      ),
    );
  }
}
