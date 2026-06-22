class AuthException implements Exception {
  const AuthException(this.code, this.message);

  final AuthExceptionCode code;
  final String message;

  @override
  String toString() => message;
}

enum AuthExceptionCode {
  invalidPhoneNumber,
  invalidVerificationCode,
  tooManyRequests,
  timeout,
  unavailable,
  unknown,
}
