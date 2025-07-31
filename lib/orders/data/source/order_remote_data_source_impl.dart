import 'package:app_vendor/api/errors/exceptions.dart';
import 'package:app_vendor/api/response/response_model.dart';
import 'package:app_vendor/orders/data/models/order_data_model.dart';
import 'package:dio/dio.dart';
import 'order_remote_data_source.dart';

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final Dio dio;

  OrderRemoteDataSourceImpl(this.dio);

  @override
  Future<List<OrderDataModel>> getOrdersByshopId(String shopId) async {
    try {
      final response = await dio.get(
        'Order',
        queryParameters: {'shopId': shopId},
      );

      print('response.data: ${response.data}');

      final result = ResponseModel<List<OrderDataModel>>.fromJson(
        response.data,
        (json) => (json as List)
            .map((e) => OrderDataModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
      print('result.data: ${result.data}');
      return result.data ?? [];
    } catch (e, stackTrace) {
      final message = Exceptions.getMessage(e);
      print('❌ Exception: $e');
      print('📍 StackTrace: $stackTrace');
      throw Exception(message);
    }
  }

  @override
  Future<OrderDataModel> getOrderById(String orderId) async {
    try {
      final response = await dio.get('Order/$orderId');

      final result = ResponseModel<OrderDataModel>.fromJson(
        response.data,
        (json) => OrderDataModel.fromJson(json as Map<String, dynamic>),
      );

      return result.data!;
    } catch (e) {
      // تعامل مع أي خطأ من نوع Dio أو غيره باستخدام Exceptions
      final message = Exceptions.getMessage(e);
      print('Error fetching order by ID: $message');
      throw Exception(message);
    }
  }
}
