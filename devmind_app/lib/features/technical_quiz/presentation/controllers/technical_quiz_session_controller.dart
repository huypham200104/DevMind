import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../domain/entities/technical_course.dart';
import '../../domain/entities/technical_question.dart';
import '../../domain/repositories/technical_course_repository.dart';
import '../../../ranking/domain/repositories/ranking_repository.dart';
import '../models/technical_quiz_result_summary.dart';
import 'technical_quiz_credits_controller.dart';

class TechnicalQuizSessionController extends ChangeNotifier {
  TechnicalQuizSessionController(
    this._repository,
    this._rankingRepository,
    this._creditsController,
  );

  static const int _bonusQuizMinutes = 5;

  final TechnicalCourseRepository _repository;
  final RankingRepository _rankingRepository;
  final TechnicalQuizCreditsController _creditsController;

  Timer? _quizTimer;

  List<TechnicalQuestion> _questions = const [];
  List<int?> _answerIndexes = const [];
  final Set<String> _shownExplanationQuestionIds = {};

  bool _isLoadingQuestions = false;
  String? _questionsErrorMessage;

  String? _quizUid;
  TechnicalCourse? _activeQuizCourse;

  int _currentQuestionIndex = 0;
  int? _selectedAnswerIndex;

  int _totalSeconds = 0;
  final ValueNotifier<int> _remainingSecondsNotifier = ValueNotifier<int>(0);

  bool _isQuizCompleted = false;
  bool _isQuizExpired = false;
  bool _isRecordingRankingScore = false;

  List<TechnicalQuestion> get questions => _questions;
  List<int?> get answerIndexes => List.unmodifiable(_answerIndexes);
  bool get isLoadingQuestions => _isLoadingQuestions;
  String? get questionsErrorMessage => _questionsErrorMessage;
  TechnicalCourse? get activeQuizCourse => _activeQuizCourse;

  int get currentQuestionIndex => _currentQuestionIndex;
  int? get selectedAnswerIndex => _selectedAnswerIndex;

  int get totalSeconds => _totalSeconds;
  ValueNotifier<int> get remainingSecondsNotifier => _remainingSecondsNotifier;
  int get remainingSeconds => _remainingSecondsNotifier.value;
  int get elapsedSeconds => (_totalSeconds - _remainingSecondsNotifier.value)
      .clamp(0, _totalSeconds)
      .toInt();

  bool get isQuizCompleted => _isQuizCompleted;
  bool get isQuizExpired => _isQuizExpired;

  TechnicalQuestion? get currentQuestion {
    if (_questions.isEmpty || _currentQuestionIndex >= _questions.length) {
      return null;
    }
    return _questions[_currentQuestionIndex];
  }

  int get totalQuestions => _questions.length;

  int get correctAnswerCount {
    var count = 0;
    for (var index = 0; index < _questions.length; index++) {
      if (index < _answerIndexes.length &&
          _answerIndexes[index] == _questions[index].correctAnswerIndex) {
        count += 1;
      }
    }
    return count;
  }

  List<TechnicalQuizAnswerResult> get answerResults {
    return [
      for (var index = 0; index < _questions.length; index++)
        TechnicalQuizAnswerResult(
          questionNumber: index + 1,
          question: _questions[index],
          selectedAnswerIndex: index < _answerIndexes.length
              ? _answerIndexes[index]
              : null,
        ),
    ];
  }

  TechnicalQuizResultSummary? get resultSummary {
    if (_activeQuizCourse == null) return null;
    return TechnicalQuizResultSummary(
      course: _activeQuizCourse!,
      correctAnswers: correctAnswerCount,
      totalQuestions: totalQuestions,
      elapsedSeconds: elapsedSeconds,
      isExpired: _isQuizExpired,
      answerResults: answerResults,
    );
  }

  double get quizProgress {
    if (_questions.isEmpty) {
      return 0;
    }
    return (_currentQuestionIndex + 1) / _questions.length;
  }

  bool get isCurrentExplanationVisible {
    final question = currentQuestion;
    if (question == null) {
      return false;
    }
    return _shownExplanationQuestionIds.contains(question.id);
  }

