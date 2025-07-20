import 'package:app_vendor/mangment_products/application/providers/repository_provider.dart';
import 'package:app_vendor/mangment_products/domain/usecases/add_product_usecase.dart';
import 'package:app_vendor/mangment_products/domain/usecases/delete_product_usecase.dart';
import 'package:app_vendor/mangment_products/domain/usecases/fetch_products_usecase.dart';
import 'package:app_vendor/mangment_products/domain/usecases/update_product_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// UseCases
///  جلب كل المنتجات
final fetchProductsUseCaseProvider = Provider<FetchProductsUseCase>((ref) {
  final repo = ref.watch(productRepositoryProvider);
  return FetchProductsUseCase(repo);
});

// فلنرة حسب فئة
// final fetchProductsByCategoryUseCaseProvider = Provider((ref) {
//   final repo = ref.watch(productRepositoryProvider);
//   return FetchProductsByCategoryUseCase(repo);
// });

final addProductUseCaseProvider = Provider<AddProductUseCase>((ref) {
  final repo = ref.watch(productRepositoryProvider);
  return AddProductUseCase(repo);
});

final updateProductUseCaseProvider = Provider<UpdateProductUseCase>((ref) {
  final repo = ref.watch(productRepositoryProvider);
  return UpdateProductUseCase(repo);
});

final deleteProductUseCaseProvider = Provider<DeleteProductUseCase>((ref) {
  final repo = ref.watch(productRepositoryProvider);
  return DeleteProductUseCase(repo);
});
