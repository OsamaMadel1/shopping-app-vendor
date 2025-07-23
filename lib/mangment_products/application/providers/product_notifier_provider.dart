import 'package:app_vendor/mangment_products/application/product_notifier.dart';
import 'package:app_vendor/mangment_products/application/product_state.dart';
import 'package:app_vendor/mangment_products/application/providers/product_usecase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier
final productNotifierProvider =
    StateNotifierProvider<ProductNotifier, ProductState>((ref) {
      final fetch = ref.watch(fetchProductsUseCaseProvider);
      // final fetchbyCategory = ref.watch(fetchProductsByCategoryUseCaseProvider);
      final add = ref.watch(addProductUseCaseProvider);
      final update = ref.watch(updateProductUseCaseProvider);
      final delete = ref.watch(deleteProductUseCaseProvider);

      return ProductNotifier(fetch, add, update, delete);
    });
