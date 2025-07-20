import 'package:app_vendor/authentication/domain/entities/login_response_entity.dart';
import 'package:app_vendor/authentication/domain/entities/user_login_entity.dart';
import 'package:app_vendor/authentication/domain/repositories/auth_repositroy.dart';

class LoginUserUseCase {
  final AuthRepository repository;

  LoginUserUseCase(this.repository);

  Future<LoginResponseEntity> call(UserLoginEntity user) {
    return repository.loginUser(user);
  }
}
