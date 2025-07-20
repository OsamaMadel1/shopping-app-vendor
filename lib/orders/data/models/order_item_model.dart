import 'package:app_vendor/orders/domain/entities/order_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item_model.g.dart';

@JsonSerializable()
class OrderItemModel {
  final String id;
  final String productName;
  final String orderId;
  final String productId;
  final int quantity;
  final double price;

  OrderItemModel({
    required this.id,
    required this.productName,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);

  OrderItemEntity toEntity() {
    return OrderItemEntity(
      id: id,
      productName: productName,
      orderId: orderId,
      productId: productId,
      quantity: quantity,
      price: price,
    );
  }
}
