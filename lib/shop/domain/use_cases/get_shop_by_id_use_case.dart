import 'package:app_vendor/shop/domain/entities/shop_entity.dart';
import 'package:app_vendor/shop/domain/repositories/shop_repository.dart';

class GetShopByIdUseCase {
  final ShopRepository repository;
  GetShopByIdUseCase(this.repository);
  Future<ShopEntity> call(String id) async => await repository.getShopById(id);
}
