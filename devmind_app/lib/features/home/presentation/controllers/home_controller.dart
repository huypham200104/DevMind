import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../domain/entities/home_user_profile.dart';
import '../../domain/repositories/home_profile_repository.dart';

class HomeController extends ChangeNotifier {
  HomeController(this._profileRepository);

  final HomeProfileRepository _profileRepository;

  StreamSubscription<HomeUserProfile?>? _profileSubscription;
  String? _activeUid;
  HomeUserProfile? _profile;
  bool _isLoading = false;
  String? _errorMessage;

  HomeUserProfile? get profile => _profile;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void watchUser({
    required String uid,
    required String? displayName,
    required String? email,
    required String? photoUrl,
  }) {
    if (_activeUid == uid) {
      return;
    }

    _activeUid = uid;
    _profileSubscription?.cancel();

    final fallbackProfile = HomeUserProfile.fallback(
      uid: uid,
      displayName: displayName,
      email: email,
      photoUrl: photoUrl,
    );

    _profile = fallbackProfile;
    _isLoading = true;
    _errorMessage = null;
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
  }

  void clear() {
    _activeUid = null;
    _profile = null;
    _errorMessage = null;
    _isLoading = false;
    _profileSubscription?.cancel();
    _profileSubscription = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _profileSubscription?.cancel();
    super.dispose();
  }
}
