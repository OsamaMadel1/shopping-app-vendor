import 'package:app_vendor/mangment_products/domain/entities/product_entity.dart';
import 'package:app_vendor/mangment_products/domain/repositories/product_repository.dart';

class AddProductUseCase {
  final ProductRepository productRepository;
  AddProductUseCase(this.productRepository);

  Future<void> call(ProductEntity product) async {
    await productRepository.addProduct(product);
  }
}
