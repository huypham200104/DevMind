import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../domain/entities/technical_course.dart';
import '../controllers/technical_quiz_controller.dart';
import '../models/technical_quiz_ui.dart';

class TechnicalCourseDetailScreen extends StatefulWidget {
  const TechnicalCourseDetailScreen({
    super.key,
    required this.courseId,
    required this.isMine,
    this.initialCourse,
  });

  final String courseId;
  final bool isMine;
  final TechnicalCourse? initialCourse;

  @override
  State<TechnicalCourseDetailScreen> createState() =>
      _TechnicalCourseDetailScreenState();
}

class _TechnicalCourseDetailScreenState
    extends State<TechnicalCourseDetailScreen> {
  bool _hasScheduledCourseWatch = false;
  String? _watchedUid;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final uid = context.watch<AuthController>().currentUser?.uid;
    if (_hasScheduledCourseWatch && _watchedUid == uid) {
      return;
    }

    _hasScheduledCourseWatch = true;
    _watchedUid = uid;
    final controller = context.read<TechnicalQuizController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _watchedUid != uid) {
        return;
      }

      controller.watchAllCourses();
      controller.watchMyCourses(uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TechnicalQuizController>();
    final course = _resolveCourse(controller);
    final isLoading = widget.isMine
        ? controller.isLoadingMyCourses
        : controller.isLoadingAllCourses;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Column(
          children: [
            _DetailHeader(
              title: course?.title ?? 'Chi tiết bài học',
              onBack: _handleBack,
            ),
            Expanded(
              child: course == null
                  ? _MissingCourseState(isLoading: isLoading)
                  : _DetailContent(course: course),
            ),
            if (course != null)
              _DetailActions(
                onStart: () => _showStartQuizMessage(course),
                onBackToCourses: () =>
                    context.goNamed(AppRouteNames.technicalQuiz),
              ),
          ],
        ),
      ),
    );
  }

  TechnicalCourse? _resolveCourse(TechnicalQuizController controller) {
    if (widget.initialCourse != null) {
      return widget.initialCourse;
    }

    final courses = widget.isMine
        ? controller.myCourses
        : controller.allCourses;
    for (final course in courses) {
      if (course.id == widget.courseId) {
        return course;
      }
    }

    return null;
  }

  void _handleBack() {
    if (context.canPop()) {
      context.pop();
      return;
    }

    context.goNamed(AppRouteNames.technicalQuiz);
  }

  void _showStartQuizMessage(TechnicalCourse course) {
    context.goNamed(
      AppRouteNames.technicalQuestion,
      pathParameters: {'courseId': course.id},
      queryParameters: {'scope': course.isMine ? 'mine' : 'all'},
      extra: course,
    );
  }
}

class _DetailHeader extends StatelessWidget {
  const _DetailHeader({required this.title, required this.onBack});

  final String title;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back, size: 28),
            color: AppColors.textPrimary,
            tooltip: 'Quay lại',
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.course});

  final TechnicalCourse course;

  @override
  Widget build(BuildContext context) {
    final durationMinutes = course.questionCount + 5;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _CourseIcon(category: course.category),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  course.title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                        letterSpacing: 0,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            course.description,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  letterSpacing: 0,
                ),
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  icon: Icons.quiz_outlined,
                  value: course.questionCount.toString(),
                  label: 'CÂU HỎI',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _MetricCard(
                  icon: Icons.timer_outlined,
                  value: durationMinutes.toString(),
                  label: 'PHÚT',
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          const _ImportantNotice(),
        ],
      ),
    );
  }
}

class _CourseIcon extends StatelessWidget {
  const _CourseIcon({required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: const BoxDecoration(
        color: Color(0xFFE2F7F5),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.network(
          technicalCategoryLogoUrl(category),
          width: 32,
          height: 32,
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 100),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D111827),
            blurRadius: 28,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primaryGradientEnd, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0,
                ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.1,
                ),
          ),
        ],
      ),
    );
  }
}

class _ImportantNotice extends StatelessWidget {
  const _ImportantNotice();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3F3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFF6B8B8), width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: const BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x14111827),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              color: AppColors.danger,
              size: 34,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lưu ý quan trọng',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Nếu bạn thoát ra trong khi đang làm bài, kết quả sẽ không được ghi nhận và tiến trình sẽ bị xóa hoàn toàn.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                    height: 1.45,
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailActions extends StatelessWidget {
  const _DetailActions({required this.onStart, required this.onBackToCourses});

  final VoidCallback onStart;
  final VoidCallback onBackToCourses;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 18, 28, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 64,
            child: FilledButton.icon(
              onPressed: onStart,
              icon: const Icon(Icons.play_circle_outline, size: 24),
              label: const Text('Bắt đầu làm bài'),
              style: FilledButton.styleFrom(
                textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 64,
            child: OutlinedButton(
              onPressed: onBackToCourses,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary),
                textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0,
                ),
              ),
              child: const Text('Quay về tất cả khóa học'),
            ),
          ),
        ],
      ),
    );
  }
}

class _MissingCourseState extends StatelessWidget {
  const _MissingCourseState({required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.search_off_outlined,
              color: AppColors.primaryGradientEnd,
              size: 44,
            ),
            const SizedBox(height: 16),
            Text(
              'Không tìm thấy bài học',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Quay lại danh sách khóa học để chọn lại bài học.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
                height: 1.45,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => context.goNamed(AppRouteNames.technicalQuiz),
              child: const Text('Quay về tất cả khóa học'),
            ),
          ],
        ),
      ),
    );
  }
}
