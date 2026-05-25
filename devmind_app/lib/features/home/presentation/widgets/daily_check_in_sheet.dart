import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/home_controller.dart';
import 'daily_check_in_bottom_action.dart';
import 'daily_check_in_header.dart';
import 'daily_check_in_reward_grid.dart';
import 'daily_check_in_shared_widgets.dart';
import 'daily_check_in_stats_card.dart';
import 'daily_check_in_streak_card.dart';
import 'daily_check_in_week_row.dart';

class DailyCheckInSheet extends StatelessWidget {
  const DailyCheckInSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();
    final summary = controller.dailyCheckIn;

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.96,
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F7F7),
        body: SafeArea(
          child: Column(
            children: [
              DailyCheckInHeader(onClose: () => Navigator.of(context).pop()),
              Expanded(
                child: controller.isLoadingDailyCheckIn
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DailyCheckInStreakCard(summary: summary),
                            const SizedBox(height: 40),
                            const DailyCheckInSectionTitle(title: 'Tuần này'),
                            const SizedBox(height: 22),
                            DailyCheckInWeekRow(summary: summary),
                            const SizedBox(height: 32),
                            DailyCheckInStatsCard(summary: summary),
                            const SizedBox(height: 46),
                            const DailyCheckInSectionTitle(
                              title: 'Đổi quà tặng',
                            ),
                            const SizedBox(height: 20),
                            DailyCheckInRewardGrid(points: summary.points),
                            if (controller.dailyCheckInErrorMessage !=
                                null) ...[
                              const SizedBox(height: 20),
                              DailyCheckInErrorMessage(
                                message: controller.dailyCheckInErrorMessage!,
                              ),
                            ],
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: DailyCheckInBottomAction(
          hasCheckedInToday: summary.hasCheckedIn(DateTime.now()),
          isLoading: controller.isClaimingDailyCheckIn,
          onPressed: () => _claim(context),
        ),
      ),
    );
  }

  Future<void> _claim(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final claimed = await context.read<HomeController>().claimDailyCheckIn();
    if (!context.mounted) {
      return;
    }

    messenger.showSnackBar(
      SnackBar(
        content: Text(
          claimed
              ? 'Điểm danh thành công. Bạn nhận được 10 điểm.'
              : 'Bạn đã điểm danh hôm nay.',
        ),
      ),
    );
  }
}
