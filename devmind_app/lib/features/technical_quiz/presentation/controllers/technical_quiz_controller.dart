import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../domain/entities/technical_course.dart';
import '../../domain/entities/technical_question.dart';
import '../../domain/repositories/technical_course_repository.dart';

class TechnicalQuizController extends ChangeNotifier {
  TechnicalQuizController(this._repository);

  static const int _bonusQuizMinutes = 5;

  final TechnicalCourseRepository _repository;

  StreamSubscription<List<TechnicalCourse>>? _allCoursesSubscription;
  StreamSubscription<List<TechnicalCourse>>? _myCoursesSubscription;
  StreamSubscription<int>? _explainCreditsSubscription;
  Timer? _quizTimer;

  List<TechnicalCourse> _allCourses = const [];
  List<TechnicalCourse> _myCourses = const [];
  List<TechnicalQuestion> _questions = const [];
  List<int?> _answerIndexes = const [];
  final Set<String> _shownExplanationQuestionIds = {};
  bool _isLoadingAllCourses = false;
  bool _isLoadingMyCourses = false;
  bool _isLoadingQuestions = false;
  bool _isConsumingExplainCredit = false;
  String? _allCoursesErrorMessage;
  String? _myCoursesErrorMessage;
  String? _questionsErrorMessage;
  String? _activeUid;
  String? _quizUid;
  TechnicalCourse? _activeQuizCourse;
  int _currentQuestionIndex = 0;
  int? _selectedAnswerIndex;
  int _explainCredits = 0;
  int _totalSeconds = 0;
  int _remainingSeconds = 0;
  bool _isQuizCompleted = false;
  bool _isQuizExpired = false;

  List<TechnicalCourse> get allCourses => _allCourses;
  List<TechnicalCourse> get myCourses => _myCourses;
  List<TechnicalQuestion> get questions => _questions;
  List<int?> get answerIndexes => List.unmodifiable(_answerIndexes);
  bool get isLoadingAllCourses => _isLoadingAllCourses;
  bool get isLoadingMyCourses => _isLoadingMyCourses;
  bool get isLoadingQuestions => _isLoadingQuestions;
  bool get isConsumingExplainCredit => _isConsumingExplainCredit;
  String? get allCoursesErrorMessage => _allCoursesErrorMessage;
  String? get myCoursesErrorMessage => _myCoursesErrorMessage;
  String? get questionsErrorMessage => _questionsErrorMessage;
  TechnicalCourse? get activeQuizCourse => _activeQuizCourse;
  int get currentQuestionIndex => _currentQuestionIndex;
  int? get selectedAnswerIndex => _selectedAnswerIndex;
  int get explainCredits => _explainCredits;
  int get totalSeconds => _totalSeconds;
  int get remainingSeconds => _remainingSeconds;
  int get elapsedSeconds =>
      (_totalSeconds - _remainingSeconds).clamp(0, _totalSeconds).toInt();
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

  int get incorrectAnswerCount {
    if (_questions.isEmpty) {
      return 0;
    }

    return _questions.length - correctAnswerCount;
  }