  Future<void> startQuiz({
    required TechnicalCourse course,
    required String? uid,
  }) async {
    _quizTimer?.cancel();
    _activeQuizCourse = course;
    _quizUid = uid;

    _questions = const [];
    _answerIndexes = const [];
    _shownExplanationQuestionIds.clear();

    _currentQuestionIndex = 0;
    _selectedAnswerIndex = null;

    _totalSeconds = _quizDurationSeconds(course);
    _remainingSecondsNotifier.value = _totalSeconds;

    _isQuizCompleted = false;
    _isQuizExpired = false;

    _isLoadingQuestions = true;
    _questionsErrorMessage = null;
    notifyListeners();

    try {
      final questions = await _repository.loadQuestionsForCourse(course);
      if (_activeQuizCourse?.id != course.id || _quizUid != uid) {
        return;
      }

      _questions = questions;
      _answerIndexes = List<int?>.filled(questions.length, null);
      _isLoadingQuestions = false;
      _questionsErrorMessage = questions.isEmpty
          ? 'Khóa học này chưa có câu hỏi.'
          : null;

      if (questions.isNotEmpty) {
        _startQuizTimer();
      }
      notifyListeners();
    } catch (_) {
      if (_activeQuizCourse?.id != course.id || _quizUid != uid) {
        return;
      }

      _quizTimer?.cancel();
      _questions = const [];
      _isLoadingQuestions = false;
      _questionsErrorMessage = 'Không thể tải câu hỏi từ Firestore.';
      notifyListeners();
    }
  }

  void selectAnswer(int index) {
    if (_isQuizCompleted) return;
    if (_selectedAnswerIndex == index) return;

    _selectedAnswerIndex = index;
    notifyListeners();
  }

  bool submitCurrentAnswer() {
    if (_isQuizCompleted ||
        _selectedAnswerIndex == null ||
        _questions.isEmpty) {
      return false;
    }

    _recordCurrentAnswer();

    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex += 1;
      _selectedAnswerIndex = null;
      notifyListeners();
      return true;
    }

    _completeQuiz(expired: false);
    return true;
  }

  Future<bool> revealCurrentExplanation() async {
    final question = currentQuestion;
    if (question == null || _isQuizCompleted) return false;

    if (_shownExplanationQuestionIds.contains(question.id)) {
      return true;
    }

    final consumed = await _creditsController.consumeExplainCredit();
    if (consumed) {
      _shownExplanationQuestionIds.add(question.id);
      notifyListeners();
    }
    return consumed;
  }

  void abandonQuiz() {
    _quizTimer?.cancel();
    _quizTimer = null;
    _isQuizCompleted = true; // Mark completed so timer stops interacting
    notifyListeners();
  }

  int _quizDurationSeconds(TechnicalCourse course) {
    final minutes = course.questionCount + _bonusQuizMinutes;
    return minutes * 60;
  }

  void _startQuizTimer() {
    _quizTimer?.cancel();
    if (_remainingSecondsNotifier.value <= 0 || _isQuizCompleted) {
      return;
    }

    _quizTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isQuizCompleted) {
        timer.cancel();
        return;
      }

      if (_remainingSecondsNotifier.value <= 1) {
        _remainingSecondsNotifier.value = 0;
        timer.cancel();
        _recordCurrentAnswer();
        _completeQuiz(expired: true);
        return;
      }

      _remainingSecondsNotifier.value -= 1;
    });
  }

  void _completeQuiz({required bool expired}) {
    if (_isQuizCompleted) return;

    _quizTimer?.cancel();
    _quizTimer = null;
    _isQuizCompleted = true;
    _isQuizExpired = expired;
    notifyListeners();

    unawaited(_recordRankingScore());
  }

  void _recordCurrentAnswer() {
    if (_currentQuestionIndex < 0 ||
        _currentQuestionIndex >= _answerIndexes.length) {
      return;
    }
    _answerIndexes[_currentQuestionIndex] = _selectedAnswerIndex;
  }

  Future<void> _recordRankingScore() async {
    final uid = _quizUid;
    final course = _activeQuizCourse;
    if (uid == null ||
        course == null ||
        _questions.isEmpty ||
        _isRecordingRankingScore) {
      return;
    }

    _isRecordingRankingScore = true;
    try {
      await _rankingRepository.recordTechnicalQuizScore(
        uid: uid,
        courseId: course.id,
        courseTitle: course.title,
        correctAnswers: correctAnswerCount,
        totalQuestions: totalQuestions,
      );
    } finally {
      _isRecordingRankingScore = false;
    }
  }

  @override
  void dispose() {
    _quizTimer?.cancel();
    _remainingSecondsNotifier.dispose();
    super.dispose();
  }
}
