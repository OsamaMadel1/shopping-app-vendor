import 'package:app_vendor/mangment_products/application/providers/product_repository_provider.dart';
import 'package:app_vendor/mangment_products/domain/entities/product_entity.dart';
import 'package:app_vendor/mangment_products/domain/usecases/get_product_by_id_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// مزود UseCase
final getProductByIdUseCaseProvider = Provider<GetProductByIdUseCase>((ref) {
  final repo = ref.watch(productRepositoryProvider);
  return GetProductByIdUseCase(repo);
});

final getProductByIdProvider = FutureProvider.family<ProductEntity, String>((
  ref,
  id,
) async {
  final useCase = ref.watch(getProductByIdUseCaseProvider);
  return await useCase(id);
});

// //تستخدم هذا المزود في أي شاشة تحتاج منتج واحد
// final productAsync = ref.watch(getProductByIdProvider(productId));

// return productAsync.when(
//   data: (product) => Text(product.name),
//   loading: () => CircularProgressIndicator(),
//   error: (err, stack) => Text('خطأ: $err'),
// );
