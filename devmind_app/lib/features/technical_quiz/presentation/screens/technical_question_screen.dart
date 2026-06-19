import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../domain/entities/technical_course.dart';
import '../../domain/entities/technical_question.dart';
import '../controllers/technical_quiz_controller.dart';
import '../models/technical_quiz_ui.dart';

class TechnicalQuestionScreen extends StatefulWidget {
  const TechnicalQuestionScreen({
    super.key,
    required this.courseId,
    required this.isMine,
    this.initialCourse,
  });

  final String courseId;
  final bool isMine;
  final TechnicalCourse? initialCourse;

  @override
  State<TechnicalQuestionScreen> createState() =>
      _TechnicalQuestionScreenState();
}

class _TechnicalQuestionScreenState extends State<TechnicalQuestionScreen> {
  bool _hasScheduledCourseWatch = false;
  String? _watchedUid;
  String? _startedCourseId;
  String? _startedUid;
  String? _handledCompletedCourseId;

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
    final user = context.watch<AuthController>().currentUser;
    final controller = context.watch<TechnicalQuizController>();
    final course = _resolveCourse(controller);

    final didScheduleStart = _scheduleStartQuiz(controller, course, user?.uid);
    if (!didScheduleStart) {
      _handleQuizCompletion(controller, course);
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          _confirmExit(course);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7F8),
        body: SafeArea(
          child: Column(
            children: [
              _QuestionHeader(
                explainCredits: controller.explainCredits,
                onBack: () => _confirmExit(course),
              ),
              Expanded(
                child: _QuestionBody(
                  course: course,
                  controller: controller,
                  onExplain: _revealExplanation,
                  onSubmit: _submitAnswer,
                ),
              ),
            ],
          ),
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

  bool _scheduleStartQuiz(
    TechnicalQuizController controller,
    TechnicalCourse? course,
    String? uid,
  ) {
    if (course == null ||
        (_startedCourseId == course.id && _startedUid == uid)) {
      return false;
    }

    _startedCourseId = course.id;
    _startedUid = uid;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _startedCourseId != course.id || _startedUid != uid) {
        return;
      }

      controller.startQuiz(course: course, uid: uid);
    });

    return true;
  }

  void _handleQuizCompletion(
    TechnicalQuizController controller,
    TechnicalCourse? course,
  ) {
    if (!controller.isQuizCompleted) {
      _handledCompletedCourseId = null;
      return;
    }

    if (course == null || _handledCompletedCourseId == course.id) {
      return;
    }

    _handledCompletedCourseId = course.id;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _handledCompletedCourseId != course.id) {
        return;
      }

      context.goNamed(
        AppRouteNames.technicalQuizResult,
        pathParameters: {'courseId': course.id},
        queryParameters: {'scope': course.isMine ? 'mine' : 'all'},
        extra: course,
      );
    });
  }

  Future<void> _revealExplanation() async {
    final controller = context.read<TechnicalQuizController>();
    if (controller.isQuizCompleted) {
      return;
    }

    final revealed = await controller.revealCurrentExplanation();
    if (!mounted || revealed) {
      return;
    }
    AppDialog.showError(context, message: 'Bạn đã hết lượt giải thích.');
  }

  void _submitAnswer() {
    final controller = context.read<TechnicalQuizController>();
    if (controller.isQuizCompleted) {
      return;
    }

    if (controller.selectedAnswerIndex == null) {
      AppDialog.showError(context, message: 'Vui lòng chọn một đáp án.');
      return;
    }

    controller.submitCurrentAnswer();
  }

  Future<void> _confirmExit(TechnicalCourse? course) async {
    final shouldExit = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => const _ExitQuizDialog(),
    );

    if (!mounted || shouldExit != true) {
      return;
    }

    context.read<TechnicalQuizController>().abandonQuiz();

    if (course == null) {
      context.goNamed(AppRouteNames.technicalQuiz);
      return;
    }

    context.goNamed(
      AppRouteNames.technicalCourseDetail,
      pathParameters: {'courseId': course.id},
      queryParameters: {'scope': course.isMine ? 'mine' : 'all'},
      extra: course,
    );
  }
}

class _QuestionHeader extends StatelessWidget {
  const _QuestionHeader({required this.explainCredits, required this.onBack});

