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
      for (var i = 0; i < 7; i++) monday.add(Duration(days: i)),
    ];
    const labels = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];

    return Row(
      children: [
        for (var i = 0; i < days.length; i++)
          Expanded(
            child: _WeekDayItem(
              label: labels[i],
              date: days[i],
              today: today,
              checked: summary.hasCheckedIn(days[i]),
            ),
          ),
      ],
    );
  }

  DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);
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

    Color bgColor;
    Color borderColor;
    Widget innerWidget;

    if (checked) {
      bgColor = AppColors.primary;
      borderColor = Colors.transparent;
      innerWidget = const Icon(Icons.check_rounded, color: Colors.white, size: 22);
    } else if (isToday) {
      bgColor = AppColors.primary.withAlpha(20);
      borderColor = AppColors.primary;
      innerWidget = Text(
        '+10',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.primaryGradientEnd,
              fontWeight: FontWeight.w700,
              letterSpacing: 0,
            ),
      );
    } else if (isFuture && !isLocked) {
      bgColor = const Color(0xFFF0F0F0);
      borderColor = Colors.transparent;
      innerWidget = Text(
        '+10',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0,
            ),
      );
    } else {
      bgColor = const Color(0xFFF0F0F0);
      borderColor = Colors.transparent;
      innerWidget = Icon(
        isLocked ? Icons.lock_outline_rounded : Icons.remove,
        color: AppColors.navInactive,
        size: 18,
      );
    }

    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isToday
                    ? AppColors.primaryGradientEnd
                    : AppColors.textSecondary,
                fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
                letterSpacing: 0,
              ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Center(child: innerWidget),
        ),
        const SizedBox(height: 6),
        if (isToday && !checked)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Hôm nay',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 9,
                    letterSpacing: 0,
                  ),
            ),
          )
        else
          const SizedBox(height: 18),
      ],
    );
  }
}
