import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/widgets/app_placeholder_screen.dart';
import '../../../home/presentation/widgets/home_bottom_navigation.dart';

class CvScannerScreen extends StatelessWidget {
  const CvScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPlaceholderScreen(
      title: 'Quét CV bằng AI',
      description:
          'Tính năng này sẽ nhập nội dung CV, gọi AI phân tích và trừ lượt quét theo hạn mức ví.',
      icon: Icons.document_scanner_outlined,
      bottomNavigationBar: const HomeBottomNavigation(),
      actions: [
        AppPlaceholderAction(
          label: 'Về trang chủ',
          onPressed: () => context.goNamed(AppRouteNames.home),
        ),
        AppPlaceholderAction(
          label: 'Xem ví lượt dùng',
          onPressed: () => context.goNamed(AppRouteNames.wallet),
        ),
      ],
    );
  }
}
