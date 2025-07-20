import 'package:app_vendor/orders/domain/entities/order_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'order_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  final String id;
  final String customerId;
  final String shopId;
  final DateTime orderDate;
  final double totalAmount;
  final String orderState;
  final List<OrderItemModel> orderItems;

  OrderModel({
    required this.id,
    required this.customerId,
    required this.shopId,
    required this.orderDate,
    required this.totalAmount,
    required this.orderState,
    required this.orderItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      customerId: customerId,
      shopId: shopId,
      orderDate: orderDate,
      totalAmount: totalAmount,
      orderState: orderState,
      orderItems: orderItems.map((e) => e.toEntity()).toList(),
    );
  }
}
