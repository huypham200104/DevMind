import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../models/technical_quiz_ui.dart';

class TechnicalSearchFilterBar extends StatelessWidget {
  const TechnicalSearchFilterBar({
    super.key,
    required this.controller,
    required this.selectedCategory,
    required this.onFilterTap,
  });

  final TextEditingController controller;
  final String selectedCategory;
  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    final hasCategoryFilter = selectedCategory != technicalAllCategory;

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: 'Tìm kiếm khóa học...',
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xFF667775),
                size: 28,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 18,
              ),
              fillColor: const Color(0xFFF0F0F0),
              hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: const Color(0xFF7A8190),
                fontWeight: FontWeight.w500,
                letterSpacing: 0,
              ),
            ),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0,
            ),
          ),
        ),
        const SizedBox(width: 14),
        SizedBox(
          width: 58,
          height: 58,
          child: FilledButton(
            onPressed: onFilterTap,
            style: FilledButton.styleFrom(
              backgroundColor: hasCategoryFilter
                  ? const Color(0xFFD8F8F5)
                  : const Color(0xFFF0F0F0),
              foregroundColor: hasCategoryFilter
                  ? AppColors.primaryGradientEnd
                  : AppColors.textSecondary,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Icon(Icons.tune, size: 28),
          ),
        ),
      ],
    );
  }
}
