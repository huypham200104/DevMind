import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'exceptions.dart';
import 'failures.dart';

class ErrorHandler {
  const ErrorHandler._();

  static Failure handle(Object error, [StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint('Error caught by ErrorHandler: $error');
      if (stackTrace != null) {
        debugPrint(stackTrace.toString());
      }
    }

    if (error is Failure) {
      return error;
    }

    if (error is FirebaseAuthException) {
      return _handleFirebaseAuthException(error);
    }

    if (error is GoogleSignInException) {
      return _handleGoogleSignInException(error);
    }

    if (error is FirebaseException) {
      return ServerFailure(
        error.message ?? 'Đã có lỗi từ cơ sở dữ liệu. Vui lòng thử lại.',
      );
    }

    if (error is SocketException || error is NetworkException) {
      return const NetworkFailure();
    }

    if (error is ServerException) {
      return ServerFailure(error.message ?? const ServerFailure().message);
    }

    if (error is AuthException) {
      return AuthFailure(error.message ?? const AuthFailure().message);
    }

    return const UnknownFailure();
  }

  static Failure _handleFirebaseAuthException(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-email':
        return const AuthFailure('Địa chỉ email không hợp lệ.');
      case 'user-disabled':
        return const AuthFailure('Tài khoản này đã bị vô hiệu hóa.');
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return const AuthFailure('Địa chỉ email hoặc mật khẩu không đúng.');
      case 'email-already-in-use':
        return const AuthFailure('Địa chỉ email này đã được dùng để đăng ký.');
      case 'weak-password':
        return const AuthFailure('Mật khẩu cần ít nhất 6 ký tự.');
      case 'network-request-failed':
        return const NetworkFailure('Không thể kết nối mạng. Kiểm tra Internet rồi thử lại.');
      case 'requires-recent-login':
        return const AuthFailure('Vui lòng đăng nhập lại để thực hiện thao tác này.');
      default:
        return const AuthFailure('Không thể xác thực tài khoản. Vui lòng thử lại.');
    }
  }

  static Failure _handleGoogleSignInException(GoogleSignInException error) {
    switch (error.code) {
      case GoogleSignInExceptionCode.canceled:
        return const AuthFailure('Đã hủy đăng nhập Google.');
      case GoogleSignInExceptionCode.clientConfigurationError:
      case GoogleSignInExceptionCode.providerConfigurationError:
        return const AuthFailure('Cấu hình Google Sign-In chưa đúng. Hãy kiểm tra lại.');
      case GoogleSignInExceptionCode.uiUnavailable:
        return const AuthFailure('Không thể mở giao diện chọn tài khoản Google trên thiết bị này.');
      case GoogleSignInExceptionCode.interrupted:
        return const AuthFailure('Đăng nhập Google bị gián đoạn. Vui lòng thử lại.');
      default:
        return const AuthFailure('Không thể đăng nhập bằng Google. Vui lòng thử lại.');
    }
  }
}
