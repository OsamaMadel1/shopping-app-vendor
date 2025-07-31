import 'package:app_vendor/orders/domain/entities/order_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_data_item_model.g.dart';

@JsonSerializable()
class OrderDataItemModel {
  final String id;
  final String productName;
  final String orderId;
  final String productId;
  final int quantity;
  final double price;

  OrderDataItemModel({
    required this.id,
    required this.productName,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
  });

  factory OrderDataItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDataItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDataItemModelToJson(this);

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

  /// 🔁 تحويل من Entity (لو احتجتها)
  factory OrderDataItemModel.fromEntity(OrderItemEntity entity) =>
      OrderDataItemModel(
        id: entity.id,
        productName: entity.productName,
        orderId: entity.orderId,
        productId: entity.productId,
        quantity: entity.quantity,
        price: entity.price,
      );
}
