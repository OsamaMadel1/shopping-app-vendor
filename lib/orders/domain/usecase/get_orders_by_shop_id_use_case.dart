import 'package:app_vendor/orders/domain/entities/order_entity.dart';
import 'package:app_vendor/orders/domain/repositories/order_repository.dart';

class GetOrdersByshopIdUseCase {
  final OrderRepository repository;

  GetOrdersByshopIdUseCase(this.repository);

  Future<List<OrderEntity>> call(String shopId) {
    return repository.getOrdersByshopId(shopId);
  }
}
