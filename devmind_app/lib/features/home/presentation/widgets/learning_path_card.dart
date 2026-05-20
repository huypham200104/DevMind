import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/home_user_profile.dart';
import 'home_card.dart';

class LearningPathCard extends StatelessWidget {
  const LearningPathCard({super.key, required this.profile});

  final HomeUserProfile profile;

  @override
  Widget build(BuildContext context) {
    return HomeCard(
      child: Stack(
        children: [
          Positioned(
            right: -56,
            top: -70,
            child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                color: Color(0xFFEAFBF9),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LỘ TRÌNH HIỆN TẠI',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: AppColors.primaryGradientEnd,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.6,
                              ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          profile.currentPathTitle,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w800,
                                height: 1.25,
                                letterSpacing: 0,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  _DaysSummary(
                    completedDays: profile.completedDays,
                    totalDays: profile.totalDays,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  minHeight: 8,
                  value: profile.progress,
                  backgroundColor: const Color(0xFFE1E3E3),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DaysSummary extends StatelessWidget {
  const _DaysSummary({required this.completedDays, required this.totalDays});

  final int completedDays;
  final int totalDays;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimary,
              letterSpacing: 0,
            ),
            children: [
              TextSpan(
                text: '$completedDays',
                style: const TextStyle(
                  color: AppColors.primaryGradientEnd,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextSpan(
                text: ' / $totalDays',
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Text(
          'ngày',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textPrimary,
            letterSpacing: 0,
          ),
        ),
      ],
    );
  }
}
