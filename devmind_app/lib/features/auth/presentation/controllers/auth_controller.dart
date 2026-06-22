import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/errors/error_handler.dart';
import '../../data/datasources/auth_remote_data_source.dart';

class AuthController extends ChangeNotifier {
  AuthController(this._authRemoteDataSource) {
    _currentUser = _authRemoteDataSource.currentUser;
    _authStateSubscription = _authRemoteDataSource.watchAuthState().listen((
      user,
    ) {
      _currentUser = user;
      notifyListeners();
    });
  }

  final AuthRemoteDataSource _authRemoteDataSource;

  StreamSubscription<User?>? _authStateSubscription;
  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  Future<bool> signIn({required String email, required String password}) async {
    return _runAuthAction(
      () => _authRemoteDataSource.signInWithEmail(
        email: email,
        password: password,
      ),
    );
  }

  Future<bool> signUp({
    required String displayName,
    required String email,
    required String password,
  }) async {
    return _runAuthAction(
      () => _authRemoteDataSource.signUpWithEmail(
        displayName: displayName,
        email: email,
        password: password,
      ),
    );
  }

  Future<bool> signInWithGoogle() async {
    return _runAuthAction(() => _authRemoteDataSource.signInWithGoogle());
  }

  Future<bool> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    return _runAuthAction(
      () => _authRemoteDataSource.updatePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      ),
    );
  }

  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _authRemoteDataSource.signOut();
      _errorMessage = null;
    } catch (error, stackTrace) {
      _errorMessage = ErrorHandler.handle(error, stackTrace).message;
    } finally {
      _setLoading(false);
    }
  }

  void clearError() {
    if (_errorMessage == null) {
      return;
    }
    _errorMessage = null;
    notifyListeners();
  }

  Future<bool> _runAuthAction(Future<void> Function() action) async {
    _setLoading(true);
    try {
      await action();
      _errorMessage = null;
      return true;
    } catch (error, stackTrace) {
      _errorMessage = ErrorHandler.handle(error, stackTrace).message;
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _authStateSubscription?.cancel();
    super.dispose();
  }
}
