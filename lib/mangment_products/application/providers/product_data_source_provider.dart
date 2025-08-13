import 'package:app_vendor/authentication/application/providers/dio_provider.dart';
import 'package:app_vendor/mangment_products/data/source/product_remote_data_source.dart';
import 'package:app_vendor/mangment_products/data/source/product_remote_data_source_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Remote DataSource
final productRemoteDataSourceProvider = Provider<ProductRemoteDataSource>((
  ref,
) {
  final dio = ref.watch(dioProvider);
  return ProductRemoteDataSourceImpl(dio);
});
