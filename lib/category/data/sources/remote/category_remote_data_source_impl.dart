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
  Future<String> addCategory(CategoryModel category) async {
    final formData = FormData.fromMap({
      'name': category.name,
      // إضافة الصورة هنا
      'image': await MultipartFile.fromFile(
        category.image,
        filename: category.image.split('/').last,
      ),
    });

    final response = await dio.post(
      'Category',
      data: formData,
      // options: Options(
      //   headers: {
      //     'Content-Type': 'multipart/form-data',
      //   },
      // ),
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
  Future<String> updateCategory(CategoryModel category) async {
    final formData = FormData.fromMap({
      'name': category.name,
      'image': await MultipartFile.fromFile(
        category.image,
        filename: category.image.split('/').last,
      ),
    });

    final response = await dio.put('Category/${category.id}', data: formData);

    if (response.statusCode == 200 && response.data['succeeded'] == true) {
      return response.data['data']['id'];
    } else {
      throw Exception(response.data['errors'].toString());
    }
  }
}
