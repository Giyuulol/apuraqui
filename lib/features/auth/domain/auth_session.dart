class AuthSession {
  const AuthSession({
    required this.userId,
    required this.login,
    required this.authenticatedAt,
  });

  final String userId;
  final String login;
  final DateTime authenticatedAt;
}