  final int explainCredits;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 18, 12),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back, size: 24),
            color: AppColors.textPrimary,
            tooltip: 'Quay lại',
          ),
          Expanded(
            child: Text(
              'DevMind AI',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFE5FAF8),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: const Color(0xFFB9F1EC)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.bolt_outlined,
                  color: AppColors.primaryGradientEnd,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  '$explainCredits LƯỢT GIẢI THÍCH',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.primaryGradientEnd,
                    fontWeight: FontWeight.w800,
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

class _QuestionBody extends StatelessWidget {
  const _QuestionBody({
    required this.course,
    required this.controller,
    required this.onExplain,
    required this.onSubmit,
  });

  final TechnicalCourse? course;
  final TechnicalQuizController controller;
  final VoidCallback onExplain;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final activeCourse = course;
    if (activeCourse == null) {
      return const _QuizStateMessage(
        icon: Icons.search_off_outlined,
        title: 'Không tìm thấy bài học',
        description: 'Quay lại danh sách khóa học để chọn lại bài học.',
      );
    }

    if (controller.isLoadingQuestions) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.questionsErrorMessage != null) {
      return _QuizStateMessage(
        icon: Icons.cloud_off_outlined,
        title: 'Không thể tải câu hỏi',
        description: controller.questionsErrorMessage!,
      );
    }

    final question = controller.currentQuestion;
    if (question == null) {
      return const _QuizStateMessage(
        icon: Icons.quiz_outlined,
        title: 'Chưa có câu hỏi',
        description: 'Khóa học này chưa có câu hỏi để luyện tập.',
      );
    }

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 28, 18, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _QuestionProgress(
                  currentQuestion: controller.currentQuestionIndex + 1,
                  totalQuestions: controller.totalQuestions,
                  progress: controller.quizProgress,
                  remainingSeconds: controller.remainingSeconds,
                ),
                const SizedBox(height: 22),
                _QuestionCard(
                  question: question,
                  index: controller.currentQuestionIndex,
                ),
                const SizedBox(height: 16),
                _ExplanationButton(
                  isVisible: controller.isCurrentExplanationVisible,
                  isLoading: controller.isConsumingExplainCredit,
                  hasCredits: controller.explainCredits > 0,
                  isQuizCompleted: controller.isQuizCompleted,
                  onPressed: onExplain,
                ),
                if (controller.isCurrentExplanationVisible) ...[
                  const SizedBox(height: 14),
                  _ExplanationCard(explanation: question.explanation),
                ],
                const SizedBox(height: 20),
                for (var index = 0; index < question.options.length; index++) ...[
                  _AnswerOption(
                    letter: _optionLetter(index),
                    text: question.options[index],
                    isSelected: controller.selectedAnswerIndex == index,
                    onTap: controller.isQuizCompleted
                        ? null
                        : () => controller.selectAnswer(index),
                  ),
                  const SizedBox(height: 12),
                ],
                const SizedBox(height: 28),
                _ConceptFocusCard(course: activeCourse),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
          decoration: const BoxDecoration(
            color: Color(0xFFF6F7F8),
            border: Border(top: BorderSide(color: Color(0xFFE0E6E8))),
          ),
          child: SizedBox(
            width: double.infinity,
            height: 62,
            child: FilledButton.icon(
              onPressed: controller.isQuizCompleted ? null : onSubmit,
              iconAlignment: IconAlignment.end,
              icon: const Icon(Icons.arrow_forward, size: 22),
              label: Text(
                controller.currentQuestionIndex >= controller.totalQuestions - 1
                    ? 'Hoàn thành'
                    : 'Nộp câu trả lời',
              ),
              style: FilledButton.styleFrom(
                textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _optionLetter(int index) {
    return String.fromCharCode('A'.codeUnitAt(0) + index);
  }
}

class _QuestionProgress extends StatelessWidget {
  const _QuestionProgress({
    required this.currentQuestion,
    required this.totalQuestions,
    required this.progress,
    required this.remainingSeconds,
  });

  final int currentQuestion;
  final int totalQuestions;
  final double progress;
  final int remainingSeconds;

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).round();
    final timeText = _formatRemainingTime(remainingSeconds);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'CÂU HỎI $currentQuestion/$totalQuestions',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0,
                ),
              ),
            ),
            Text(
              '$percent% HOÀN THÀNH',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.primaryGradientEnd,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: SizedBox(
            height: 6,
            child: LinearProgressIndicator(
              value: progress.clamp(0, 1).toDouble(),
              backgroundColor: const Color(0xFFE9ECEF),
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE0E6E8)),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.timer_outlined,
                color: AppColors.primaryGradientEnd,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'THỜI GIAN CÒN LẠI',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0,
                  ),
                ),
              ),
              Text(
                timeText,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: remainingSeconds <= 60
                      ? AppColors.danger
                      : AppColors.textPrimary,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatRemainingTime(int value) {
    final safeValue = value < 0 ? 0 : value;
    final minutes = (safeValue ~/ 60).toString().padLeft(2, '0');
    final seconds = (safeValue % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({required this.question, required this.index});

  final TechnicalQuestion question;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A111827),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Text(
        'Câu ${index + 1}: ${question.question}',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w800,
          height: 1.24,
          letterSpacing: 0,
        ),
      ),
    );
  }
}

