import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/router.dart';
import '../../../../core/widgets/app_placeholder_screen.dart';
import '../../../home/presentation/widgets/home_bottom_navigation.dart';
import '../controllers/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    final user = authController.currentUser;

    if (user == null) {
      return AppPlaceholderScreen(
        title: 'Chưa đăng nhập',
        description: 'Bạn cần đăng nhập để xem hồ sơ cá nhân.',
        icon: Icons.account_circle_outlined,
        actions: [
          AppPlaceholderAction(
            label: 'Đăng nhập',
            onPressed: () => context.goNamed(AppRouteNames.signIn),
          ),
        ],
      );
    }

    return AppPlaceholderScreen(
      title: 'Hồ sơ cá nhân',
      description:
          '${user.displayName?.isNotEmpty == true ? user.displayName : 'Người dùng DevMind'}\n${user.email ?? 'Không có email'}',
      icon: Icons.account_circle_outlined,
      bottomNavigationBar: const HomeBottomNavigation(),
      actions: [
        AppPlaceholderAction(
          label: 'Về trang chủ',
          onPressed: () => context.goNamed(AppRouteNames.home),
        ),
        AppPlaceholderAction(
          label: authController.isLoading ? 'Đang đăng xuất...' : 'Đăng xuất',
          onPressed: authController.isLoading
              ? () {}
              : () async {
                  await context.read<AuthController>().signOut();
                  if (context.mounted) {
                    context.goNamed(AppRouteNames.welcome);
                  }
                },
        ),
      ],
    );
  }
}
