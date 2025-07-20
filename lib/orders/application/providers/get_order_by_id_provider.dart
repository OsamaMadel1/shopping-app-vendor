import 'package:app_vendor/orders/application/providers/repository_provider.dart';
import 'package:app_vendor/orders/domain/entities/order_entity.dart';
import 'package:app_vendor/orders/domain/usecase/get_order_by_id.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// مزود usecase
final getOrderByIdUseCaseProvider = Provider<GetOrderByIdUseCase>((ref) {
  final repo = ref.watch(orderRepositoryProvider);
  return GetOrderByIdUseCase(repo);
});

/// مزود الطلب حسب المعرف
final getOrderByIdProvider = FutureProvider.family<OrderEntity, String>((
  ref,
  id,
) async {
  final useCase = ref.watch(getOrderByIdUseCaseProvider);
  return await useCase(id);
});
