import 'package:app_vendor/orders/data/source/order_remote_data_source.dart';
import 'package:app_vendor/orders/domain/entities/order_entity.dart';
import 'package:app_vendor/orders/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<OrderEntity>> getOrdersByshopId(String shopId) async {
    final models = await remoteDataSource.getOrdersByshopId(shopId);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<OrderEntity> getOrderById(String orderId) async {
    final model = await remoteDataSource.getOrderById(orderId);
    return model.toEntity();
  }
}
