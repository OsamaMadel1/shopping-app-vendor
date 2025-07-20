import 'package:app_vendor/orders/data/models/order_model.dart';
import 'package:dio/dio.dart';

import 'order_remote_data_source.dart';

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final Dio dio;

  OrderRemoteDataSourceImpl(this.dio);

  @override
  Future<List<OrderModel>> getOrdersByshopId(String shopId) async {
    final response = await dio.get(
      'Order',
      queryParameters: {'shopId': shopId},
    );

    if (response.statusCode == 200 && response.data['succeeded'] == true) {
      final data = response.data['data'] as List;
      return data.map((e) => OrderModel.fromJson(e)).toList();
    } else {
      throw Exception('فشل في جلب الطلبات');
    }
  }
  //   @override
  // Future<List<OrderModel>> getOrdersByshopId(String shopId) async {
  //   final response = await dio.get(
  //     'Order',
  //     queryParameters: {'shopId': shopId},
  //   );

  //   if (response.statusCode == 200 && response.data['succeeded'] == true) {
  //     final rawData = response.data['data'];
  //     if (rawData is List) {
  //       return rawData.map((e) => OrderModel.fromJson(e)).toList();
  //     } else {
  //       return []; // لا يوجد بيانات
  //     }
  //   } else {
  //     throw Exception('فشل في جلب الطلبات');
  //   }
  // }
  @override
  Future<OrderModel> getOrderById(String orderId) async {
    final response = await dio.get('Order/$orderId');

    if (response.statusCode == 200 && response.data['succeeded'] == true) {
      return OrderModel.fromJson(response.data['data']);
    } else {
      throw Exception('فشل في جلب تفاصيل الطلب');
    }
  }
}
