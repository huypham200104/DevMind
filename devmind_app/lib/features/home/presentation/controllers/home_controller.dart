import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../domain/entities/daily_check_in_summary.dart';
import '../../domain/entities/home_user_profile.dart';
import '../../domain/repositories/home_profile_repository.dart';

class HomeController extends ChangeNotifier {
  HomeController(this._profileRepository);

  final HomeProfileRepository _profileRepository;

  StreamSubscription<HomeUserProfile?>? _profileSubscription;
  StreamSubscription<DailyCheckInSummary>? _dailyCheckInSubscription;
  String? _activeUid;
  HomeUserProfile? _profile;
  DailyCheckInSummary _dailyCheckIn = DailyCheckInSummary.empty();
  bool _isLoading = false;
  bool _isLoadingDailyCheckIn = false;
  bool _isClaimingDailyCheckIn = false;
  String? _errorMessage;
  String? _dailyCheckInErrorMessage;

  HomeUserProfile? get profile => _profile;
  DailyCheckInSummary get dailyCheckIn => _dailyCheckIn;
  bool get isLoading => _isLoading;
  bool get isLoadingDailyCheckIn => _isLoadingDailyCheckIn;
  bool get isClaimingDailyCheckIn => _isClaimingDailyCheckIn;
  String? get errorMessage => _errorMessage;
  String? get dailyCheckInErrorMessage => _dailyCheckInErrorMessage;

  void watchUser({
    required String uid,
    required String? displayName,
    required String? email,
    required String? photoUrl,
  }) {
    if (_activeUid == uid && _errorMessage == null && _dailyCheckInErrorMessage == null) {
      return;
    }

    _activeUid = uid;
    _profileSubscription?.cancel();
    _dailyCheckInSubscription?.cancel();

    final fallbackProfile = HomeUserProfile.fallback(
      uid: uid,
      displayName: displayName,
      email: email,
      photoUrl: photoUrl,
    );

    _profile = fallbackProfile;
    _dailyCheckIn = DailyCheckInSummary.empty();
    _isLoading = true;
    _isLoadingDailyCheckIn = true;
    _errorMessage = null;
    _dailyCheckInErrorMessage = null;
    notifyListeners();

    _profileSubscription = _profileRepository
        .watchProfile(uid)
        .listen(
          (profile) {
            _profile = (profile ?? fallbackProfile).mergeFallback(
              fallbackProfile,
            );
            _isLoading = false;
            _errorMessage = null;
            notifyListeners();
          },
          onError: (_) {
            _profile = fallbackProfile;
            _isLoading = false;
            _errorMessage = 'Không thể tải hồ sơ người dùng từ Firestore.';
            notifyListeners();
          },
        );

    _dailyCheckInSubscription = _profileRepository
        .watchDailyCheckIn(uid)
        .listen(
          (summary) {
            _dailyCheckIn = summary;
            _isLoadingDailyCheckIn = false;
            _dailyCheckInErrorMessage = null;
            notifyListeners();
          },
          onError: (_) {
            _dailyCheckIn = DailyCheckInSummary.empty();
            _isLoadingDailyCheckIn = false;
            _dailyCheckInErrorMessage =
                'Không thể tải dữ liệu điểm danh từ Firestore.';
            notifyListeners();
          },
        );
  }

  Future<bool> claimDailyCheckIn() async {
    final uid = _activeUid;
    if (uid == null || _isClaimingDailyCheckIn) {
      return false;
    }

    _isClaimingDailyCheckIn = true;
    _dailyCheckInErrorMessage = null;
    notifyListeners();

    try {
      return await _profileRepository.claimDailyCheckIn(uid);
    } catch (_) {
      _dailyCheckInErrorMessage = 'Không thể điểm danh. Vui lòng thử lại.';
      return false;
    } finally {
      _isClaimingDailyCheckIn = false;
      notifyListeners();
    }
  }

  void clear() {
    _activeUid = null;
    _profile = null;
    _dailyCheckIn = DailyCheckInSummary.empty();
    _errorMessage = null;
    _dailyCheckInErrorMessage = null;
    _isLoading = false;
    _isLoadingDailyCheckIn = false;
    _isClaimingDailyCheckIn = false;
    _profileSubscription?.cancel();
    _profileSubscription = null;
    _dailyCheckInSubscription?.cancel();
    _dailyCheckInSubscription = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _profileSubscription?.cancel();
    _dailyCheckInSubscription?.cancel();
    super.dispose();
  }
}
