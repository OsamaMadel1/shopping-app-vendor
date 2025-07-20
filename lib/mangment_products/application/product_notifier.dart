import 'package:app_vendor/mangment_products/application/product_state.dart';
import 'package:app_vendor/mangment_products/domain/entities/product_entity.dart';
import 'package:app_vendor/mangment_products/domain/usecases/add_product_usecase.dart';
import 'package:app_vendor/mangment_products/domain/usecases/delete_product_usecase.dart';
import 'package:app_vendor/mangment_products/domain/usecases/fetch_products_usecase.dart';
import 'package:app_vendor/mangment_products/domain/usecases/update_product_usecase.dart';
import 'package:app_vendor/utils/error_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductNotifier extends StateNotifier<ProductState> {
  final FetchProductsUseCase fetchProductsUsecase;
  // FetchProductsByCategoryUseCase fetchProductsByCategoryUseCase;
  final AddProductUseCase addProductUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;

  ProductNotifier(
    this.fetchProductsUsecase,
    // this.fetchProductsByCategoryUseCase,
    this.addProductUseCase,
    this.updateProductUseCase,
    this.deleteProductUseCase,
  ) : super(ProductInitial());
  //جلب كل المنتجات
  Future<void> fetchProducts({String? shopId, String? categoryName}) async {
    state = ProductLoading();
    try {
      final products = await fetchProductsUsecase(
        shopId: shopId,
        categoryName: categoryName,
      );
      state = ProductLoaded(products);
    } catch (e) {
      final errorMassage = ErrorHandler.getMessage(e);
      state = ProductError(errorMassage);
      print("Fetch products error: $e");
      // state = ProductError(e.toString());
    }
  }

  // فلنرة حسب فئة
  // Future<void> fetchProductsByCategory(String categoryId) async {
  //   state = ProductLoading();
  //   try {
  //     final products = await fetchProductsByCategoryUseCase(categoryId);
  //     state = ProductLoaded(products);
  //   } catch (e) {
  //     final errorMassage = ErrorHandler.getMessage(e);
  //     state = ProductError(errorMassage);
  //     print("Fetch products error: $e");
  //   }
  // }

  Future<void> addProduct(ProductEntity product, {String? categoryName}) async {
    try {
      state = ProductLoading();
      await addProductUseCase(product);
      // ✅ إعادة تحميل المنتجات بعد الإضافة
      // await _refreshProductsAfterMutation(
      //     shopId: product.shopId, categoryName: product.categoryId);
      await fetchProducts(shopId: product.shopId, categoryName: categoryName);
    } catch (e) {
      final errorMassage = ErrorHandler.getMessage(e);
      state = ProductError(errorMassage);
      // state = ProductError(e.toString());
    }
  }
  // عدد كبير من المنتجات، كل استدعاء لـ fetchProducts() بعد الإضافة/الحذف بيكون مكلف
  //   Future<void> addProduct(ProductEntity product) async {
  //   try {
  //     await addProductUseCase(product);
  //     final currentState = state;
  //     if (currentState is ProductLoaded) {
  //       final updatedList = [...currentState.products, product];
  //       state = ProductLoaded(updatedList);
  //     } else {
  //       await fetchProducts();
  //     }
  //   } catch (e) {
  //     state = ProductError(ErrorHandler.getMessage(e));
  //   }
  // }

  Future<void> updateProduct(ProductEntity product) async {
    try {
      await updateProductUseCase(product);
      // ✅ إعادة تحميل المنتجات بعد الإضافة
      // await _refreshProductsAfterMutation(
      //     shopId: product.shopId, categoryName: product.categoryId);
      // await fetchProducts();
      await fetchProducts(
        shopId: product.shopId,
        categoryName: product.categoryId,
      );
    } catch (e) {
      final errorMassage = ErrorHandler.getMessage(e);
      state = ProductError(errorMassage);
      // state = ProductError(e.toString());
    }
  }

  Future<void> deleteProduct(
    String id,
    //    {
    //   required String shopId,
    //   String? categoryName,
    // }
  ) async {
    try {
      await deleteProductUseCase(id);
      //TODO :عدم جلب المنتحات من المتاجر التالية بعد الحذف
      // await _refreshProductsAfterMutation(
      //     shopId: shopId, categoryName: categoryName);
      await fetchProducts();
    } catch (e) {
      final errorMassage = ErrorHandler.getMessage(e);
      state = ProductError(errorMassage);
      // state = ProductError(e.toString());
    }
  }

  // Future<void> _refreshProductsAfterMutation(
  //     {String? shopId, String? categoryName}) async {
  //   try {
  //     await fetchProducts(shopId: shopId, categoryName: categoryName);
  //   } catch (e) {
  //     state = ProductError(ErrorHandler.getMessage(e));
  //   }
  // }
}
