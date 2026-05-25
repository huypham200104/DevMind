import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    required this.displayName,
    required this.email,
    required this.photoUrl,
    required this.onEditProfile,
    super.key,
  });

  final String displayName;
  final String email;
  final String? photoUrl;
  final VoidCallback onEditProfile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileAvatar(photoUrl: photoUrl),
        const SizedBox(height: 10),
        Text(
          displayName,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: const Color(0xFF0F172A),
            fontWeight: FontWeight.w800,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          email,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: const Color(0xFF64748B),
            fontWeight: FontWeight.w500,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 34),
        OutlinedButton(
          onPressed: onEditProfile,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primaryGradientEnd,
            minimumSize: const Size(130, 30),
            side: const BorderSide(color: AppColors.primary, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Chỉnh sửa hồ sơ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.edit_outlined, size: 16),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({required this.photoUrl, super.key});

  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    final normalizedPhotoUrl = photoUrl?.trim();

    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A111827),
                    blurRadius: 24,
                    offset: Offset(0, 10),
                  ),
                ],
                image:
                    normalizedPhotoUrl != null && normalizedPhotoUrl.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(normalizedPhotoUrl),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: normalizedPhotoUrl == null || normalizedPhotoUrl.isEmpty
                  ? const _CodePreviewAvatar()
                  : null,
            ),
          ),
          Positioned(
            right: -2,
            bottom: 8,
            child: Container(
              width: 36,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(17),
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: const Icon(
                Icons.verified_outlined,
                color: Colors.white,
                size: 19,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CodePreviewAvatar extends StatelessWidget {
  const _CodePreviewAvatar();

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        padding: const EdgeInsets.all(10),
        color: const Color(0xFFF8FAFC),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 34,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF111827),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _CodeLine(width: 46),
                  _CodeLine(width: 52),
                  _CodeLine(width: 34),
                  _CodeLine(width: 44),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: 66,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: const Color(0xFFBFEAE6)),
              ),
            ),
            const SizedBox(height: 3),
            Container(
              width: 70,
              height: 12,
              decoration: const BoxDecoration(
                color: AppColors.primaryGradientEnd,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CodeLine extends StatelessWidget {
  const _CodeLine({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 3,
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
