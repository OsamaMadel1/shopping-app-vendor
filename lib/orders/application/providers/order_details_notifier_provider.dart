import 'package:app_vendor/orders/application/order_details_notifier.dart';
import 'package:app_vendor/orders/application/order_details_state.dart';
import 'package:app_vendor/orders/application/providers/get_order_by_id_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderDetailsNotifierProvider =
    StateNotifierProvider.family<
      OrderDetailsNotifier,
      OrderDetailsState,
      String
    >((ref, id) {
      final useCase = ref.watch(getOrderByIdUseCaseProvider);
      final notifier = OrderDetailsNotifier(useCase);
      notifier.loadOrder(id); // ⬅️ تشغيل الطلب مباشرة
      return notifier;
    });
