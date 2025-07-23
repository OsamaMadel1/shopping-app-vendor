import 'package:app_vendor/category/domain/repositories/category_repository.dart';

class DeleteCategoryUseCase {
  final CategoryRepository repository;

  DeleteCategoryUseCase(this.repository);

  Future<void> call(String name) async {
    await repository.deleteCategory(name);
  }
}
