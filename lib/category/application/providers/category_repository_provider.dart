import 'package:app_vendor/category/data/repositories/gategory_repository_impl.dart';
import 'package:app_vendor/category/data/sources/remote/category_remote_data_source_provider.dart';
import 'package:app_vendor/category/domain/repositories/category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepositoryImpl(ref.read(categoryRemoteDataSourceProvider)),
);
