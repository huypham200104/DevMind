import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class DailyCheckInSectionTitle extends StatelessWidget {
  const DailyCheckInSectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w800,
        letterSpacing: 0,
      ),
    );
  }
}

class DailyCheckInErrorMessage extends StatelessWidget {
  const DailyCheckInErrorMessage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3F3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFF6B8B8)),
      ),
      child: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.danger,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
        ),
      ),
    );
  }
}

class DailyCheckInPointsBalance extends StatelessWidget {
  const DailyCheckInPointsBalance({super.key, required this.points});

  final int points;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE5FAF8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFB9F1EC)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.stars_outlined,
            color: AppColors.primaryGradientEnd,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Bạn đang có',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
              ),
            ),
          ),
          Text(
            '$points điểm',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.primaryGradientEnd,
              fontWeight: FontWeight.w800,
              letterSpacing: 0,
            ),
          ),
        ],
      ),
    );
  }
}
