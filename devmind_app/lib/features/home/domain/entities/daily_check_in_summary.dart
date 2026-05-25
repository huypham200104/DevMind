class DailyCheckInSummary {
  const DailyCheckInSummary({
    required this.points,
    required this.currentStreak,
    required this.totalCheckInDays,
    required this.checkedInDates,
  });

  factory DailyCheckInSummary.empty() {
    return const DailyCheckInSummary(
      points: 0,
      currentStreak: 0,
      totalCheckInDays: 0,
      checkedInDates: {},
    );
  }

  final int points;
  final int currentStreak;
  final int totalCheckInDays;
  final Set<DateTime> checkedInDates;

  int get nextMilestone {
    final next = ((totalCheckInDays ~/ 30) + 1) * 30;
    return next == 0 ? 30 : next;
  }

  bool hasCheckedIn(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    return checkedInDates.contains(normalizedDate);
  }
}
