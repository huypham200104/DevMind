import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class CvScannerHeader extends StatelessWidget {
  const CvScannerHeader({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back, size: 30),
            color: AppColors.primaryGradientEnd,
            tooltip: 'Quay lại',
          ),
          Expanded(
            child: Text(
              'Upload CV',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
                fontFamily: 'serif',
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
