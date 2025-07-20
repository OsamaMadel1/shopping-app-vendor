import 'package:app_vendor/category/data/models/gategory_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getAllCategories();
  Future<String> addCategory(String name);
  Future<void> deleteCategory(String id);
  Future<String> updateCategory(String name);
}
