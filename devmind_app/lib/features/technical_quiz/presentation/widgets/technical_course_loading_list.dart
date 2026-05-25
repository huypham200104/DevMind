import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class TechnicalCourseLoadingList extends StatelessWidget {
  const TechnicalCourseLoadingList({super.key, this.itemCount = 3});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < itemCount; index++) ...[
          Container(
            height: 104,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2.4),
            ),
          ),
          if (index != itemCount - 1) const SizedBox(height: 14),
        ],
      ],
    );
  }
}
