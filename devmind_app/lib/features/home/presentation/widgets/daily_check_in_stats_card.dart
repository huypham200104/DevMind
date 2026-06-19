import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/daily_check_in_summary.dart';

class DailyCheckInStatsCard extends StatelessWidget {
  const DailyCheckInStatsCard({super.key, required this.summary});

  final DailyCheckInSummary summary;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatItem(
            icon: Icons.calendar_today_rounded,
            value: '${summary.totalCheckInDays}',
            label: 'Ngày điểm danh',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatItem(
            icon: Icons.flag_rounded,
            value: '${summary.nextMilestone}',
            label: 'Mốc tiếp theo',
            highlight: true,
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    this.highlight = false,
  });

  final IconData icon;
  final String value;
  final String label;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: highlight
            ? AppColors.primary.withAlpha(20)
            : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(14),
        border: highlight
            ? Border.all(color: AppColors.primary.withAlpha(60), width: 1.5)
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: highlight ? AppColors.primary : const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: highlight ? Colors.white : AppColors.textSecondary,
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: highlight
                            ? AppColors.primaryGradientEnd
                            : AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0,
                        height: 1.1,
                      ),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        letterSpacing: 0,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
