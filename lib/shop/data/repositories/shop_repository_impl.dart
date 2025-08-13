import 'package:app_vendor/shop/data/sources/remotes/shop_remote_data_source.dart';
import 'package:app_vendor/shop/domain/entities/shop_entity.dart';
import 'package:app_vendor/shop/domain/repositories/shop_repository.dart';
import 'package:app_vendor/shop/data/models/shop_model.dart';

class ShopRepositoryImpl implements ShopRepository {
  final ShopRemoteDataSource remoteDataSource;

  ShopRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ShopEntity>> getAllShops() async {
    final models = await remoteDataSource.getAllShops();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<ShopEntity> getShopById(String id) async {
    final model = await remoteDataSource.getShopById(id);
    return model.toEntity();
  }

  @override
  Future<void> updateShop(ShopEntity shop) async {
    final model = ShopModel.fromEntity(shop);
    await remoteDataSource.updateShop(model);
  }

  @override
  Future<void> deleteShop(String id) async {
    await remoteDataSource.deleteShop(id);
  }
}
