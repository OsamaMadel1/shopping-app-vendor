import 'package:app_vendor/category/data/models/gategory_model.dart';
import 'package:app_vendor/category/data/sources/remote/category_remoate_data_source.dart';
import 'package:app_vendor/category/domain/entity/gategory_entity.dart';
import 'package:app_vendor/category/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource categoryRemoteDataSource;

  CategoryRepositoryImpl(this.categoryRemoteDataSource);

  @override
  Future<List<CategoryEntity>> getAllCategories() async {
    // return categoryRemoteDataSource.getAllCategories();
    final models = await categoryRemoteDataSource.getAllCategories();
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> addCategory(CategoryEntity category) async {
    final categoryModel = CategoryModel(
      id: category.id,
      name: category.name,
      image: category.image,
    );
    await categoryRemoteDataSource.addCategory(categoryModel);
  }

  @override
  Future<void> deleteCategory(String id) {
    return categoryRemoteDataSource.deleteCategory(id);
  }

  @override
  Future<void> updateCategory(CategoryEntity category) async {
    final categoryModel = CategoryModel(
      id: category.id,
      name: category.name,
      image: category.image,
    );
    await categoryRemoteDataSource.updateCategory(categoryModel);
  }
}
