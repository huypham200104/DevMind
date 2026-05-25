import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class CvPositionField extends StatelessWidget {
  const CvPositionField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vị trí ứng tuyển',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w800,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            hintText: 'Ví dụ: Software Engineer, Designer...',
            hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: const Color(0xFF9CA3AF),
              fontWeight: FontWeight.w500,
              letterSpacing: 0,
            ),
            filled: true,
            fillColor: AppColors.surface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 18,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD8DEE3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.primaryGradientEnd,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
