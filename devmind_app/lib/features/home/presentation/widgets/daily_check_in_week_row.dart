import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/daily_check_in_summary.dart';

class DailyCheckInWeekRow extends StatelessWidget {
  const DailyCheckInWeekRow({super.key, required this.summary});

  final DailyCheckInSummary summary;

  @override
  Widget build(BuildContext context) {
    final today = _dateOnly(DateTime.now());
    final monday = today.subtract(Duration(days: today.weekday - 1));
    final days = [
      for (var index = 0; index < 7; index++) monday.add(Duration(days: index)),
    ];
    const labels = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];

    return Row(
      children: [
        for (var index = 0; index < days.length; index++)
          Expanded(
            child: _WeekDayItem(
              label: labels[index],
              date: days[index],
              today: today,
              checked: summary.hasCheckedIn(days[index]),
            ),
          ),
      ],
    );
  }

  DateTime _dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}

class _WeekDayItem extends StatelessWidget {
  const _WeekDayItem({
    required this.label,
    required this.date,
    required this.today,
    required this.checked,
  });

  final String label;
  final DateTime date;
  final DateTime today;
  final bool checked;

  @override
  Widget build(BuildContext context) {
    final isToday = date == today;
    final daysAfterToday = date.difference(today).inDays;
    final isLocked = daysAfterToday > 1;
    final isFuture = daysAfterToday > 0;

    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: isToday
                ? AppColors.primaryGradientEnd
                : AppColors.textSecondary,
            fontWeight: FontWeight.w700,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: checked
                ? AppColors.primary
                : isToday
                ? const Color(0xFFD6F8F4)
                : const Color(0xFFEDEDED),
            shape: BoxShape.circle,
            border: Border.all(
              color: isToday
                  ? AppColors.primaryGradientEnd
                  : isLocked
                  ? const Color(0xFFBFD6D3)
                  : Colors.transparent,
              width: isToday || isLocked ? 2 : 0,
            ),
          ),
          child: Center(
            child: checked
                ? const Icon(Icons.check, color: AppColors.surface, size: 30)
                : isLocked
                ? const Icon(
                    Icons.lock_outline,
                    color: AppColors.textSecondary,
                    size: 26,
                  )
                : Text(
                    '+10',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isToday
                          ? AppColors.primaryGradientEnd
                          : AppColors.textSecondary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0,
                    ),
                  ),
          ),
        ),
        SizedBox(height: isToday && !checked ? 8 : 30),
        if (isToday && !checked)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.primaryGradientEnd,
              borderRadius: BorderRadius.circular(6),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x332ED3C6),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              'Nhận ngay',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.surface,
                fontWeight: FontWeight.w600,
                letterSpacing: 0,
              ),
            ),
          )
        else if (isFuture)
          const SizedBox(height: 0),
      ],
    );
  }
}
