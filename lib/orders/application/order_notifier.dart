import 'package:app_vendor/api/errors/exceptions.dart';
import 'package:app_vendor/orders/application/order_state.dart';
import 'package:app_vendor/orders/domain/usecase/get_orders_by_shop_id_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderNotifier extends StateNotifier<OrderState> {
  final GetOrdersByshopIdUseCase getOrdersByshopIdUseCase;

  OrderNotifier(this.getOrdersByshopIdUseCase) : super(OrderState.initial());

  Future<void> loadOrders(String shopId) async {
    print('📦 Loading orders for shopId: $shopId');
    state = OrderState.loading();
    try {
      final orders = await getOrdersByshopIdUseCase(shopId);
      print('✅ Orders fetched: ${orders.length}');
      state = OrderState.loaded(orders);
    } catch (e) {
      print('❌ Error Type: ${e.runtimeType}, Error: $e');
      final message = Exceptions.getMessage(e);
      print('❌ Exception Message: $message');
      state = OrderState.error(message);
    }
  }
}
