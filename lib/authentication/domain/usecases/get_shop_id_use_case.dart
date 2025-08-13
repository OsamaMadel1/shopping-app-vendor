import 'package:app_vendor/authentication/domain/repositories/auth_repositroy.dart';

class GetshopIdUseCase {
  final AuthRepository repository;

  GetshopIdUseCase(this.repository);

  Future<String?> call() {
    return repository.getshopId();
  }
}
