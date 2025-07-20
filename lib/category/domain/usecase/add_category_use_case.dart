import 'package:app_vendor/category/domain/repositories/category_repository.dart';

class AddCategoryUseCase {
  final CategoryRepository repository;

  AddCategoryUseCase(this.repository);

  Future<String> call(String name) {
    return repository.addCategory(name);
  }
}
