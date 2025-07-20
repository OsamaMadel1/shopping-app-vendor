import 'package:app_vendor/category/data/models/gategory_model.dart';
import 'package:app_vendor/category/data/sources/remote/category_remoate_data_source.dart';

import 'package:dio/dio.dart';

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final Dio dio;

  CategoryRemoteDataSourceImpl(this.dio);

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final response = await dio.get('Category');

    if (response.statusCode == 200 && response.data['succeeded'] == true) {
      final List data = response.data['data'];
      return data.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw Exception(response.data['errors'].toString());
    }
  }

  @override
  Future<String> addCategory(String name) async {
    final response = await dio.post(
      'Category',
      data: {'name': name},
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    if (response.statusCode == 200 && response.data['succeeded'] == true) {
      return response.data['data']['id'];
    } else {
      throw Exception(response.data['errors'].toString());
    }
  }

  @override
  Future<void> deleteCategory(String id) async {
    final response = await dio.delete('Category/$id');
    if (response.statusCode == 200 && response.data['succeeded'] == true) {
      return response.data['data']['id'];
    } else {
      throw Exception(response.data['errors'].toString());
    }
  }

  @override
  Future<String> updateCategory(String name) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }
}
