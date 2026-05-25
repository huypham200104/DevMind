import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class DailyCheckInRewardGrid extends StatelessWidget {
  const DailyCheckInRewardGrid({super.key, required this.points});

  final int points;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _RewardCard(
            icon: Icons.psychology_alt_outlined,
            title: '1 Lượt giải thích AI',
            cost: 50,
            points: points,
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: _RewardCard(
            icon: Icons.description_outlined,
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
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFDADDE1)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x07111827),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFFE5FAF8),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: AppColors.primaryGradientEnd, size: 36),
          ),
          const SizedBox(height: 28),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
              height: 1.18,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$cost điểm',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.primaryGradientEnd,
              fontWeight: FontWeight.w800,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton(
              onPressed: canRedeem
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Tính năng đổi quà sẽ được kết nối tiếp theo.',
                          ),
                        ),
                      );
                    }
                  : null,
              style: FilledButton.styleFrom(
                disabledBackgroundColor: const Color(0xFFD9E2E0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
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
