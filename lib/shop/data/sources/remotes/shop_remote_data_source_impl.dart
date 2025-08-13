import 'package:app_vendor/api/errors/error_model.dart';
import 'package:app_vendor/api/errors/exceptions.dart';
import 'package:app_vendor/api/response/response_model.dart';
import 'package:app_vendor/shop/data/sources/remotes/shop_remote_data_source.dart';
import 'package:app_vendor/shop/data/models/shop_model.dart';
import 'package:dio/dio.dart';

class ShopRemoteDataSourceImpl implements ShopRemoteDataSource {
  final Dio dio;

  ShopRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ShopModel>> getAllShops() async {
    try {
      final response = await dio.get('Shop');

      if (response.statusCode == 200) {
        final responseModel = ResponseModel<List<ShopModel>>.fromJson(
          response.data,
          (json) => (json as List).map((e) => ShopModel.fromJson(e)).toList(),
        );

        if (responseModel.succeeded) {
          return responseModel.data ?? [];
        } else {
          final errorMsg = Exceptions.getMessageFromErrorModel(
            ErrorModel(message: null, errors: responseModel.errors),
          );
          throw Exception(errorMsg);
        }
      } else {
        throw Exception('فشل في جلب المتاجر من السيرفر.');
      }
    } catch (e) {
      final errorMsg = Exceptions.getMessage(e);
      throw Exception(errorMsg);
    }
  }

  @override
  Future<ShopModel> getShopById(String id) async {
    try {
      final response = await dio.get('Shop/$id');

      if (response.statusCode == 200) {
        final responseModel = ResponseModel<ShopModel>.fromJson(
          response.data,
          (json) => ShopModel.fromJson(json as Map<String, dynamic>),
        );

        if (responseModel.succeeded) {
          return responseModel.data!;
        } else {
          final errorMsg = Exceptions.getMessageFromErrorModel(
            ErrorModel(message: null, errors: responseModel.errors),
          );
          throw Exception(errorMsg);
        }
      } else {
        throw Exception('فشل في جلب بيانات المتجر.');
      }
    } catch (e) {
      final errorMsg = Exceptions.getMessage(e);
      throw Exception(errorMsg);
    }
  }

  @override
  Future<void> updateShop(ShopModel shop) async {
    try {
      final response = await dio.put('Shop/${shop.id}', data: shop.toJson());

      if (response.statusCode == 200) {
        // ممكن تتعامل مع النجاح، أو تعيد فقط.
        final responseModel = ResponseModel<void>.fromJson(
          response.data,
          (_) {},
        );

        if (!responseModel.succeeded) {
          final errorMsg = Exceptions.getMessageFromErrorModel(
            ErrorModel(message: null, errors: responseModel.errors),
          );
          throw Exception(errorMsg);
        }
      } else {
        throw Exception('فشل في تحديث المتجر.');
      }
    } catch (e) {
      final errorMsg = Exceptions.getMessage(e);
      throw Exception(errorMsg);
    }
  }

  @override
  Future<void> deleteShop(String id) async {
    try {
      final response = await dio.delete('Shop/$id');

      if (response.statusCode == 200) {
        final responseModel = ResponseModel<void>.fromJson(
          response.data,
          (_) {},
        );

        if (!responseModel.succeeded) {
          final errorMsg = Exceptions.getMessageFromErrorModel(
            ErrorModel(message: null, errors: responseModel.errors),
          );
          throw Exception(errorMsg);
        }
      } else {
        throw Exception('فشل في حذف المتجر.');
      }
    } catch (e) {
      final errorMsg = Exceptions.getMessage(e);
      throw Exception(errorMsg);
    }
  }
}
