import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import 'home_card.dart';
import 'icon_bubble.dart';

class RankingCard extends StatelessWidget {
  const RankingCard({super.key, required this.rank});

  final int rank;

  @override
  Widget build(BuildContext context) {
    return HomeCard(
      child: Row(
        children: [
          const IconBubble(icon: Icons.leaderboard_outlined),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hạng thế giới',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    letterSpacing: 0,
                  ),
                ),
                Text(
                  'Hạng:\n#$rank',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                    height: 1.05,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
          TextButton.icon(
            onPressed: () => context.goNamed(AppRouteNames.gamification),
            iconAlignment: IconAlignment.end,
            icon: const Icon(Icons.arrow_forward, size: 18),
            label: const Text('Xem bảng xếp hạng'),
          ),
        ],
      ),
    );
  }
}
