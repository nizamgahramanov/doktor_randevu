class LoginEntity {
  final String token;
  final String company;
  final String login;
  final String refreshToken;
  final String domain;

  LoginEntity({
    required this.token,
    required this.company,
    required this.login,
    required this.refreshToken,
    required this.domain,
  });
}