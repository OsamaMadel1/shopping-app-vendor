import 'package:app_vendor/offfers/data/models/off_model.dart';
import 'package:app_vendor/offfers/data/sources/remotes/off_remote_date_source.dart';
import 'package:app_vendor/offfers/domain/entity/off_entity.dart';
import 'package:app_vendor/offfers/domain/repositories/off_repositories.dart';

class OffRepositoryImpl implements OffRepository {
  final OffRemoteDataSource remote;

  OffRepositoryImpl(this.remote);

  @override
  Future<void> addOff(OffEntity off) {
    final model = OffModel.fromEntity(off);
    return remote.addOff(model);
  }

  @override
  Future<void> updateOff(OffEntity off) {
    final model = OffModel.fromEntity(off);
    return remote.updateOff(model);
  }

  @override
  Future<void> deleteOff(String offId) {
    return remote.deleteOff(offId);
  }

  @override
  Future<OffEntity> getOffById(String offId) async {
    final model = await remote.getOffById(offId);
    return model.toEntity();
  }

  @override
  Future<List<OffEntity>> getOffsByShop(String shopId) async {
    final models = await remote.getOffsByShop(shopId);
    return models.map((e) => e.toEntity()).toList();
  }
}
