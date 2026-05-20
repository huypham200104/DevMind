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
                child: _WalletMetric(
                  label: 'SỐ LƯỢT GIẢI THÍCH',
                  value: explainCredits,
                  description: 'AI Explanations',
                ),
              ),
              Container(width: 1, height: 92, color: const Color(0xFFE7EDF2)),
              Expanded(
                child: _WalletMetric(
                  label: 'SỐ LƯỢT SCAN CV',
                  value: cvScanCredits,
                  description: 'CV Scans',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WalletMetric extends StatelessWidget {
  const _WalletMetric({
    required this.label,
    required this.value,
    required this.description,
  });

  final String label;
  final int? value;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: const Color(0xFF94A3B8),
              fontWeight: FontWeight.w800,
              letterSpacing: 2.4,
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value?.toString() ?? 'Không có',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: const Color(0xFF0F172A),
                    fontWeight: FontWeight.w800,
                    fontSize: value == null ? 18 : null,
                    height: 1,
                    letterSpacing: 0,
                  ),
                ),
                if (value != null)
                  TextSpan(
                    text: ' còn lại',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: const Color(0xFF64748B),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.primaryGradientEnd,
              fontWeight: FontWeight.w600,
              letterSpacing: 0,
            ),
          ),
        ],
      ),
    );
  }
}
