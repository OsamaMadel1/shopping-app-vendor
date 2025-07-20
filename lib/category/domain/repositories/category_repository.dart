import 'package:app_vendor/category/domain/entity/gategory_entity.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>> getAllCategories();
  Future<String> addCategory(String name);
  Future<void> deleteCategory(String id);
  Future<String> updateCategory(String name);
}
