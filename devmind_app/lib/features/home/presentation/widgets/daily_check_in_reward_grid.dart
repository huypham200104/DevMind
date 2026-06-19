import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/app_dialog.dart';

class DailyCheckInRewardGrid extends StatelessWidget {
  const DailyCheckInRewardGrid({super.key, required this.points});

  final int points;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _RewardCard(
            icon: Icons.psychology_alt_rounded,
            title: '1 Lượt giải thích AI',
            cost: 50,
            points: points,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _RewardCard(
            icon: Icons.description_rounded,
            title: '1 Lượt quét CV',
            cost: 100,
            points: points,
          ),
        ),
      ],
    );
  }
}

class _RewardCard extends StatelessWidget {
  const _RewardCard({
    required this.icon,
    required this.title,
    required this.cost,
    required this.points,
  });

  final IconData icon;
  final String title;
  final int cost;
  final int points;

  @override
  Widget build(BuildContext context) {
    final canRedeem = points >= cost;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: canRedeem
            ? AppColors.primary.withAlpha(20)
            : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: canRedeem
              ? AppColors.primary.withAlpha(60)
              : const Color(0xFFE5E5E5),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: canRedeem ? AppColors.primary : const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: canRedeem ? Colors.white : AppColors.navInactive,
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                  letterSpacing: 0,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            '$cost điểm',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: canRedeem
                      ? AppColors.primaryGradientEnd
                      : AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: canRedeem
                  ? () {
                      AppDialog.showSuccess(
                        context,
                        message:
                            'Tính năng đổi quà sẽ được ra mắt trong phiên bản tiếp theo.',
                      );
                    }
                  : null,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
                disabledBackgroundColor: const Color(0xFFE0E0E0),
                disabledForegroundColor: AppColors.navInactive,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0,
                    ),
              ),
              child: const Text('Đổi ngay'),
            ),
          ),
        ],
      ),
    );
  }
}
