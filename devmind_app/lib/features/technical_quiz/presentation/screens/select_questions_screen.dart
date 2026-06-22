import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../domain/entities/technical_course.dart';
import '../../domain/entities/technical_question.dart';
import '../controllers/technical_course_list_controller.dart';

class SelectQuestionsScreen extends StatefulWidget {
  const SelectQuestionsScreen({super.key});

  @override
  State<SelectQuestionsScreen> createState() => _SelectQuestionsScreenState();
}

class _SelectQuestionsScreenState extends State<SelectQuestionsScreen> {
  final Set<String> _selectedIds = {};

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TechnicalCourseListController>();
    final courses = controller.allCourses;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Chọn câu hỏi',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Lựa chọn các chủ đề và câu hỏi cụ thể để xây dựng khóa học tùy chỉnh của bạn.',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              itemCount: courses.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return _CategoryAccordion(
                  course: courses[index],
                  selectedIds: _selectedIds,
                  onSelectionChanged: (id, selected) {
                    setState(() {
                      if (selected) {
                        if (_selectedIds.length >= 25) {
                          AppDialog.showError(
                            context,
                            message: 'Bạn chỉ được chọn tối đa 25 câu hỏi.',
                          );
                          return;
                        }
                        _selectedIds.add(id);
                      } else {
                        _selectedIds.remove(id);
                      }
                    });
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(
                  color: Color(0x0A111827),
                  blurRadius: 18,
                  offset: Offset(0, -8),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Đã chọn ${_selectedIds.length}/25 câu (tối thiểu 5 câu)',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: FilledButton.icon(
                      onPressed: _selectedIds.length >= 5
                          ? _showCreateDialog
                          : null,
                      iconAlignment: IconAlignment.end,
                      icon: const Icon(Icons.arrow_forward, size: 20),
                      label: const Text(
                        'Tạo khóa học',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      style: FilledButton.styleFrom(
                        disabledBackgroundColor: const Color(0xFFD9E2E0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showCreateDialog() async {
    final uid = context.read<AuthController>().currentUser?.uid;
    if (uid == null) return;

    final controller = context.read<TechnicalCourseListController>();

    final existingCourseNames = controller.myCourses
        .map((c) => c.title.toLowerCase().trim())
        .toList();

    final title = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          _CreateCourseDialog(existingCourseNames: existingCourseNames),
    );

    if (title == null || title.trim().isEmpty) return;

    if (!mounted) return;

    final success = await controller.createCustomCourse(
      uid,
      title.trim(),
      _selectedIds.toList(),
    );

    if (!mounted) return;

    if (success) {
      await AppDialog.showSuccess(context, message: 'Tạo khóa học thành công!');
      if (mounted) {
        context.pop();
      }
    } else {
      AppDialog.showError(
        context,
        message: 'Đã có lỗi xảy ra. Vui lòng thử lại.',
      );
    }
  }
}

class _CategoryAccordion extends StatefulWidget {
  const _CategoryAccordion({
    required this.course,
    required this.selectedIds,
    required this.onSelectionChanged,
  });

  final TechnicalCourse course;
  final Set<String> selectedIds;
  final void Function(String, bool) onSelectionChanged;

  @override
  State<_CategoryAccordion> createState() => _CategoryAccordionState();
}

class _CategoryAccordionState extends State<_CategoryAccordion> {
  List<TechnicalQuestion>? _questions;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: ExpansionTile(
        onExpansionChanged: (expanded) {
          if (expanded && _questions == null) {
            _loadQuestions();
          }
        },
        shape: const RoundedRectangleBorder(side: BorderSide.none),
        collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFE2F7F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              'assets/icons/lesson.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.primaryGradientEnd,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        title: Text(
          widget.course.title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          '${widget.course.questionCount} câu hỏi khả dụng',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
        ),
        children: [
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_questions != null)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _questions!.length,
              itemBuilder: (context, index) {
                final q = _questions![index];
                final isSelected = widget.selectedIds.contains(q.id);
                return CheckboxListTile(
                  value: isSelected,
                  onChanged: (val) {
                    if (val != null) widget.onSelectionChanged(q.id, val);
                  },
                  title: Text(
                    q.question,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                  activeColor: AppColors.primaryGradientEnd,
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                );
              },
            ),
        ],
      ),
    );
  }

  Future<void> _loadQuestions() async {
    setState(() => _isLoading = true);
    final questions = await context
        .read<TechnicalCourseListController>()
        .loadQuestionsForCourse(widget.course);
    if (!mounted) return;
    setState(() {
      _questions = questions;
      _isLoading = false;
    });
  }
}

class _CreateCourseDialog extends StatefulWidget {
  const _CreateCourseDialog({required this.existingCourseNames});

  final List<String> existingCourseNames;

  @override
  State<_CreateCourseDialog> createState() => _CreateCourseDialogState();
}

class _CreateCourseDialogState extends State<_CreateCourseDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Đặt tên khóa học',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Tên khóa học',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'VD: Nhập môn Trí tuệ nhân tạo...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.primaryGradientEnd,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.primaryGradientEnd,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.primaryGradientEnd,
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tên khóa học nên ngắn gọn và thể hiện rõ nội dung.',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton.icon(
                onPressed: () {
                  final text = _controller.text.trim();
                  if (text.isEmpty) return;
                  if (widget.existingCourseNames.contains(text.toLowerCase())) {
                    AppDialog.showError(
                      context,
                      message:
                          'Tên khóa học đã tồn tại. Vui lòng chọn tên khác.',
                    );
                    return;
                  }
                  Navigator.of(context).pop(text);
                },
                iconAlignment: IconAlignment.end,
                icon: const Icon(Icons.arrow_forward, size: 18),
                label: const Text('Tạo ngay'),
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Hủy',
                  style: TextStyle(
                    color: AppColors.primaryGradientEnd,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
