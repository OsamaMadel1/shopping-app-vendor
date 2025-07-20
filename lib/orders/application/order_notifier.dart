import 'package:app_vendor/orders/application/order_state.dart';
import 'package:app_vendor/orders/domain/usecase/get_orders_by_shop_id_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderNotifier extends StateNotifier<OrderState> {
  final GetOrdersByshopIdUseCase getOrdersByshopIdUseCase;

  OrderNotifier(this.getOrdersByshopIdUseCase) : super(const OrderState());

  Future<void> loadOrders(String shopId) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final orders = await getOrdersByshopIdUseCase(shopId);

      state = state.copyWith(isLoading: false, orders: orders);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
