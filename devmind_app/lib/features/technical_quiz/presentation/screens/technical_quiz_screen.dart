import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/widgets/app_placeholder_screen.dart';
import '../../../home/presentation/widgets/home_bottom_navigation.dart';

class TechnicalQuizScreen extends StatelessWidget {
  const TechnicalQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPlaceholderScreen(
      title: 'Trắc nghiệm kỹ thuật',
      description:
          'Tính năng này sẽ đọc câu hỏi từ Firestore và dùng ví lượt để kiểm tra lượt giải thích.',
      icon: Icons.quiz_outlined,
      bottomNavigationBar: const HomeBottomNavigation(),
      actions: [
        AppPlaceholderAction(
          label: 'Về trang chủ',
          onPressed: () => context.goNamed(AppRouteNames.home),
        ),
        AppPlaceholderAction(
          label: 'Nạp lượt dùng',
          onPressed: () => context.goNamed(AppRouteNames.payment),
        ),
      ],
    );
  }
}
