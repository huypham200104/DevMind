import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/profile_data.dart';

class ProfileLearningStatsCard extends StatelessWidget {
  const ProfileLearningStatsCard({
    required this.stats,
    required this.onTap,
    super.key,
  });

  final ProfileLearningStatsData? stats;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ProfileSurfaceCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
      child: Row(
        children: [
          const ProfileIconBox(icon: Icons.bar_chart_outlined),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thống kê học tập',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: const Color(0xFF0F172A),
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _summaryText(stats),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF64748B),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xFFCBD5E1), size: 30),
        ],
      ),
    );
  }

  String _summaryText(ProfileLearningStatsData? stats) {
    if (stats == null || !stats.hasAnyValue) {
      return 'Không có';
    }

    final parts = <String>[];
    if (stats.totalQuizzesTaken != null) {
      parts.add('${stats.totalQuizzesTaken} bài quiz');
    }
    if (stats.totalCorrectAnswers != null &&
        stats.totalQuestionsAnswered != null) {
      parts.add(
        '${stats.totalCorrectAnswers}/${stats.totalQuestionsAnswered} câu đúng',
      );
    }
    if (stats.currentStreak != null) {
      parts.add('${stats.currentStreak} ngày streak');
    }

    return parts.isEmpty ? 'Không có' : parts.join(' • ');
  }
}

class ProfileSurfaceCard extends StatelessWidget {
  const ProfileSurfaceCard({
    required this.child,
    this.padding = const EdgeInsets.all(26),
    this.onTap,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          width: double.infinity,
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F111827),
                blurRadius: 22,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

class ProfileIconBox extends StatelessWidget {
  const ProfileIconBox({required this.icon, super.key});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFFE8FAF8),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(icon, color: AppColors.primaryGradientEnd, size: 30),
    );
  }
}
