import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      decoration: const BoxDecoration(
        color: Color(0xFFF7F7F7),
        border: Border(top: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 68,
          child: FilledButton.icon(
            onPressed: hasCheckedInToday || isLoading ? null : onPressed,
            iconAlignment: IconAlignment.end,
            icon: isLoading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.arrow_forward, size: 24),
            label: Text(
              hasCheckedInToday ? 'Đã điểm danh hôm nay' : 'Điểm danh ngay',
            ),
            style: FilledButton.styleFrom(
              disabledBackgroundColor: const Color(0xFFD9E2E0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
