import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import 'profile_learning_stats_card.dart';

class ProfileWalletCard extends StatelessWidget {
  const ProfileWalletCard({
    required this.explainCredits,
    required this.cvScanCredits,
    required this.onTopUp,
    super.key,
  });

  final int? explainCredits;
  final int? cvScanCredits;
  final VoidCallback onTopUp;

  @override
  Widget build(BuildContext context) {
    return ProfileSurfaceCard(
      child: Column(
        children: [
          Row(
            children: [
              const ProfileIconBox(icon: Icons.account_balance_wallet_outlined),
              const SizedBox(width: 18),
              Expanded(
                child: Text(
                  'Ví của tôi',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: const Color(0xFF0F172A),
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0,
                  ),
                ),
              ),
              TextButton(
                onPressed: onTopUp,
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFE8FAF8),
                  foregroundColor: AppColors.primaryGradientEnd,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                child: const Text(
                  'NẠP THÊM',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.8,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 34),
          Row(
            children: [
              Expanded(
                child: _WalletMetricBox(
                  label: 'GIẢI THÍCH AI',
                  value: explainCredits,
                  icon: Icons.auto_awesome_rounded,
                  backgroundColor: AppColors.primary.withAlpha(15),
                  borderColor: AppColors.primary.withAlpha(40),
                  iconColor: AppColors.primary,
                  textColor: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _WalletMetricBox(
                  label: 'QUÉT CV',
                  value: cvScanCredits,
                  icon: Icons.document_scanner_rounded,
                  backgroundColor: AppColors.primary.withAlpha(15),
                  borderColor: AppColors.primary.withAlpha(40),
                  iconColor: AppColors.primary,
                  textColor: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WalletMetricBox extends StatelessWidget {
  const _WalletMetricBox({
    required this.label,
    required this.value,
    required this.icon,
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    required this.textColor,
  });

  final String label;
  final int? value;
  final IconData icon;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 22, color: iconColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: textColor.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value?.toString() ?? '0',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w900,
                    height: 1,
                  ),
                ),
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 3),
                  child: Text(
                    'lượt',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: textColor.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
