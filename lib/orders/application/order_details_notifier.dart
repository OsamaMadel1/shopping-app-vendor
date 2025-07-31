import 'package:app_vendor/api/errors/exceptions.dart';
import 'package:app_vendor/orders/application/order_details_state.dart';
import 'package:app_vendor/orders/domain/usecase/get_order_by_id_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderDetailsNotifier extends StateNotifier<OrderDetailsState> {
  final GetOrderByIdUseCase getOrderByIdUseCase;

  OrderDetailsNotifier(this.getOrderByIdUseCase)
    : super(OrderDetailsState.initial);

  Future<void> loadOrder(String id) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final order = await getOrderByIdUseCase(id);
      state = state.copyWith(isLoading: false, order: order);
    } catch (e) {
      final message = Exceptions.getMessage(e);
      state = state.copyWith(isLoading: false, error: message);
    }
  }
}
