import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../models/technical_quiz_ui.dart';

class TechnicalCategoryFilterSheet extends StatelessWidget {
  const TechnicalCategoryFilterSheet({
    super.key,
    required this.selectedCategory,
  });

  final String selectedCategory;

  @override
  Widget build(BuildContext context) {
    final maxSheetHeight = MediaQuery.sizeOf(context).height * 0.72;

    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxSheetHeight),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 6, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lọc theo danh mục',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0,
                ),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: technicalQuizCategories.map((category) {
                  final isSelected = category.id == selectedCategory;
                  return ChoiceChip(
                    selected: isSelected,
                    label: Text(category.title),
                    onSelected: (_) => Navigator.of(context).pop(category.id),
                    selectedColor: const Color(0xFFD8F8F5),
                    backgroundColor: const Color(0xFFF1F3F3),
                    labelStyle: TextStyle(
                      color: isSelected
                          ? AppColors.primaryGradientEnd
                          : AppColors.textSecondary,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0,
                    ),
                    side: BorderSide(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.transparent,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
