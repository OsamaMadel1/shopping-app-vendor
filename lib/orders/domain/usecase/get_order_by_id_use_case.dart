import 'package:app_vendor/orders/domain/entities/order_entity.dart';
import 'package:app_vendor/orders/domain/repositories/order_repository.dart';

class GetOrderByIdUseCase {
  final OrderRepository repository;

  GetOrderByIdUseCase(this.repository);

  Future<OrderEntity> call(String orderId) {
    return repository.getOrderById(orderId);
  }
}
