import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../models/technical_quiz_ui.dart';

class TechnicalQuizTabs extends StatelessWidget {
  const TechnicalQuizTabs({
    super.key,
    required this.selectedTab,
    required this.onChanged,
  });

  final TechnicalQuizTab selectedTab;
  final ValueChanged<TechnicalQuizTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _TabButton(
              label: 'Tất cả khóa học',
              isSelected: selectedTab == TechnicalQuizTab.allCourses,
              onTap: () => onChanged(TechnicalQuizTab.allCourses),
            ),
            _TabButton(
              label: 'Khóa học của tôi',
              isSelected: selectedTab == TechnicalQuizTab.myCourses,
              onTap: () => onChanged(TechnicalQuizTab.myCourses),
            ),
          ],
        ),
        Container(
          height: 1.2,
          color: AppColors.borderStrong.withValues(alpha: 0.75),
          child: Row(
            children: [
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  height: 3,
                  color: selectedTab == TechnicalQuizTab.allCourses
                      ? AppColors.primary
                      : Colors.transparent,
                ),
              ),
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  height: 3,
                  color: selectedTab == TechnicalQuizTab.myCourses
                      ? AppColors.primary
                      : Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: isSelected
                  ? AppColors.primaryGradientEnd
                  : AppColors.textSecondary,
              fontWeight: FontWeight.w800,
              letterSpacing: 0,
            ),
          ),
        ),
      ),
    );
  }
}
