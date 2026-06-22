import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../../core/errors/error_handler.dart';
import '../../domain/entities/cv_upload.dart';
import '../../domain/repositories/cv_upload_repository.dart';

class CvScannerController extends ChangeNotifier {
  CvScannerController(this._repository);

  final CvUploadRepository _repository;

  StreamSubscription<List<CvUpload>>? _uploadsSubscription;
  List<CvUpload> _recentUploads = const [];
  CvFileSelection? _selectedFile;
  CvUpload? _activeResult;
  bool _isLoading = false;
  bool _isPickingFile = false;
  bool _isScanning = false;
  String? _errorMessage;
  String? _actionErrorMessage;
  String? _activeUid;

  List<CvUpload> get recentUploads => _recentUploads;
  CvFileSelection? get selectedFile => _selectedFile;
  CvUpload? get activeResult => _activeResult;
  bool get isLoading => _isLoading;
  bool get isPickingFile => _isPickingFile;
  bool get isScanning => _isScanning;
  String? get errorMessage => _errorMessage;
  String? get actionErrorMessage => _actionErrorMessage;
  bool get canScan => !_isPickingFile && !_isScanning;

  void watchUploads(String? uid) {
    if (uid == null) {
      _activeUid = null;
      _recentUploads = const [];
      _selectedFile = null;
      _activeResult = null;
      _isLoading = false;
      _isPickingFile = false;
      _isScanning = false;
      _errorMessage = null;
      _actionErrorMessage = null;
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
          onError: (error) {
            _recentUploads = const [];
            _isLoading = false;
            _errorMessage = ErrorHandler.handle(error).message;
            notifyListeners();
          },
        );
  }

  Future<bool> pickPdf() async {
    if (_isPickingFile || _isScanning) {
      return false;
    }

    _isPickingFile = true;
    _actionErrorMessage = null;
    notifyListeners();

    try {
      final file = await _repository.pickPdf();
      if (file == null) {
        return false;
      }

      _selectedFile = file;
      _activeResult = null;
      return true;
    } catch (error, stackTrace) {
      if (error is CvScannerException && error.message.trim().isNotEmpty) {
        _actionErrorMessage = error.message.trim();
      } else {
        _actionErrorMessage = ErrorHandler.handle(error, stackTrace).message;
      }
      return false;
    } finally {
      _isPickingFile = false;
      notifyListeners();
    }
  }

  Future<bool> scanSelectedPdf(String jobTitle) async {
    final normalizedJobTitle = jobTitle.trim();
    if (normalizedJobTitle.isEmpty) {
      _actionErrorMessage = 'Vui lòng nhập vị trí ứng tuyển.';
      notifyListeners();
      return false;
    }

    final file = _selectedFile;
    if (file == null) {
      _actionErrorMessage = 'Vui lòng chọn file PDF trước khi scan.';
      notifyListeners();
      return false;
    }

    if (_isScanning || _isPickingFile) {
      return false;
    }

    _isScanning = true;
    _actionErrorMessage = null;
    notifyListeners();

    try {
      final result = await _repository.scanPdf(
        file: file,
        jobTitle: normalizedJobTitle,
      );
      _selectedFile = null;
      _activeResult = result;
      _recentUploads = _mergeResult(result);
      return true;
    } catch (error, stackTrace) {
      if (error is CvScannerException && error.message.trim().isNotEmpty) {
        _actionErrorMessage = error.message.trim();
      } else {
        _actionErrorMessage = ErrorHandler.handle(error, stackTrace).message;
      }
      return false;
    } finally {
      _isScanning = false;
      notifyListeners();
    }
  }

  void showResult(CvUpload result) {
    _activeResult = result;
    _actionErrorMessage = null;
    notifyListeners();
  }

  void clearResult() {
    if (_activeResult == null) {
      return;
    }

    _activeResult = null;
    notifyListeners();
  }

  List<CvUpload> _mergeResult(CvUpload result) {
    if (result.id.isEmpty) {
      return [result, ..._recentUploads];
    }

    return [
      result,
      ..._recentUploads.where((upload) => upload.id != result.id),
    ];
  }


  @override
  void dispose() {
    _uploadsSubscription?.cancel();
    super.dispose();
  }
}
