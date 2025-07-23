import 'package:app_vendor/category/domain/entity/gategory_entity.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>> getAllCategories();
  Future<void> addCategory(CategoryEntity category);
  Future<void> deleteCategory(String id);
  Future<void> updateCategory(CategoryEntity category);
}
