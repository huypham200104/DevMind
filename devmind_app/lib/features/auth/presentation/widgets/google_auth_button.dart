import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app/theme/app_colors.dart';

class GoogleAuthButton extends StatelessWidget {
  const GoogleAuthButton({
    required this.enabled,
    required this.label,
    required this.onPressed,
    super.key,
  });

  final bool enabled;
  final String label;
  final Future<void> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.borderStrong),
          textStyle: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        onPressed: enabled ? () => onPressed() : null,
        icon: SvgPicture.asset(
          'assets/icons/google-logo.svg',
          width: 18,
          height: 18,
        ),
        label: Text(label),
      ),
    );
  }
}
