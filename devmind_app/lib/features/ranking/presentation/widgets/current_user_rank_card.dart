import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../controllers/ranking_controller.dart';
import 'ranking_avatar.dart';
import 'ranking_points_text.dart';

class CurrentUserRankCard extends StatelessWidget {
  const CurrentUserRankCard({super.key, required this.rankedUser});

  final RankedUser? rankedUser;

  @override
  Widget build(BuildContext context) {
    final user = rankedUser?.user;
    final rank = rankedUser?.rank;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 26),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x332ED3C6),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 44,
            child: Text(
              rank?.toString() ?? '-',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.surface,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 62,
            height: 62,
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
            ),
            child: RankingAvatar(photoUrl: user?.photoUrl, size: 56),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.surface,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user == null || user.points <= 0
                      ? 'Bắt đầu làm bài để lên hạng!'
                      : 'Keep pushing!',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.surface,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
          RankingPointsText(
            points: user?.points ?? 0,
            fontSize: 22,
            color: AppColors.surface,
          ),
        ],
      ),
    );
  }
}
