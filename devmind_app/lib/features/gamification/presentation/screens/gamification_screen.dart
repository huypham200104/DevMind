import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/widgets/app_placeholder_screen.dart';

class GamificationScreen extends StatelessWidget {
  const GamificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPlaceholderScreen(
      title: 'Game hóa',
      description:
          'Tính năng này sẽ xử lý chuỗi ngày học, bản đồ hoạt động, huy hiệu và phân tích sau phiên bản đầu.',
      icon: Icons.emoji_events_outlined,
      actions: [
        AppPlaceholderAction(
          label: 'Về trang chủ',
          onPressed: () => context.goNamed(AppRouteNames.home),
        ),
      ],
    );
  }
}
