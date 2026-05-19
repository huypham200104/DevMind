import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/widgets/app_placeholder_screen.dart';

class IqQuizScreen extends StatelessWidget {
  const IqQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPlaceholderScreen(
      title: 'IQ và tư duy logic',
      description:
          'Tính năng này sẽ cho người dùng làm bài IQ và dùng AI để đánh giá phong cách tư duy.',
      icon: Icons.extension_outlined,
      actions: [
        AppPlaceholderAction(
          label: 'Về trang chủ',
          onPressed: () => context.goNamed(AppRouteNames.home),
        ),
      ],
    );
  }
}
