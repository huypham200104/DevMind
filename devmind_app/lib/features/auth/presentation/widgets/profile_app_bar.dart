import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({required this.onLogoutPressed, super.key});

  final VoidCallback onLogoutPressed;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 18, 22, 10),
        child: Row(
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
            PopupMenuButton<_ProfileMenuAction>(
              tooltip: 'Cài đặt',
              position: PopupMenuPosition.under,
              color: AppColors.surface,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onSelected: (action) {
                switch (action) {
                  case _ProfileMenuAction.logout:
                    onLogoutPressed();
                    break;
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: _ProfileMenuAction.logout,
                  child: _LogoutMenuItem(),
                ),
              ],
              icon: const Icon(
                Icons.settings_outlined,
                color: Color(0xFF64748B),
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _ProfileMenuAction { logout }

class _LogoutMenuItem extends StatelessWidget {
  const _LogoutMenuItem();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.logout, color: AppColors.danger, size: 20),
        SizedBox(width: 10),
        Text(
          'Đăng xuất',
          style: TextStyle(
            color: AppColors.danger,
            fontWeight: FontWeight.w700,
            letterSpacing: 0,
          ),
        ),
      ],
    );
  }
}
