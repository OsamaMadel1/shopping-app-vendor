import 'package:app_vendor/orders/domain/entities/order_entity.dart';

abstract class OrderRepository {
  Future<List<OrderEntity>> getOrdersByshopId(String shopId);
  Future<OrderEntity> getOrderById(String orderId);
}
