import 'package:app_vendor/mangment_products/domain/entities/product_entity.dart';
import 'package:app_vendor/mangment_products/domain/repositories/product_repository.dart';

class GetProductByIdUseCase {
  final ProductRepository productRepository;
  GetProductByIdUseCase(this.productRepository);

  Future<ProductEntity> call(String id) async {
    return await productRepository.getProductById(id);
  }
}
