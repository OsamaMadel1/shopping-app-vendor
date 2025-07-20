import 'package:app_vendor/authentication/data/providers/dio_provider.dart';
import 'package:app_vendor/category/data/sources/remote/category_remoate_data_source.dart';
import 'package:app_vendor/category/data/sources/remote/category_remote_data_source_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryRemoteDataSourceProvider = Provider<CategoryRemoteDataSource>((
  ref,
) {
  final dio = ref.watch(dioProvider);
  return CategoryRemoteDataSourceImpl(dio);
});
