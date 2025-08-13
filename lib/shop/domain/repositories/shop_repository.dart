import 'package:app_vendor/shop/domain/entities/shop_entity.dart';

abstract class ShopRepository {
  Future<List<ShopEntity>> getAllShops();
  Future<ShopEntity> getShopById(String id);
  Future<void> updateShop(ShopEntity shop);
  Future<void> deleteShop(String id);
}
