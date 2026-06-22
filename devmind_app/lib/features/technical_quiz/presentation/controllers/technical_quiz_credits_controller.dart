import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../domain/repositories/technical_course_repository.dart';

class TechnicalQuizCreditsController extends ChangeNotifier {
  TechnicalQuizCreditsController(this._repository);

  final TechnicalCourseRepository _repository;
  StreamSubscription<int>? _explainCreditsSubscription;

  int _explainCredits = 0;
  bool _isConsumingExplainCredit = false;
  String? _quizUid;

  int get explainCredits => _explainCredits;
  bool get isConsumingExplainCredit => _isConsumingExplainCredit;

  void watchExplainCredits(String? uid) {
    if (uid == null) {
      _quizUid = null;
      _explainCredits = 0;
      _explainCreditsSubscription?.cancel();
      _explainCreditsSubscription = null;
      notifyListeners();
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

  Future<bool> consumeExplainCredit() async {
    final uid = _quizUid;
    if (uid == null || _isConsumingExplainCredit || _explainCredits <= 0) {
      return false;
    }

    _isConsumingExplainCredit = true;
    notifyListeners();

    try {
      final consumed = await _repository.consumeExplainCredit(uid);
      if (consumed && _explainCredits > 0) {
        _explainCredits -= 1;
      }
      return consumed;
    } catch (_) {
      return false;
    } finally {
      _isConsumingExplainCredit = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _explainCreditsSubscription?.cancel();
    super.dispose();
  }
}
