abstract class Failure {
  const Failure(this.message);
  final String message;
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Đã có lỗi từ máy chủ.']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = 'Không thể kết nối mạng. Hãy kiểm tra lại Internet.',
  ]);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Xác thực tài khoản thất bại.']);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Đã có lỗi xảy ra. Vui lòng thử lại sau.']);
}
