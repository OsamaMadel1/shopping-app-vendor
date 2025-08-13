import 'package:app_vendor/shop/data/models/shop_model.dart';

abstract class ShopRemoteDataSource {
  Future<List<ShopModel>> getAllShops();
  Future<ShopModel> getShopById(String id);
  Future<void> updateShop(ShopModel shop);
  Future<void> deleteShop(String id);
}
