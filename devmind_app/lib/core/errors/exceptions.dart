abstract class AppException implements Exception {
  const AppException([this.message]);
  final String? message;

  @override
  String toString() {
    if (message == null) return runtimeType.toString();
    return '$runtimeType: $message';
  }
}

class ServerException extends AppException {
  const ServerException([super.message]);
}

class NetworkException extends AppException {
  const NetworkException([super.message]);
}

class AuthException extends AppException {
  const AuthException([super.message]);
}
