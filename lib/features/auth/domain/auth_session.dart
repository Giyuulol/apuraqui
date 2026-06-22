class AuthSession {
  const AuthSession({
    required this.userId,
    required this.loginLabel,
    required this.authProvider,
    required this.authenticatedAt,
    this.phoneNumber,
  });

  final String userId;
  final String loginLabel;
  final AuthProviderType authProvider;
  final DateTime authenticatedAt;
  final String? phoneNumber;

  // Compatibilidade temporaria: algumas features ainda usam login para
  // diferenciar o mock de candidato. O campo novo correto e loginLabel.
  String get login => loginLabel;
}

enum AuthProviderType { demo, phone }
