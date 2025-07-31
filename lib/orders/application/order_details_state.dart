import 'package:app_vendor/orders/domain/entities/order_entity.dart';

class OrderDetailsState {
  final bool isLoading;
  final OrderEntity? order;
  final String? error;

  const OrderDetailsState({this.isLoading = false, this.order, this.error});

  OrderDetailsState copyWith({
    bool? isLoading,
    OrderEntity? order,
    String? error,
  }) {
    return OrderDetailsState(
      isLoading: isLoading ?? this.isLoading,
      order: order ?? this.order,
      error: error,
    );
  }

  static const initial = OrderDetailsState();
}
