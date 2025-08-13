import 'package:app_vendor/authentication/domain/repositories/auth_repositroy.dart';

class SaveTokenUseCase {
  final AuthRepository repository;

  SaveTokenUseCase(this.repository);

  Future<void> call(String token) {
    return repository.saveToken(token);
  }
}
