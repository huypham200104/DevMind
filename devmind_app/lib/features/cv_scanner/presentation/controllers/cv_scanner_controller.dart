import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../domain/entities/cv_upload.dart';
import '../../domain/repositories/cv_upload_repository.dart';

class CvScannerController extends ChangeNotifier {
  CvScannerController(this._repository);

  final CvUploadRepository _repository;

  StreamSubscription<List<CvUpload>>? _uploadsSubscription;
  List<CvUpload> _recentUploads = const [];
  bool _isLoading = false;
  String? _errorMessage;
  String? _activeUid;

  List<CvUpload> get recentUploads => _recentUploads;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void watchUploads(String? uid) {
    if (uid == null) {
      _activeUid = null;
      _recentUploads = const [];
      _isLoading = false;
      _errorMessage = null;
      _uploadsSubscription?.cancel();
      _uploadsSubscription = null;
      notifyListeners();
      return;
    }

    if (_activeUid == uid && _uploadsSubscription != null) {
      return;
    }

    _activeUid = uid;
    _recentUploads = const [];
    _isLoading = true;
    _errorMessage = null;
    _uploadsSubscription?.cancel();
    notifyListeners();

    _uploadsSubscription = _repository
        .watchUserUploads(uid)
        .listen(
          (uploads) {
            _recentUploads = uploads;
            _isLoading = false;
            _errorMessage = null;
            notifyListeners();
          },
          onError: (_) {
            _recentUploads = const [];
            _isLoading = false;
            _errorMessage = 'Không thể tải danh sách CV từ Firebase.';
            notifyListeners();
          },
        );
  }

  @override
  void dispose() {
    _uploadsSubscription?.cancel();
    super.dispose();
  }
}
