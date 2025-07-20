import 'package:app_vendor/mangment_products/domain/entities/product_entity.dart';
import 'package:app_vendor/mangment_products/domain/repositories/product_repository.dart';

class FetchProductsUseCase {
  final ProductRepository productRepository;

  FetchProductsUseCase(this.productRepository);

  Future<List<ProductEntity>> call({
    String? shopId,
    String? categoryName,
  }) async {
    return await productRepository.fetchProducts(
      shopId: shopId,
      categoryName: categoryName,
    );
  }
}
