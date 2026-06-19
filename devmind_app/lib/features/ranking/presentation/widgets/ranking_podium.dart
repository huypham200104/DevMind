import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../controllers/ranking_controller.dart';
import 'ranking_avatar.dart';
import 'ranking_points_text.dart';

class RankingPodium extends StatelessWidget {
  const RankingPodium({super.key, required this.users});

  final List<RankedUser> users;

  @override
  Widget build(BuildContext context) {
    final first = _findRank(1);
    final second = _findRank(2);
    final third = _findRank(3);

    return SizedBox(
      height: 370,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: _PodiumUser(
              rankedUser: second,
              avatarSize: 82,
              pillarHeight: 104,
              topOffset: 58,
              position: 2,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _PodiumUser(
              rankedUser: first,
              avatarSize: 104,
              pillarHeight: 136,
              highlighted: true,
              position: 1,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _PodiumUser(
              rankedUser: third,
              avatarSize: 82,
              pillarHeight: 86,
              topOffset: 78,
              position: 3,
            ),
          ),
        ],
      ),
    );
  }

  RankedUser? _findRank(int rank) {
    for (final user in users) {
      if (user.rank == rank) {
        return user;
      }
    }

    return null;
  }
}

class _PodiumUser extends StatelessWidget {
  const _PodiumUser({
    required this.rankedUser,
    required this.avatarSize,
    required this.pillarHeight,
    required this.position,
    this.highlighted = false,
    this.topOffset = 24,
  });

  final RankedUser? rankedUser;
  final double avatarSize;
  final double pillarHeight;
  final int position; // 1, 2, 3 — dùng làm fallback seed cho avatar
  final bool highlighted;
  final double topOffset;

  @override
  Widget build(BuildContext context) {
    final user = rankedUser?.user;

    return Padding(
      padding: EdgeInsets.only(top: topOffset),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: EdgeInsets.all(highlighted ? 6 : 0),
                  decoration: highlighted
                      ? BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primaryGradientEnd,
                            width: 5,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x332ED3C6),
                              blurRadius: 34,
                              offset: Offset(0, 14),
                            ),
                          ],
                        )
                      : null,
                  child: RankingAvatar(
                    photoUrl: user?.photoUrl,
                    size: avatarSize,
                    fallbackSeed: position * 7, // seed cố định theo vị trí
                  ),
                ),
                // Luôn hiển thị rank badge
                Positioned(
                  right: highlighted ? -6 : -4,
                  bottom: highlighted ? -10 : -8,
                  child: _RankBadge(rank: position, large: highlighted),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            user?.firstName ?? 'Đang tính',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: RankingPointsText(points: user?.points ?? 0, fontSize: 20),
          ),
          const SizedBox(height: 14),
          Flexible(
            child: Container(
              width: double.infinity,
              height: pillarHeight,
              decoration: BoxDecoration(
                color: const Color(0xFFE7E7E7),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14111827),
                    blurRadius: 14,
                    offset: Offset(0, 8),
                  ),
                ],
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(highlighted ? 16 : 10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RankBadge extends StatelessWidget {
  const _RankBadge({required this.rank, required this.large});

  final int rank;
  final bool large;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: large ? 46 : 38,
      height: large ? 46 : 38,
      decoration: BoxDecoration(
        color: large ? AppColors.primaryGradientEnd : const Color(0xFFE8E8E8),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.surface, width: 3),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A111827),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Text(
          rank.toString(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: large ? AppColors.surface : AppColors.textPrimary,
            fontWeight: FontWeight.w800,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}
