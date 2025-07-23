import 'package:app_vendor/mangment_products/data/models/product_model.dart';
import 'package:app_vendor/mangment_products/data/source/product_remote_data_source.dart';
import 'package:dio/dio.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductModel>> fetchProducts(
    String? shopId,
    String? categoryName,
  ) async {
    final queryParams = <String, dynamic>{};
    if (shopId != null) queryParams['shopId'] = shopId;
    if (categoryName != null && categoryName.isNotEmpty)
      queryParams['category'] = categoryName;
    final response = await dio.get('Product', queryParameters: queryParams);

    if (response.statusCode == 200 && response.data['succeeded'] == true) {
      final jsonResponse = response.data as Map<String, dynamic>;
      final dataList = jsonResponse['data'] as List<dynamic>;
      return dataList.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      // throw Exception(response.data['errors'].toString());
      throw Exception('Failed to fetch product: ${response.data}');
    }
  }

  // @override
  // Future<List<ProductModel>> fetchProductsByCategory(String categoryId) async {
  //   final response = await dio.get('/products/byCategory/$categoryId');

  //   if (response.statusCode == 200) {
  //     final jsonResponse = response.data as Map<String, dynamic>;
  //     final dataList = jsonResponse['data'] as List<dynamic>;
  //     return dataList.map((e) => ProductModel.fromJson(e)).toList();
  //   } else {
  //     // throw Exception(response.data['errors'].toString());
  //     throw Exception('Failed to fetch product: ${response.data}');
  //   }
  // }

  @override
  Future<ProductModel> getProductById(String id) async {
    final response = await dio.get('Product/$id');
    if (response.statusCode == 200) {
      final jsonResponse = response.data as Map<String, dynamic>;
      final data = jsonResponse['data'] as Map<String, dynamic>;
      return ProductModel.fromJson(data);
    } else {
      // throw Exception(response.data['errors'].toString());
      throw Exception('Failed to fetch product: ${response.data}');
    }
  }

  @override
  Future<void> addProduct(ProductModel product) async {
    final formData = FormData.fromMap({
      'name': product.name,
      'description': product.description,
      'price': product.price,
      'categoryId': product.categoryId,
      'currency': product.currency,
      'shopId': product.shopId,
      // إضافة الصورة هنا
      'image': await MultipartFile.fromFile(
        product.image,
        filename: product.image.split('/').last,
      ),
    });

    final response = await dio.post(
      'Product',
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
  Future<void> updateProduct(ProductModel product) async {
    await dio.put('Product/${product.id}', data: product.toJson());
  }

  @override
  Future<void> deleteProduct(String id) async {
    final response = await dio.delete('Product/$id');
    if (response.statusCode == 200 && response.data['succeeded'] == true) {
      return response.data['data']['id'];
    } else {
      throw Exception(response.data['errors'].toString());
    }
  }
}
