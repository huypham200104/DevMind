import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../../home/presentation/widgets/home_bottom_navigation.dart';
import '../../domain/entities/technical_course.dart';
import '../controllers/technical_quiz_controller.dart';
import '../models/technical_quiz_ui.dart';
import '../widgets/all_courses_section.dart';
import '../widgets/my_courses_section.dart';
import '../widgets/technical_category_filter_sheet.dart';
import '../widgets/technical_quiz_header.dart';
import '../widgets/technical_quiz_tabs.dart';
import '../widgets/technical_search_filter_bar.dart';

class TechnicalQuizScreen extends StatefulWidget {
  const TechnicalQuizScreen({super.key});

  @override
  State<TechnicalQuizScreen> createState() => _TechnicalQuizScreenState();
}

class _TechnicalQuizScreenState extends State<TechnicalQuizScreen> {
  final _searchController = TextEditingController();

  TechnicalQuizTab _selectedTab = TechnicalQuizTab.allCourses;
  String _searchQuery = '';
  String _selectedCategory = technicalAllCategory;
  bool _hasScheduledCourseWatch = false;
  String? _watchedCoursesUid;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_syncSearchQuery);
  }

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _watchedCoursesUid != uid) {
        return;
      }

      controller.watchAllCourses();
      controller.watchMyCourses(uid);
    });
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_syncSearchQuery)
      ..dispose();
    super.dispose();
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
            TechnicalQuizHeader(onBack: _handleBack),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 44, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(context),
                    const SizedBox(height: 34),
                    TechnicalSearchFilterBar(
                      controller: _searchController,
                      selectedCategory: _selectedCategory,
                      onFilterTap: _openCategoryFilter,
                    ),
                    const SizedBox(height: 34),
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
                              selectedCategory: _selectedCategory,
                              searchQuery: _searchQuery,
                              onStart: _showStartMessage,
                            )
                          : MyCoursesSection(
                              key: const ValueKey('my-courses'),
                              userId: user?.uid,
                              courses: controller.myCourses,
                              isLoading: controller.isLoadingMyCourses,
                              errorMessage: controller.myCoursesErrorMessage,
                              selectedCategory: _selectedCategory,
                              searchQuery: _searchQuery,
                              onCreate: _showCreateCourseMessage,
                              onStart: _showStartMessage,
                              onDelete: _deleteCourse,
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

  Widget _buildTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ôn tập kỹ thuật',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w800,
            height: 1.08,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Chọn một danh mục để bắt đầu kiểm tra kiến thức của bạn.',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.textSecondary,
            height: 1.55,
            fontWeight: FontWeight.w500,
            letterSpacing: 0,
          ),
        ),
      ],
    );
  }

  void _syncSearchQuery() {
    final nextQuery = _searchController.text.trim();
    if (nextQuery == _searchQuery) {
      return;
    }

    setState(() => _searchQuery = nextQuery);
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

  void _showCreateCourseMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Tính năng tạo khóa học sẽ được kết nối ở bước tiếp theo.',
        ),
      ),
    );
  }

  Future<void> _deleteCourse(TechnicalCourse course) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa khóa học?'),
        content: Text(
          'Khóa học "${course.title}" sẽ bị xóa khỏi danh sách của bạn.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Hủy'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );

    if (confirmed != true) {
      return;
    }

    if (!mounted) {
      return;
    }

    final controller = context.read<TechnicalQuizController>();
    final deleted = await controller.deleteMyCourse(course.id);
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          deleted
              ? 'Đã xóa khóa học.'
              : 'Không thể xóa khóa học. Vui lòng thử lại.',
        ),
      ),
    );
  }

  Future<void> _openCategoryFilter() async {
    final nextCategory = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      builder: (context) =>
          TechnicalCategoryFilterSheet(selectedCategory: _selectedCategory),
    );

    if (nextCategory == null || nextCategory == _selectedCategory) {
      return;
    }

    setState(() => _selectedCategory = nextCategory);
  }
}
