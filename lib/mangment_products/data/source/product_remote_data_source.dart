import 'package:app_vendor/mangment_products/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts(
    String? shopId,
    String? categoryName,
  );
  // Future<List<ProductModel>> fetchProductsByCategory(String categoryId);
  Future<ProductModel> getProductById(String id);
  Future<void> addProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}
