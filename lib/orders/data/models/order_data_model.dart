import 'package:app_vendor/orders/domain/entities/order_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'order_data_item_model.dart';

part 'order_data_model.g.dart';

@JsonSerializable()
class OrderDataModel {
  final String id;
  final String customerId;
  final String shopId;
  final DateTime orderDate;
  final double totalAmount;

  // ✅ تحويل orderState من int إلى String أثناء فك الترميز من JSON
  @JsonKey(fromJson: _orderStateFromJson, toJson: _orderStateToJson)
  final String orderState;

  final List<OrderDataItemModel> orderItems;

  OrderDataModel({
    required this.id,
    required this.customerId,
    required this.shopId,
    required this.orderDate,
    required this.totalAmount,
    required this.orderState,
    required this.orderItems,
  });

  factory OrderDataModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDataModelToJson(this);

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

  factory OrderDataModel.fromEntity(OrderEntity entity) => OrderDataModel(
    id: entity.id,
    customerId: entity.customerId,
    shopId: entity.shopId,
    orderDate: entity.orderDate,
    totalAmount: entity.totalAmount,
    orderState: entity.orderState,
    orderItems: entity.orderItems
        .map((e) => OrderDataItemModel.fromEntity(e))
        .toList(),
  );

  /// ✅ الدوال الخاصة بتحويل orderState
  static String _orderStateFromJson(dynamic value) => value.toString();
  static int _orderStateToJson(String value) => int.parse(value);
}
