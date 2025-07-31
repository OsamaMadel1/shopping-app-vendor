import 'package:app_vendor/mangment_products/domain/entities/update_product_entity.dart';
import 'package:app_vendor/mangment_products/domain/repositories/product_repository.dart';

class UpdateProductUseCase {
  final ProductRepository productRepository;
  UpdateProductUseCase(this.productRepository);

  Future<void> call(UpdateProductEntity product) async {
    await productRepository.updateProduct(product);
  }
}
