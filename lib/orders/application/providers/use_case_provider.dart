import 'package:app_vendor/orders/application/providers/repository_provider.dart';
import 'package:app_vendor/orders/domain/usecase/get_orders_by_shop_id_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// UseCases
final getOrdersUseCaseProvider = Provider<GetOrdersByshopIdUseCase>((ref) {
  final repo = ref.watch(orderRepositoryProvider);
  return GetOrdersByshopIdUseCase(repo);
});
