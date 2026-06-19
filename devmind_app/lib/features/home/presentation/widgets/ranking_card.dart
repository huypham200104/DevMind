import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../ranking/presentation/models/ranking_display_state.dart';

class RankingCard extends StatelessWidget {
  const RankingCard({
    super.key,
    required this.rank,
    required this.points,
    required this.completedQuizCount,
  });

  final int rank;
  final int points;
  final int completedQuizCount;

  @override
  Widget build(BuildContext context) {
    final displayState = RankingDisplayState(
      rank: rank,
      points: points,
      completedQuizCount: completedQuizCount,
    );

    return GestureDetector(
      onTap: () => context.goNamed(AppRouteNames.ranking),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: AppColors.primary.withAlpha(20),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primary.withAlpha(60),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            // Rank badge
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: displayState.hasRank
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '#${displayState.cardRankLabel}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              height: 1.1,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      )
                    : const Icon(
                        Icons.leaderboard_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
              ),
            ),

            const SizedBox(width: 16),

            // Text info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hạng của bạn',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          letterSpacing: 0,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    displayState.hasRank
                        ? 'Top #${displayState.cardRankLabel} toàn cầu'
                        : displayState.homeTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _Chip(
                        icon: Icons.star_rounded,
                        label: _formatPoints(points),
                      ),
                      const SizedBox(width: 8),
                      _Chip(
                        icon: Icons.check_circle_rounded,
                        label: '$completedQuizCount bài',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Arrow
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.primary,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  String _formatPoints(int pts) {
    if (pts >= 1000) {
      final k = pts / 1000;
      return '${k.toStringAsFixed(k.truncateToDouble() == k ? 0 : 1)}K điểm';
    }
    return '$pts điểm';
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primaryGradientEnd, size: 13),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.primaryGradientEnd,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                ),
          ),
        ],
      ),
    );
  }
}
