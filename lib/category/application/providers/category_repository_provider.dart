import 'package:app_vendor/category/application/providers/category_remote_date_source_provider.dart';
import 'package:app_vendor/category/data/repositories/gategory_repository_impl.dart';
import 'package:app_vendor/category/domain/repositories/category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRepositoryImpl(ref.read(categoryRemoteDataSourceProvider)),
);
