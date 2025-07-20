import 'package:app_vendor/orders/application/order_notifier.dart';
import 'package:app_vendor/orders/application/order_state.dart';
import 'package:app_vendor/orders/application/providers/use_case_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier
final orderNotifierProvider = StateNotifierProvider<OrderNotifier, OrderState>((
  ref,
) {
  final fetch = ref.watch(getOrdersUseCaseProvider);

  return OrderNotifier(fetch);
});
