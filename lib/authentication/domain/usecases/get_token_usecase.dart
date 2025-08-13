import 'package:app_vendor/authentication/domain/repositories/auth_repositroy.dart';

class GetTokenUseCase {
  final AuthRepository repository;

  GetTokenUseCase(this.repository);

  Future<String?> call() {
    return repository.getToken();
  }
}
