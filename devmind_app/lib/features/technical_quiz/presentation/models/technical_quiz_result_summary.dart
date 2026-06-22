import '../../domain/entities/technical_course.dart';
import '../../domain/entities/technical_question.dart';

class TechnicalQuizAnswerResult {
  const TechnicalQuizAnswerResult({
    required this.questionNumber,
    required this.question,
    required this.selectedAnswerIndex,
  });

  final int questionNumber;
  final TechnicalQuestion question;
  final int? selectedAnswerIndex;

  bool get isCorrect => selectedAnswerIndex == question.correctAnswerIndex;
}

class TechnicalQuizResultSummary {
  const TechnicalQuizResultSummary({
    required this.course,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.elapsedSeconds,
    required this.isExpired,
    required this.answerResults,
  });

  final TechnicalCourse course;
  final int correctAnswers;
  final int totalQuestions;
  final int elapsedSeconds;
  final bool isExpired;
  final List<TechnicalQuizAnswerResult> answerResults;

  int get incorrectAnswerCount => totalQuestions - correctAnswers;

  int get accuracyPercent {
    if (totalQuestions == 0) return 0;
    return ((correctAnswers / totalQuestions) * 100).round();
  }
}
