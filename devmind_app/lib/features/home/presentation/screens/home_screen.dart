import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/widgets/app_placeholder_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPlaceholderScreen(
      title: 'Trang chủ',
      description:
          'Trang điều hướng chính cho các tính năng MVP của DevMind AI.',
      icon: Icons.dashboard_outlined,
      actions: [
        AppPlaceholderAction(
          label: 'Trắc nghiệm kỹ thuật',
          onPressed: () => context.goNamed(AppRouteNames.technicalQuiz),
        ),
        AppPlaceholderAction(
          label: 'Quét CV bằng AI',
          onPressed: () => context.goNamed(AppRouteNames.cvScanner),
        ),
        AppPlaceholderAction(
          label: 'Ví lượt dùng',
          onPressed: () => context.goNamed(AppRouteNames.wallet),
        ),
        AppPlaceholderAction(
          label: 'Thanh toán',
          onPressed: () => context.goNamed(AppRouteNames.payment),
        ),
        AppPlaceholderAction(
          label: 'Hồ sơ',
          onPressed: () => context.goNamed(AppRouteNames.profile),
        ),
      ],
    );
  }
}
