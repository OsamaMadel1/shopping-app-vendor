import 'package:app_vendor/shop/domain/entities/shop_entity.dart';
import 'package:app_vendor/shop/domain/repositories/shop_repository.dart';

class UpdateShopUseCase {
  final ShopRepository repository;
  UpdateShopUseCase(this.repository);
  Future<void> call(ShopEntity shop) async => await repository.updateShop(shop);
}
