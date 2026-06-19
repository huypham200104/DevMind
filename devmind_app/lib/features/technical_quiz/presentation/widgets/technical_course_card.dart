import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/technical_course.dart';
import '../models/technical_quiz_ui.dart';

class TechnicalCourseCard extends StatelessWidget {
  const TechnicalCourseCard({
    super.key,
    required this.course,
    required this.onStart,
    this.onManage,
  });

  final TechnicalCourse course;
  final VoidCallback onStart;
  final VoidCallback? onManage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.primary.withAlpha(20),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withAlpha(60),
          width: 1.5,
        ),
      ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primary.withAlpha(30),
                ),
              ),
              child: Center(
                child: course.category == 'custom'
                    ? SvgPicture.asset(
                        'assets/icons/question.svg',
                        width: 26,
                        height: 26,
                        colorFilter: const ColorFilter.mode(
                          AppColors.primaryGradientEnd,
                          BlendMode.srcIn,
                        ),
                      )
                    : SvgPicture.network(
                        technicalCategoryLogoUrl(course.category),
                        width: 26,
                        height: 26,
                      ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withAlpha(25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${course.questionCount} CÂU HỎI',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.primaryGradientEnd,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0,
                          ),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    course.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
            ),
            if (onManage != null) ...[
              const SizedBox(width: 4),
              IconButton(
                onPressed: onManage,
                icon: const Icon(Icons.settings_outlined),
                color: AppColors.textSecondary,
                iconSize: 22,
                constraints: const BoxConstraints.tightFor(
                  width: 38,
                  height: 38,
                ),
                padding: EdgeInsets.zero,
                tooltip: 'Quản lý khóa học',
              ),
            ],
            const SizedBox(width: 8),
            SizedBox(
              height: 46,
              child: FilledButton(
                onPressed: onStart,
                style: FilledButton.styleFrom(
                  minimumSize: const Size(86, 46),
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Bắt đầu',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      );
  }
}
