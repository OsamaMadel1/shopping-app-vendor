import 'package:app_vendor/shop/domain/entities/shop_entity.dart';
import 'package:app_vendor/shop/domain/repositories/shop_repository.dart';

class GetAllShopsUseCase {
  final ShopRepository repository;
  GetAllShopsUseCase(this.repository);
  Future<List<ShopEntity>> call() async => await repository.getAllShops();
}
