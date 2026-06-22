import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../domain/entities/technical_course.dart';
import '../../domain/entities/technical_question.dart';
import '../../domain/repositories/technical_course_repository.dart';

class TechnicalCourseListController extends ChangeNotifier {
  TechnicalCourseListController(this._repository);

  final TechnicalCourseRepository _repository;

  StreamSubscription<List<TechnicalCourse>>? _allCoursesSubscription;
  StreamSubscription<List<TechnicalCourse>>? _myCoursesSubscription;

  List<TechnicalCourse> _allCourses = const [];
  List<TechnicalCourse> _myCourses = const [];

  bool _isLoadingAllCourses = false;
  bool _isLoadingMyCourses = false;

  String? _allCoursesErrorMessage;
  String? _myCoursesErrorMessage;

  String? _activeUid;

  List<TechnicalCourse> get allCourses => _allCourses;
  List<TechnicalCourse> get myCourses => _myCourses;

  bool get isLoadingAllCourses => _isLoadingAllCourses;
  bool get isLoadingMyCourses => _isLoadingMyCourses;

  String? get allCoursesErrorMessage => _allCoursesErrorMessage;
  String? get myCoursesErrorMessage => _myCoursesErrorMessage;

  void watchAllCourses() {
    if (_allCoursesSubscription != null && _allCoursesErrorMessage == null) {
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

    if (_activeUid == uid &&
        _myCoursesSubscription != null &&
        _myCoursesErrorMessage == null) {
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

  Future<bool> createCustomCourse(
    String uid,
    String title,
    List<String> questionIds,
  ) async {
    try {
      await _repository.createCustomCourse(uid, title, questionIds);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> removeQuestionFromCustomCourse(
    String courseId,
    String questionId,
  ) async {
    try {
      await _repository.removeQuestionFromCustomCourse(courseId, questionId);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<List<TechnicalQuestion>> loadQuestionsForCourse(
    TechnicalCourse course,
  ) {
    return _repository.loadQuestionsForCourse(course);
  }

  @override
  void dispose() {
    _allCoursesSubscription?.cancel();
    _myCoursesSubscription?.cancel();
    super.dispose();
  }
}
