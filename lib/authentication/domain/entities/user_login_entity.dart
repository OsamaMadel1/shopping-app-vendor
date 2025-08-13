class UserLoginEntity {
  final String email;
  final String password;
  final String? deviceToken;

  const UserLoginEntity({
    required this.email,
    required this.password,
    this.deviceToken,
  });
}
