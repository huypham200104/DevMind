import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({required this.onBack, super.key});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          SizedBox(
            width: 48,
            child: IconButton(
              tooltip: 'Quay lại',
              onPressed: onBack,
              icon: const Icon(
                Icons.chevron_left,
                color: AppColors.primary,
                size: 26,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'DevMind AI',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                letterSpacing: 0,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}
