import 'package:app_vendor/offfers/domain/entity/off_entity.dart';

abstract class OffRepository {
  Future<void> addOff(OffEntity off);
  Future<void> updateOff(OffEntity off);
  Future<void> deleteOff(String offId);
  Future<OffEntity> getOffById(String offId);
  Future<List<OffEntity>> getOffsByShop(String shopId);
}
