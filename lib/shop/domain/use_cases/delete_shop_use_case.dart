import 'package:app_vendor/shop/domain/repositories/shop_repository.dart';

class DeleteShopUseCase {
  final ShopRepository repository;
  DeleteShopUseCase(this.repository);
  Future<void> call(String id) async => await repository.deleteShop(id);
}
