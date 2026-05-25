import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../controllers/ranking_controller.dart';
import 'ranking_avatar.dart';
import 'ranking_points_text.dart';

class RankingListSection extends StatelessWidget {
  const RankingListSection({super.key, required this.users});

  final List<RankedUser> users;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'GLOBAL RANKINGS',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2.4,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFE5FAF8),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                'Top 100',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF233F3D),
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        if (users.isEmpty)
          const _EmptyRankingList()
        else
          for (final rankedUser in users) ...[
            _RankingListTile(rankedUser: rankedUser),
            const SizedBox(height: 16),
          ],
      ],
    );
  }
}

class _RankingListTile extends StatelessWidget {
  const _RankingListTile({required this.rankedUser});

  final RankedUser rankedUser;

  @override
  Widget build(BuildContext context) {
    final user = rankedUser.user;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 36,
            child: Text(
              rankedUser.rank.toString(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(0xFF2F3F3D),
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
          ),
          const SizedBox(width: 18),
          RankingAvatar(photoUrl: user.photoUrl, size: 64),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.firstName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Level ${_levelForPoints(user.points)} Developer',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          RankingPointsText(points: user.points, fontSize: 22),
        ],
      ),
    );
  }

  int _levelForPoints(int points) {
    return (points ~/ 25).clamp(1, 99).toInt();
  }
}

class _EmptyRankingList extends StatelessWidget {
  const _EmptyRankingList();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Text(
        'Chưa có dữ liệu xếp hạng.',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
        ),
      ),
    );
  }
}
