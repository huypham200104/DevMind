import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({super.key});

  int _getSelectedIndex(BuildContext context) {
    final path = GoRouterState.of(context).uri.path;

    if (path == AppRoutePaths.technicalQuiz ||
        path.startsWith('${AppRoutePaths.technicalQuiz}/')) {
      return 1;
    }
    if (path == AppRoutePaths.ranking) return 2;
    if (path == AppRoutePaths.cvScanner) return 3;
    if (path == AppRoutePaths.profile) return 4;

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final isSelected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: isSelected
                ? AppColors.primaryGradientEnd
                : AppColors.textSecondary,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final isSelected = states.contains(WidgetState.selected);
          return TextStyle(
            color: isSelected
                ? AppColors.primaryGradientEnd
                : AppColors.textSecondary,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            letterSpacing: 0,
          );
        }),
      ),
      child: NavigationBar(
        selectedIndex: _getSelectedIndex(context),
        backgroundColor: AppColors.surface,
        indicatorColor: const Color(0xFFE8FAF8),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.goNamed(AppRouteNames.home);
              break;
            case 1:
              context.goNamed(AppRouteNames.technicalQuiz);
              break;
            case 2:
              context.goNamed(AppRouteNames.ranking);
              break;
            case 3:
              context.goNamed(AppRouteNames.cvScanner);
              break;
            case 4:
              context.goNamed(AppRouteNames.profile);
              break;
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          NavigationDestination(
            icon: Icon(Icons.quiz_outlined),
            selectedIcon: Icon(Icons.quiz),
            label: 'Luyện tập',
          ),
          NavigationDestination(
            icon: Icon(Icons.leaderboard_outlined),
            selectedIcon: Icon(Icons.leaderboard),
            label: 'Xếp hạng',
          ),
          NavigationDestination(
            icon: Icon(Icons.document_scanner_outlined),
            selectedIcon: Icon(Icons.document_scanner),
            label: 'Quét CV',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Hồ sơ',
          ),
        ],
      ),
    );
  }
}
