import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/router.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../home/presentation/widgets/home_bottom_navigation.dart';
import '../../domain/entities/technical_course.dart';
import '../controllers/technical_quiz_controller.dart';
import '../models/technical_quiz_ui.dart';
import '../widgets/all_courses_section.dart';
import '../widgets/my_courses_section.dart';
import '../widgets/technical_quiz_tabs.dart';

class TechnicalQuizScreen extends StatefulWidget {
  const TechnicalQuizScreen({super.key});

  @override
  State<TechnicalQuizScreen> createState() => _TechnicalQuizScreenState();
}

class _TechnicalQuizScreenState extends State<TechnicalQuizScreen> {
  TechnicalQuizTab _selectedTab = TechnicalQuizTab.allCourses;
  bool _hasScheduledCourseWatch = false;
  String? _watchedCoursesUid;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final user = context.watch<AuthController>().currentUser;
    final uid = user?.uid;
    if (_hasScheduledCourseWatch && _watchedCoursesUid == uid) {
      return;
    }

    _hasScheduledCourseWatch = true;
    _watchedCoursesUid = uid;
    final controller = context.read<TechnicalQuizController>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted || _watchedCoursesUid != uid) {
        return;
      }

      // Đợi animation chuyển trang hoàn tất (khoảng 300-350ms)
      // Việc này giúp tránh hiện tượng giật lag (jank) khi render quá nhiều SVG 
      // và call Firebase cùng lúc với animation chuyển màn hình.
      await Future.delayed(const Duration(milliseconds: 350));
      
      if (!mounted || _watchedCoursesUid != uid) {
        return;
      }

      controller.watchAllCourses();
      controller.watchMyCourses(uid);
    });
  }


  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthController>().currentUser;
    final controller = context.watch<TechnicalQuizController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      bottomNavigationBar: const HomeBottomNavigation(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AppHeader(
                title: 'DevMind AI',
                onBack: _handleBack,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 44, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TechnicalQuizTabs(
                      selectedTab: _selectedTab,
                      onChanged: (tab) => setState(() => _selectedTab = tab),
                    ),
                    const SizedBox(height: 26),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 180),
                      child: _selectedTab == TechnicalQuizTab.allCourses
                          ? AllCoursesSection(
                              key: const ValueKey('all-courses'),
                              courses: controller.allCourses,
                              isLoading: controller.isLoadingAllCourses,
                              errorMessage: controller.allCoursesErrorMessage,
                              onStart: _showStartMessage,
                            )
                          : MyCoursesSection(
                              key: const ValueKey('my-courses'),
                              userId: user?.uid,
                              courses: controller.myCourses,
                              isLoading: controller.isLoadingMyCourses,
                              errorMessage: controller.myCoursesErrorMessage,
                              onCreate: _navigateToCreateCourse,
                              onStart: _showStartMessage,
                              onManage: _manageCourse,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _handleBack() {
    if (context.canPop()) {
      context.pop();
      return;
    }

    context.goNamed(AppRouteNames.home);
  }

  void _showStartMessage(TechnicalCourse course) {
    context.goNamed(
      AppRouteNames.technicalCourseDetail,
      pathParameters: {'courseId': course.id},
      queryParameters: {'scope': course.isMine ? 'mine' : 'all'},
      extra: course,
    );
  }

  void _navigateToCreateCourse() {
    final controller = context.read<TechnicalQuizController>();
    if (controller.myCourses.length >= 5) {
      AppDialog.showError(
        context,
        message: 'Bạn chỉ có thể tạo tối đa 5 khóa học tùy chỉnh.',
      );
      return;
    }
    context.pushNamed(AppRouteNames.createTechnicalCourse);
  }

  void _manageCourse(TechnicalCourse course) {
    context.pushNamed(
      AppRouteNames.manageTechnicalCourse,
      pathParameters: {'courseId': course.id},
    );
  }
}
