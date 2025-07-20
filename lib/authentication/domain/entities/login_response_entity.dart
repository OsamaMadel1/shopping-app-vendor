class LoginResponseEntity {
  final String token;
  final String shopId;
  final String userName;

  const LoginResponseEntity({
    required this.token,
    required this.shopId,
    required this.userName,
  });
}
