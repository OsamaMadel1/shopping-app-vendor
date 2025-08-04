import 'package:app_vendor/api/errors/exceptions.dart';
import 'package:app_vendor/api/response/response_model.dart';
import 'package:app_vendor/offfers/data/models/off_model.dart';
import 'package:app_vendor/offfers/data/sources/remotes/off_remote_date_source.dart';
import 'package:dio/dio.dart';

class OffRemoteDataSourceImpl implements OffRemoteDataSource {
  final Dio dio;

  OffRemoteDataSourceImpl(this.dio);

  @override
  Future<void> addOff(OffModel off) async {
    try {
      final formData = FormData.fromMap({
        'ShopId': off.shopId,
        'ProductId': off.productId,
        'Name': off.name,
        'Description': off.description,
        'DiscountPercentage': off.discountPercentage,
        'NewPrice': off.newPrice,
        'StartDate': off.startDate.toIso8601String(),
        'EndDate': off.endDate.toIso8601String(),
        if (off.image != null)
          'Image': await MultipartFile.fromFile(off.image!),
      });

      final response = await dio.post('Offer', data: formData);
      print('Response data: ${response.data}');
    } on DioException catch (e) {
      print('Error fetching offer by ID: ${e.message}');

      throw Exception(Exceptions.getMessage(e));
    }
  }

  @override
  Future<void> updateOff(OffModel off) async {
    try {
      final formData = FormData.fromMap({
        'ShopId': off.shopId,
        'ProductId': off.productId,
        'Name': off.name,
        'Description': off.description,
        'DiscountPercentage': off.discountPercentage,
        'NewPrice': off.newPrice,
        'StartDate': off.startDate.toIso8601String(),
        'EndDate': off.endDate.toIso8601String(),
        if (off.image != null && !off.image!.startsWith('http'))
          'Image': await MultipartFile.fromFile(off.image!),
      });

      final response = await dio.put(
        'Offer',
        queryParameters: {'id': off.id},
        data: formData,
      );
      print('Response data: ${response.data}');
    } on DioException catch (e) {
      print('Error fetching offer by ID: ${e.message}');

      throw Exception(Exceptions.getMessage(e));
    }
  }

  @override
  Future<void> deleteOff(String id) async {
    try {
      final response = await dio.delete('Offer', queryParameters: {'id': id});
      print('Response data: ${response.data}');
    } on DioException catch (e) {
      print('Error fetching offer by ID: ${e.message}');

      throw Exception(Exceptions.getMessage(e));
    }
  }

  @override
  Future<OffModel> getOffById(String id) async {
    try {
      final response = await dio.get('Offer/$id');
      final data = ResponseModel<OffModel>.fromJson(
        response.data,
        (json) => OffModel.fromJson(json as Map<String, dynamic>),
      );
      print('Response data: ${response.data}');
      return data.data!;
    } on DioException catch (e) {
      print('Error fetching offer by ID: ${e.message}');
      throw Exception(Exceptions.getMessage(e));
    }
  }

  @override
  Future<List<OffModel>> getOffsByShop(String shopId) async {
    try {
      final response = await dio.get(
        'Offer',
        queryParameters: {'shopId': shopId},
      );

      final data = ResponseModel<List<dynamic>>.fromJson(
        response.data,

        (json) => json as List<dynamic>,
      );
      print('Response data: ${response.data}');
      return data.data!
          .map((e) => OffModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      print('Error fetching offers by shop: ${e.message}');
      throw Exception(Exceptions.getMessage(e));
    }
  }
}
