import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../home/presentation/widgets/home_bottom_navigation.dart';
import '../../domain/entities/technical_course.dart';
import '../models/technical_quiz_result_summary.dart';

class TechnicalQuizResultScreen extends StatelessWidget {
  const TechnicalQuizResultScreen({
    super.key,
    required this.courseId,
    required this.isMine,
    this.resultSummary,
  });

  final String courseId;
  final bool isMine;
  final TechnicalQuizResultSummary? resultSummary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      bottomNavigationBar: const HomeBottomNavigation(),
      body: SafeArea(
        child: Column(
          children: [
            _ResultHeader(
              onBack: () => context.goNamed(AppRouteNames.technicalQuiz),
            ),
            Expanded(
              child: resultSummary == null
                  ? const _MissingResultState()
                  : _ResultContent(
                      course: resultSummary!.course,
                      results: resultSummary!.answerResults,
                      summary: resultSummary!,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultHeader extends StatelessWidget {
  const _ResultHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
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
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}

class _ResultContent extends StatelessWidget {
  const _ResultContent({
    required this.course,
    required this.summary,
    required this.results,
  });

  final TechnicalCourse course;
  final TechnicalQuizResultSummary summary;
  final List<TechnicalQuizAnswerResult> results;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(22, 18, 22, 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ResultSummary(
            course: course,
            correctAnswers: summary.correctAnswers,
            totalQuestions: summary.totalQuestions,
            elapsedSeconds: summary.elapsedSeconds,
            isExpired: summary.isExpired,
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: _ResultMetricCard(
                  icon: Icons.check_circle_outline,
                  value: summary.correctAnswers.toString(),
                  label: 'CÂU ĐÚNG',
                  tintColor: const Color(0xFFE5FAF8),
                  iconColor: AppColors.primaryGradientEnd,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ResultMetricCard(
                  icon: Icons.cancel_outlined,
                  value: summary.incorrectAnswerCount.toString(),
                  label: 'CÂU SAI',
                  tintColor: const Color(0xFFFFECEC),
                  iconColor: AppColors.danger,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ResultMetricCard(
                  icon: Icons.stacked_bar_chart_outlined,
                  value: '${summary.accuracyPercent}%',
                  label: 'CHÍNH XÁC',
                  tintColor: const Color(0xFFE5FAF8),
                  iconColor: AppColors.primaryGradientEnd,
                ),
              ),
            ],
          ),
          const SizedBox(height: 34),
          Text(
            'Xem lại câu hỏi',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 16),
          for (final result in results) ...[
            _QuestionReviewTile(result: result),
            const SizedBox(height: 12),
          ],
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 58,
            child: FilledButton.icon(
              onPressed: () => context.goNamed(
                AppRouteNames.technicalQuestion,
                pathParameters: {'courseId': course.id},
                queryParameters: {'scope': course.isMine ? 'mine' : 'all'},
                extra: course,
              ),
              icon: const Icon(Icons.refresh, size: 22),
              label: const Text('Làm lại bài này'),
              style: FilledButton.styleFrom(
                textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 58,
            child: OutlinedButton(
              onPressed: () => context.goNamed(AppRouteNames.technicalQuiz),
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

class _ResultSummary extends StatelessWidget {
  const _ResultSummary({
    required this.course,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.elapsedSeconds,
    required this.isExpired,
  });

  final TechnicalCourse course;
  final int correctAnswers;
  final int totalQuestions;
  final int elapsedSeconds;
  final bool isExpired;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 26, 20, 28),
      decoration: BoxDecoration(
        color: const Color(0xFFEFFFFD),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            isExpired ? 'Hết thời gian!' : 'Hoàn thành bài kiểm tra!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
              height: 1.15,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            isExpired
                ? 'Bài "${course.title}" đã được hoàn thành tự động.'
                : 'Bạn đã hoàn thành bài "${course.title}".',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
              height: 1.45,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Thời gian làm bài: ${_formatDuration(elapsedSeconds)}',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.primaryGradientEnd,
              fontWeight: FontWeight.w800,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 28),
          Container(
            width: 142,
            height: 142,
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 4),
            ),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$correctAnswers/$totalQuestions\n',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: AppColors.primaryGradientEnd,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0,
                          ),
                    ),
                    TextSpan(
                      text: 'ĐIỂM',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(int seconds) {
    final safeSeconds = seconds < 0 ? 0 : seconds;
    final minutes = (safeSeconds ~/ 60).toString().padLeft(2, '0');
    final remainingSeconds = (safeSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSeconds';
  }
}

class _ResultMetricCard extends StatelessWidget {
  const _ResultMetricCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.tintColor,
    required this.iconColor,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color tintColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 126),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(color: tintColor, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w900,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionReviewTile extends StatelessWidget {
  const _QuestionReviewTile({required this.result});

  final TechnicalQuizAnswerResult result;

  @override
  Widget build(BuildContext context) {
    final question = result.question;
    final selectedAnswer = _optionText(
      question.options,
      result.selectedAnswerIndex,
    );
    final correctAnswer =
        _optionText(question.options, question.correctAnswerIndex) ??
        'Không xác định';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: result.isCorrect
                  ? const Color(0xFFE5FAF8)
                  : const Color(0xFFFFECEC),
              shape: BoxShape.circle,
            ),
            child: Icon(
              result.isCorrect
                  ? Icons.check_circle_outline
                  : Icons.cancel_outlined,
              color: result.isCorrect
                  ? AppColors.primaryGradientEnd
                  : AppColors.danger,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Câu ${result.questionNumber}: ${question.question}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  result.isCorrect
                      ? 'Đúng: $correctAnswer'
                      : 'Sai: ${selectedAnswer ?? 'Chưa trả lời'}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: result.isCorrect
                        ? AppColors.textSecondary
                        : AppColors.danger,
                    fontWeight: FontWeight.w600,
                    height: 1.35,
                    letterSpacing: 0,
                  ),
                ),
                if (!result.isCorrect) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Đáp án đúng: $correctAnswer',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                      height: 1.35,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? _optionText(List<String> options, int? index) {
    if (index == null || index < 0 || index >= options.length) {
      return null;
    }

    return options[index];
  }
}

class _MissingResultState extends StatelessWidget {
  const _MissingResultState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.assignment_late_outlined,
              color: AppColors.primaryGradientEnd,
              size: 46,
            ),
            const SizedBox(height: 16),
            Text(
              'Chưa có kết quả',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Hãy hoàn thành một bài kiểm tra để xem kết quả chi tiết.',
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
