import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class DailyCheckInBottomAction extends StatelessWidget {
  const DailyCheckInBottomAction({
    super.key,
    required this.hasCheckedInToday,
    required this.isLoading,
    required this.onPressed,
  });

  final bool hasCheckedInToday;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.primary.withAlpha(40), width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 52,
          child: FilledButton.icon(
            onPressed: hasCheckedInToday || isLoading ? null : onPressed,
            iconAlignment: IconAlignment.end,
            icon: isLoading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.check_rounded, size: 20),
            label: Text(
              hasCheckedInToday ? 'Đã điểm danh hôm nay ✓' : 'Điểm danh ngay',
            ),
            style: FilledButton.styleFrom(
              disabledBackgroundColor: AppColors.primary.withAlpha(40),
              disabledForegroundColor: AppColors.primaryGradientEnd,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
