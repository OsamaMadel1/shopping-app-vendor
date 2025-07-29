import 'package:app_vendor/offfers/domain/entity/off_entity.dart';
import 'package:app_vendor/offfers/domain/repositories/off_repositories.dart';

/// A class that aggregates all offer-related use cases.
class OffUseCases {
  final OffRepository repository;
  OffUseCases(this.repository);

  Future<void> addOff(OffEntity off) {
    return repository.addOff(off);
  }

  Future<void> updateOff(OffEntity off) {
    return repository.updateOff(off);
  }

  Future<void> deleteOff(String offId) {
    return repository.deleteOff(offId);
  }

  Future<OffEntity> getOffById(String offId) {
    return repository.getOffById(offId);
  }

  Future<List<OffEntity>> getOffsByShop(String shopId) {
    return repository.getOffsByShop(shopId);
  }
}