  int get accuracyPercent {
    if (_questions.isEmpty) {
      return 0;
    }

    return ((correctAnswerCount / _questions.length) * 100).round();
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

  void watchAllCourses() {
    if (_allCoursesSubscription != null) {
      return;
    }

    _isLoadingAllCourses = true;
    _allCoursesErrorMessage = null;
    notifyListeners();

    _allCoursesSubscription = _repository.watchAllCourses().listen(
      (courses) {
        _allCourses = courses;
        _isLoadingAllCourses = false;
        _allCoursesErrorMessage = null;
        notifyListeners();
      },
      onError: (_) {
        _isLoadingAllCourses = false;
        _allCoursesErrorMessage = 'Không thể tải khóa học từ Firestore.';
        notifyListeners();
      },
    );
  }

  void watchMyCourses(String? uid) {
    if (uid == null) {
      if (_activeUid == null &&
          _myCoursesSubscription == null &&
          _myCourses.isEmpty &&
          !_isLoadingMyCourses &&
          _myCoursesErrorMessage == null) {
        return;
      }

      _activeUid = null;
      _myCourses = const [];
      _isLoadingMyCourses = false;
      _myCoursesErrorMessage = null;
      _myCoursesSubscription?.cancel();
      _myCoursesSubscription = null;
      notifyListeners();
      return;
    }

    if (_activeUid == uid && _myCoursesSubscription != null) {
      return;
    }

    _activeUid = uid;
    _myCourses = const [];
    _isLoadingMyCourses = true;
    _myCoursesErrorMessage = null;
    _myCoursesSubscription?.cancel();
    notifyListeners();

    _myCoursesSubscription = _repository
        .watchMyCourses(uid)
        .listen(
          (courses) {
            _myCourses = courses;
            _isLoadingMyCourses = false;
            _myCoursesErrorMessage = null;
            notifyListeners();
          },
          onError: (_) {
            _isLoadingMyCourses = false;
            _myCoursesErrorMessage =
                'Không thể tải khóa học của tôi từ Firestore.';
            notifyListeners();
          },
        );
  }

  Future<bool> deleteMyCourse(String courseId) async {
    try {
      await _repository.deleteMyCourse(courseId);
      _myCoursesErrorMessage = null;
      notifyListeners();
      return true;
    } catch (_) {
      _myCoursesErrorMessage = 'Không thể xóa khóa học. Vui lòng thử lại.';
      notifyListeners();
      return false;
    }
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
    _remainingSeconds = _totalSeconds;
    _isQuizCompleted = false;
    _isQuizExpired = false;
    _isLoadingQuestions = true;
    _questionsErrorMessage = null;
    notifyListeners();

    _watchExplainCredits(uid);

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
    if (_isQuizCompleted) {
      return;
    }

    if (_selectedAnswerIndex == index) {
      return;
    }

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
    final uid = _quizUid;
    if (question == null ||
        uid == null ||
        _isQuizCompleted ||
        _isConsumingExplainCredit) {
      return false;
    }

    if (_shownExplanationQuestionIds.contains(question.id)) {
      return true;
    }

    if (_explainCredits <= 0) {
      return false;
    }

    _isConsumingExplainCredit = true;
    notifyListeners();

    try {
      final consumed = await _repository.consumeExplainCredit(uid);
      if (consumed) {
        _shownExplanationQuestionIds.add(question.id);
        if (_explainCredits > 0) {
          _explainCredits -= 1;
        }
      }
      return consumed;
    } catch (_) {
      return false;
    } finally {
      _isConsumingExplainCredit = false;
      notifyListeners();
    }
  }

  void abandonQuiz() {
    _quizTimer?.cancel();
    _quizTimer = null;
  }

  void _watchExplainCredits(String? uid) {
    if (uid == null) {
      _quizUid = null;
      _explainCredits = 0;
      _explainCreditsSubscription?.cancel();
      _explainCreditsSubscription = null;
      return;
    }

    if (_quizUid == uid && _explainCreditsSubscription != null) {
      return;
    }

    _quizUid = uid;
    _explainCreditsSubscription?.cancel();
    _explainCreditsSubscription = _repository
        .watchExplainCredits(uid)
        .listen(
          (credits) {
            _explainCredits = credits;
            notifyListeners();
          },
          onError: (_) {
            _explainCredits = 0;
            notifyListeners();
          },
        );
  }

  int _quizDurationSeconds(TechnicalCourse course) {
    final minutes = course.questionCount + _bonusQuizMinutes;
    return minutes * 60;
  }

  void _startQuizTimer() {
    _quizTimer?.cancel();
    if (_remainingSeconds <= 0 || _isQuizCompleted) {
      return;
    }

    _quizTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isQuizCompleted) {
        timer.cancel();
        return;
      }

      if (_remainingSeconds <= 1) {
        _remainingSeconds = 0;
        timer.cancel();
        _recordCurrentAnswer();
        _completeQuiz(expired: true);
        return;
      }

      _remainingSeconds -= 1;
      notifyListeners();
    });
  }

  void _completeQuiz({required bool expired}) {
    if (_isQuizCompleted) {
      return;
    }

    _quizTimer?.cancel();
    _quizTimer = null;
    _isQuizCompleted = true;
    _isQuizExpired = expired;
    notifyListeners();
  }

  void _recordCurrentAnswer() {
    if (_currentQuestionIndex < 0 ||
        _currentQuestionIndex >= _answerIndexes.length) {
      return;
    }

    _answerIndexes[_currentQuestionIndex] = _selectedAnswerIndex;
  }

  @override
  void dispose() {
    _allCoursesSubscription?.cancel();
    _myCoursesSubscription?.cancel();
    _explainCreditsSubscription?.cancel();
    _quizTimer?.cancel();
    super.dispose();
  }
}

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
