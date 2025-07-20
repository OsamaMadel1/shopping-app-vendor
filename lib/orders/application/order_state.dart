import 'package:app_vendor/orders/domain/entities/order_entity.dart';

class OrderState {
  final bool isLoading;
  final List<OrderEntity> orders;
  final String? error;

  const OrderState({
    this.isLoading = false,
    this.orders = const [],
    this.error,
  });

  OrderState copyWith({
    bool? isLoading,
    List<OrderEntity>? orders,
    String? error,
  }) {
    return OrderState(
      isLoading: isLoading ?? this.isLoading,
      orders: orders ?? this.orders,
      error: error,
    );
  }
}
