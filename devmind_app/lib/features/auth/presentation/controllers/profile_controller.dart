import 'package:flutter/foundation.dart';

import '../../domain/entities/profile_data.dart';
import '../../domain/repositories/profile_repository.dart';

class ProfileController extends ChangeNotifier {
  ProfileController(this._profileRepository);

  final ProfileRepository _profileRepository;

  String? _activeUid;
  ProfileData? _profileData;
  bool _isLoading = false;
  String? _errorMessage;

  ProfileData? get profileData => _profileData;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadProfile(String uid) async {
    if (_activeUid == uid && (_profileData != null || _isLoading)) {
      return;
    }

    _activeUid = uid;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _profileData = await _profileRepository.getProfile(uid);
    } catch (_) {
      _errorMessage = 'Không thể tải dữ liệu hồ sơ từ Firebase.';
      _profileData = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    _activeUid = null;
    _profileData = null;
    _isLoading = false;
    _errorMessage = null;
    notifyListeners();
  }
}
