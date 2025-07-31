import 'package:app_vendor/orders/data/models/order_data_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderDataModel>> getOrdersByshopId(String shopId);
  Future<OrderDataModel> getOrderById(String orderId);
}
