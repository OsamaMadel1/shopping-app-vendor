import 'package:app_vendor/authentication/domain/repositories/auth_repositroy.dart';

class GetUserNameUseCase {
  final AuthRepository repository;

  GetUserNameUseCase(this.repository);

  Future<String?> call() {
    return repository.getUserName();
  }
}
