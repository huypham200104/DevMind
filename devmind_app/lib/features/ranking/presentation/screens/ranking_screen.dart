import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/widgets/app_placeholder_screen.dart';
import '../../../home/presentation/widgets/home_bottom_navigation.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPlaceholderScreen(
      title: 'Xếp hạng',
      description:
          'Ranking sẽ hiển thị bảng xếp hạng người dùng dựa trên điểm số tích lũy từ việc giải thích và làm bài tập. Điểm số này sẽ được quy đổi thành lượt dùng để người dùng có thể sử dụng cho các tính năng khác trong ứng dụng.',
      icon: Icons.leaderboard_outlined,
      bottomNavigationBar: const HomeBottomNavigation(),
      actions: [
        AppPlaceholderAction(
          label: 'Làm bài luyện tập',
          onPressed: () => context.goNamed(AppRouteNames.technicalQuiz),
        ),
        AppPlaceholderAction(
          label: 'Về trang chủ',
          onPressed: () => context.goNamed(AppRouteNames.home),
        ),
      ],
    );
  }
}
