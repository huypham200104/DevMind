import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/home_user_profile.dart';

class HomeHeaderActions extends StatelessWidget {
  const HomeHeaderActions({
    super.key,
    required this.profile,
    required this.user,
    required this.onCheckInTap,
    required this.onAvatarTap,
    required this.checkInPoints,
    required this.shouldPulseCheckIn,
  });

  final HomeUserProfile profile;
  final User user;
  final VoidCallback onCheckInTap;
  final VoidCallback onAvatarTap;
  final int checkInPoints;
  final bool shouldPulseCheckIn;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CheckInChip(
          onTap: onCheckInTap,
          points: checkInPoints,
          shouldPulse: shouldPulseCheckIn,
        ),
        const SizedBox(width: 14),
        _UserAvatar(
          photoUrl: profile.photoUrl ?? user.photoURL,
          onTap: onAvatarTap,
        ),
      ],
    );
  }
}

class _CheckInChip extends StatefulWidget {
  const _CheckInChip({
    required this.onTap,
    required this.points,
    required this.shouldPulse,
  });

  final VoidCallback onTap;
  final int points;
  final bool shouldPulse;

  @override
  State<_CheckInChip> createState() => _CheckInChipState();
}

class _CheckInChipState extends State<_CheckInChip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );
    _scaleAnimation = Tween<double>(
      begin: 1,
      end: 1.035,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _glowAnimation = Tween<double>(
      begin: 0.18,
      end: 0.42,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _syncAnimation();
  }

  @override
  void didUpdateWidget(covariant _CheckInChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.shouldPulse != widget.shouldPulse) {
      _syncAnimation();
    }
  }

  void _syncAnimation() {
    if (widget.shouldPulse) {
      _controller.repeat(reverse: true);
      return;
    }

    _controller.stop();
    _controller.value = 0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: widget.shouldPulse ? _scaleAnimation.value : 1,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              boxShadow: widget.shouldPulse
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(
                          alpha: _glowAnimation.value,
                        ),
                        blurRadius: 18,
                        spreadRadius: 1,
                      ),
                    ]
                  : const [],
            ),
            child: child,
          ),
        );
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
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
                  '${_formatPoints(widget.points)} điểm',
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
  const _UserAvatar({required this.photoUrl, required this.onTap});

  final String? photoUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final normalizedPhotoUrl = photoUrl?.trim();

    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
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
        ),
      ),
    );
  }
}
