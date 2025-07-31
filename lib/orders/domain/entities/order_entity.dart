class OrderEntity {
  final String id;
  final String customerId;
  final String shopId;
  final DateTime orderDate;
  final double totalAmount;
  final String
  orderState; // لو كانت enum backend رجعها رقم، نخزنها كـ String بعد المعالجة
  final List<OrderItemEntity> orderItems;

  OrderEntity({
    required this.id,
    required this.customerId,
    required this.shopId,
    required this.orderDate,
    required this.totalAmount,
    required this.orderState,
    required this.orderItems,
  });
}

class OrderItemEntity {
  final String id;
  final String productName;
  final String orderId;
  final String productId;
  final int quantity;
  final double price;

  OrderItemEntity({
    required this.id,
    required this.productName,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
  });
}
