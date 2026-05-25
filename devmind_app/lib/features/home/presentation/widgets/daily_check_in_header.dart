import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class DailyCheckInHeader extends StatelessWidget {
  const DailyCheckInHeader({super.key, required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 18, 10),
      child: Row(
        children: [
          const SizedBox(width: 48),
          Expanded(
            child: Text(
              'Điểm danh hằng ngày',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close, size: 30),
            color: AppColors.textPrimary,
            tooltip: 'Đóng',
          ),
        ],
      ),
    );
  }
}
