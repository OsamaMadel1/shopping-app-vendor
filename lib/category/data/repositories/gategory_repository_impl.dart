import 'package:app_vendor/category/data/sources/remote/category_remoate_data_source.dart';
import 'package:app_vendor/category/domain/entity/gategory_entity.dart';
import 'package:app_vendor/category/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CategoryEntity>> getAllCategories() {
    return remoteDataSource.getAllCategories();
    //    final models = await remoteDataSource.getAllCategories();
    // return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<String> addCategory(String name) {
    return remoteDataSource.addCategory(name);
  }

  @override
  Future<void> deleteCategory(String id) {
    return remoteDataSource.deleteCategory(id);
  }

  @override
  Future<String> updateCategory(String name) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }
}
