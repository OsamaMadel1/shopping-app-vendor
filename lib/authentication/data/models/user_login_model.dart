import 'package:app_vendor/authentication/domain/entities/user_login_entity.dart';

class UserLoginModel {
  final String email;
  final String password;
  final String? deviceToken;

  UserLoginModel({
    required this.email,
    required this.password,
    this.deviceToken,
  });

  factory UserLoginModel.fromEntity(UserLoginEntity entity) {
    return UserLoginModel(
      email: entity.email,
      password: entity.password,
      deviceToken: entity.deviceToken,
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    if (deviceToken != null) 'token': deviceToken,
  };
}
