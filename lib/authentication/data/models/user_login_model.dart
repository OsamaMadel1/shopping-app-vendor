import 'package:app_vendor/authentication/domain/entities/user_login_entity.dart';

class UserLoginModel {
  final String email;
  final String password;

  UserLoginModel({required this.email, required this.password});

  factory UserLoginModel.fromEntity(UserLoginEntity entity) {
    return UserLoginModel(email: entity.email, password: entity.password);
  }

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}
