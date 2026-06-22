import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../domain/entities/technical_course.dart';
import '../../domain/entities/technical_question.dart';
import '../controllers/technical_course_list_controller.dart';

class ManageCustomCourseScreen extends StatefulWidget {
  const ManageCustomCourseScreen({super.key, required this.courseId});

  final String courseId;

  @override
  State<ManageCustomCourseScreen> createState() =>
      _ManageCustomCourseScreenState();
}

class _ManageCustomCourseScreenState extends State<ManageCustomCourseScreen> {
  TechnicalCourse? _course;
  List<TechnicalQuestion>? _questions;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    final controller = context.read<TechnicalCourseListController>();
    final myCourses = controller.myCourses;
    _course = myCourses.firstWhere(
      (c) => c.id == widget.courseId,
      orElse: () => TechnicalCourse(
        id: widget.courseId,
        title: 'Khóa học',
        description: '',
        category: 'custom',
        questionCount: 0,
      ),
    );

    if (_course!.isMine) {
      final questions = await controller.loadQuestionsForCourse(_course!);
      if (mounted) {
        setState(() {
          _questions = questions;
          _isLoading = false;
        });
      }
    } else {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Quản lý khóa học',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.primaryGradientEnd,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings_outlined,
              color: AppColors.primaryGradientEnd,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'KHÓA HỌC TÙY CHỈNH',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.primaryGradientEnd,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _course?.title ?? '',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w800,
                                height: 1.2,
                              ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE2F7F5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.school_outlined,
                              color: AppColors.primaryGradientEnd,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${_questions?.length ?? 0} Câu hỏi',
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(
                                    color: AppColors.primaryGradientEnd,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Quản lý và chỉnh sửa danh sách câu hỏi trong khóa học của bạn.',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: _questions == null || _questions!.isEmpty
                      ? const Center(child: Text('Khóa học trống'))
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 120),
                          itemCount: _questions!.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final q = _questions![index];
                            return _ManageQuestionCard(
                              index: index + 1,
                              question: q,
                              onRemove: () => _removeQuestion(q),
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 54,
              child: OutlinedButton.icon(
                onPressed: _deleteCourse,
                icon: const Icon(Icons.delete_outline, size: 20),
                label: const Text(
                  'Xóa khóa học',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.danger,
                  side: const BorderSide(color: AppColors.danger),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Hành động này không thể hoàn tác. Tất cả dữ liệu của\nkhóa học này sẽ bị xóa vĩnh viễn.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _removeQuestion(TechnicalQuestion question) async {
    if (_course == null) return;

    final controller = context.read<TechnicalCourseListController>();

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa câu hỏi?'),
        content: const Text('Câu hỏi này sẽ bị xóa khỏi khóa học của bạn.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Hủy'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final success = await controller.removeQuestionFromCustomCourse(
      _course!.id,
      question.id,
    );

    if (success && mounted) {
      setState(() {
        _questions?.remove(question);
      });
      AppDialog.showSuccess(context, message: 'Đã xóa câu hỏi khỏi khóa học.');
    } else if (mounted) {
      AppDialog.showError(
        context,
        message: 'Không thể xóa câu hỏi. Vui lòng thử lại.',
      );
    }
  }

  Future<void> _deleteCourse() async {
    if (_course == null) return;

    final controller = context.read<TechnicalCourseListController>();

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa khóa học?'),
        content: Text('Khóa học "${_course!.title}" sẽ bị xóa vĩnh viễn.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Hủy'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final success = await controller.deleteMyCourse(_course!.id);

    if (success && mounted) {
      await AppDialog.showSuccess(context, message: 'Đã xóa khóa học.');
      if (mounted) {
        context.pop();
      }
    } else if (mounted) {
      AppDialog.showError(
        context,
        message: 'Không thể xóa khóa học. Vui lòng thử lại.',
      );
    }
  }
}

class _ManageQuestionCard extends StatelessWidget {
  const _ManageQuestionCard({
    required this.index,
    required this.question,
    required this.onRemove,
  });

  final int index;
  final TechnicalQuestion question;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A111827),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFFF1F5F9),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$index',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question.question,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${question.category} • Câu hỏi',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.delete_outline),
            color: AppColors.textSecondary,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