class _ExplanationButton extends StatelessWidget {
  const _ExplanationButton({
    required this.isVisible,
    required this.isLoading,
    required this.hasCredits,
    required this.isQuizCompleted,
    required this.onPressed,
  });

  final bool isVisible;
  final bool isLoading;
  final bool hasCredits;
  final bool isQuizCompleted;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final canPress = !isQuizCompleted && !isVisible && !isLoading && hasCredits;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton.icon(
        onPressed: canPress ? onPressed : null,
        icon: isLoading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.psychology_alt_outlined, size: 22),
        label: Text(
          isVisible
              ? 'Đã hiển thị giải thích'
              : isQuizCompleted
              ? 'Bài làm đã hoàn thành'
              : hasCredits
              ? 'Giải thích bằng AI'
              : 'Hết lượt giải thích',
        ),
        style: FilledButton.styleFrom(
          disabledBackgroundColor: const Color(0xFFE1E5E8),
          disabledForegroundColor: AppColors.textMuted,
          textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}

class _ExplanationCard extends StatelessWidget {
  const _ExplanationCard({required this.explanation});

  final String explanation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE8FAF8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary),
      ),
      child: Text(
        explanation,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppColors.textSecondary,
          height: 1.45,
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
        ),
      ),
    );
  }
}

class _AnswerOption extends StatelessWidget {
  const _AnswerOption({
    required this.letter,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  final String letter;
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          constraints: const BoxConstraints(minHeight: 68),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 1.6,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : const Color(0xFFF0F3F4),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    letter,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: isSelected
                          ? AppColors.surface
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                    height: 1.35,
                    letterSpacing: 0,
                  ),
                ),
              ),
              if (isSelected) ...[
                const SizedBox(width: 12),
                const Icon(
                  Icons.check_circle_outline,
                  color: AppColors.primaryGradientEnd,
                  size: 22,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ConceptFocusCard extends StatelessWidget {
  const _ConceptFocusCard({required this.course});

  final TechnicalCourse course;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF3E9DF),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'TRỌNG TÂM KIẾN THỨC',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: const Color(0xFF9A4E1C),
                fontWeight: FontWeight.w800,
                letterSpacing: 1.8,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            technicalCategoryTitle(course.category),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
              height: 1.25,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            course.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
              height: 1.45,
              letterSpacing: 0,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuizStateMessage extends StatelessWidget {
  const _QuizStateMessage({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.primaryGradientEnd, size: 44),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
                height: 1.45,
                letterSpacing: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExitQuizDialog extends StatelessWidget {
  const _ExitQuizDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: const BoxDecoration(
                color: Color(0xFFFFECEC),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.warning_amber_rounded,
                color: AppColors.danger,
                size: 26,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Thoát bài kiểm tra?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tiến độ của bạn sẽ bị xóa hoàn toàn nếu bạn thoát bây giờ.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                height: 1.35,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(42),
                      foregroundColor: AppColors.textSecondary,
                    ),
                    child: const Text('Hủy'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(42),
                      backgroundColor: AppColors.danger,
                      foregroundColor: AppColors.surface,
                    ),
                    child: const Text('Thoát'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
