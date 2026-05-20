import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/home_user_profile.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key, required this.profile});

  final HomeUserProfile profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chào mừng trở lại, ${profile.firstName}',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w800,
            height: 1.2,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Quá trình luyện tập của bạn đã hoàn thành ${(profile.progress * 100).round()}%.\nCố lên!',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textSecondary,
            height: 1.35,
            letterSpacing: 0,
          ),
        ),
      ],
    );
  }
}
