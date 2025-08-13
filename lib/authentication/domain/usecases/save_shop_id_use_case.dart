import 'package:app_vendor/authentication/domain/repositories/auth_repositroy.dart';

class SaveshopIdUseCase {
  final AuthRepository repository;

  SaveshopIdUseCase(this.repository);

  Future<void> call(String shopId) {
    return repository.saveshopId(shopId);
  }
}
