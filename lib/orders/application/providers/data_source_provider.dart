import 'package:app_vendor/authentication/data/providers/dio_provider.dart';
import 'package:app_vendor/orders/data/source/order_remote_data_source.dart';
import 'package:app_vendor/orders/data/source/order_remote_data_source_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Remote DataSource
final orderRemoteDataSourceProvider = Provider<OrderRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return OrderRemoteDataSourceImpl(dio);
});
