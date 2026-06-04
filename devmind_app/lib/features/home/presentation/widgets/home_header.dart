import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/home_user_profile.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.profile,
    required this.user,
    required this.onCheckInTap,
    required this.checkInPoints,
  });

  final HomeUserProfile profile;
  final User user;
  final VoidCallback onCheckInTap;
  final int checkInPoints;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'DevMind AI',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
              letterSpacing: 0,
            ),
          ),
        ),
        _CheckInChip(onTap: onCheckInTap, points: checkInPoints),
        const SizedBox(width: 14),
        _UserAvatar(photoUrl: profile.photoUrl ?? user.photoURL),
      ],
    );
  }
}

class _CheckInChip extends StatelessWidget {
  const _CheckInChip({required this.onTap, required this.points});

  final VoidCallback onTap;
  final int points;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFD6F8F4),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.event_available_outlined,
                color: AppColors.primaryGradientEnd,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '${_formatPoints(points)} điểm',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.primaryGradientEnd,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatPoints(int value) {
    if (value > 9999) {
      return '9999+';
    }

    return value.toString();
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar({required this.photoUrl});

  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    final normalizedPhotoUrl = photoUrl?.trim();

    return Container(
      width: 42,
      height: 42,
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        backgroundColor: const Color(0xFFE8FAF8),
        backgroundImage:
            normalizedPhotoUrl != null && normalizedPhotoUrl.isNotEmpty
            ? NetworkImage(normalizedPhotoUrl)
            : null,
        child: normalizedPhotoUrl == null || normalizedPhotoUrl.isEmpty
            ? const Icon(
                Icons.person_outline,
                color: AppColors.primaryGradientEnd,
              )
            : null,
      ),
    );
  }
}
