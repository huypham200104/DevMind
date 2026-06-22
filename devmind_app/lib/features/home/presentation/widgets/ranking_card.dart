import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/utils/theme_ext.dart';
import '../../../../app/theme/app_spacing.dart';
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
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [context.colors.primary, context.appColors.primaryGradientEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: context.colors.primary.withAlpha(50),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            // Rank badge
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(40),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: displayState.hasRank
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '#${displayState.cardRankLabel}',
                            style: context.rankingBadge,
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

            AppSpacing.wGapMD,

            // Text info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hạng của bạn',
                    style: context.rankingSubtitle,
                  ),
                  AppSpacing.hGapXXS,
                  Text(
                    displayState.hasRank
                        ? 'Top #${displayState.cardRankLabel} toàn cầu'
                        : displayState.homeTitle,
                    style: context.rankingTitle,
                  ),
                  AppSpacing.hGapXS,
                  Row(
                    children: [
                      _Chip(
                        icon: Icons.star_rounded,
                        label: _formatPoints(points),
                      ),
                      AppSpacing.wGapXS,
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
              color: Colors.white.withAlpha(200),
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
        color: Colors.white.withAlpha(40),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 13),
          AppSpacing.wGapXXS,
          Text(
            label,
            style: context.rankingChipLabel,
          ),
        ],
      ),
    );
  }
}
