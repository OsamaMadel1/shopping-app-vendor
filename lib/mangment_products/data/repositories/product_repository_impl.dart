import 'package:app_vendor/mangment_products/data/models/product_model.dart';
import 'package:app_vendor/mangment_products/data/source/product_remote_data_source.dart';
import 'package:app_vendor/mangment_products/domain/entities/product_entity.dart';
import 'package:app_vendor/mangment_products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepositoryImpl(this.productRemoteDataSource);

  @override
  Future<void> addProduct(ProductEntity product) async {
    final productModel = ProductModel(
      name: product.name,
      description: product.description,
      price: product.price,
      image: product.image,
      categoryId: product.categoryId,
      currency: product.currency,
      shopId: product.shopId,
    );
    await productRemoteDataSource.addProduct(productModel);
  }

  @override
  Future<void> updateProduct(ProductEntity product) async {
    final updateProductModel = ProductModel(
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      image: product.image,
      categoryId: product.categoryId,
      currency: product.currency,
      shopId: product.shopId,
    );
    await productRemoteDataSource.updateProduct(updateProductModel);
  }

  @override
  Future<void> deleteProduct(String id) async {
    await productRemoteDataSource.deleteProduct(id);
  }

  @override
  Future<List<ProductEntity>> fetchProducts({
    String? shopId,
    String? categoryName,
  }) async {
    // return await productRemoteDataSource.fetchProducts();
    final models = await productRemoteDataSource.fetchProducts(
      shopId,
      categoryName,
    );
    return models;
  }

  // @override
  // Future<List<ProductEntity>> fetchProductsByCategory(String categoryId) async {
  //   final models =
  //       await productRemoteDataSource.fetchProductsByCategory(categoryId);
  //   return models.map((e) => e as ProductEntity).toList();
  // }

  @override
  Future<ProductEntity> getProductById(String id) async {
    // return await productRemoteDataSource.getProductById(id);
    final model = await productRemoteDataSource.getProductById(id);
    return model; // لأنه يرث من ProductEntity
  }
}
