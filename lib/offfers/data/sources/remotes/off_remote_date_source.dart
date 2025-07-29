import 'package:app_vendor/offfers/data/models/off_model.dart';

abstract class OffRemoteDataSource {
  Future<void> addOff(OffModel off);
  Future<void> updateOff(OffModel off);
  Future<void> deleteOff(String id);
  Future<OffModel> getOffById(String id);
  Future<List<OffModel>> getOffsByShop(String shopId);
}
