import 'package:app_vendor/category/domain/entity/gategory_entity.dart';
import 'package:app_vendor/category/domain/repositories/category_repository.dart';

class GetAllCategoriesUseCase {
  final CategoryRepository repository;

  GetAllCategoriesUseCase(this.repository);

  Future<List<CategoryEntity>> call() {
    return repository.getAllCategories();
  }
}
