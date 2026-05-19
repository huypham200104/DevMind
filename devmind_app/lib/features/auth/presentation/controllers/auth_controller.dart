import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../data/sources/auth_remote_data_source.dart';

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

  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _authRemoteDataSource.signOut();
      _errorMessage = null;
    } on FirebaseAuthException catch (error) {
      _errorMessage = _friendlyAuthError(error);
    } catch (_) {
      _errorMessage = 'Đã có lỗi xảy ra. Vui lòng thử lại.';
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
    } on FirebaseAuthException catch (error) {
      _errorMessage = _friendlyAuthError(error);
      return false;
    } catch (_) {
      _errorMessage = 'Đã có lỗi xảy ra. Vui lòng thử lại.';
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _friendlyAuthError(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-email':
        return 'Địa chỉ email không hợp lệ.';
      case 'user-disabled':
        return 'Tài khoản này đã bị vô hiệu hóa.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Địa chỉ email hoặc mật khẩu không đúng.';
      case 'email-already-in-use':
        return 'Địa chỉ email này đã được dùng để đăng ký.';
      case 'weak-password':
        return 'Mật khẩu cần ít nhất 6 ký tự.';
      case 'network-request-failed':
        return 'Không thể kết nối mạng. Kiểm tra Internet rồi thử lại.';
      default:
        return 'Không thể xác thực tài khoản. Vui lòng thử lại.';
    }
  }

  @override
  void dispose() {
    _authStateSubscription?.cancel();
    super.dispose();
  }
}
