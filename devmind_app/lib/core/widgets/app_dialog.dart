import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

class AppDialog extends StatelessWidget {
  const AppDialog._({
    required this.title,
    required this.message,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
  });

  final String title;
  final String message;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;

  static Future<void> showSuccess(
    BuildContext context, {
    String title = 'Thành công',
    required String message,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => AppDialog._(
        title: title,
        message: message,
        icon: Icons.check,
        iconColor: AppColors.primaryGradientEnd,
        iconBackgroundColor: const Color(0xFFE8FAF8),
      ),
    );
  }

  static Future<void> showError(
    BuildContext context, {
    String title = 'Đã có lỗi xảy ra',
    required String message,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => AppDialog._(
        title: title,
        message: message,
        icon: Icons.close,
        iconColor: AppColors.danger,
        iconBackgroundColor: const Color(0xFFFDECEE),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 36,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.45,
                  ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Đóng'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
