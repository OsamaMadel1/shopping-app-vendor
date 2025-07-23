import 'package:app_vendor/category/domain/entity/gategory_entity.dart';
import 'package:app_vendor/category/domain/repositories/category_repository.dart';

class AddCategoryUseCase {
  final CategoryRepository repository;

  AddCategoryUseCase(this.repository);

  Future<void> call(CategoryEntity category) async {
    await repository.addCategory(category);
  }
}
