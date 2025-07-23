import 'package:app_vendor/category/application/providers/category_repository_provider.dart';
import 'package:app_vendor/category/domain/usecase/add_category_use_case.dart';
import 'package:app_vendor/category/domain/usecase/category_all_catetories_use_case.dart';
import 'package:app_vendor/category/domain/usecase/delete_category_use_case.dart';
import 'package:app_vendor/category/domain/usecase/update_category_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getAllCategoriesUseCaseProvider = Provider(
  (ref) => GetAllCategoriesUseCase(ref.read(categoryRepositoryProvider)),
);

final addCategoryUseCaseProvider = Provider(
  (ref) => AddCategoryUseCase(ref.read(categoryRepositoryProvider)),
);

final deleteCategoryUseCaseProvider = Provider(
  (ref) => DeleteCategoryUseCase(ref.read(categoryRepositoryProvider)),
);
final updateCategoryUscCaseProvider = Provider(
  (ref) => UpdateCategoryUseCase(ref.read(categoryRepositoryProvider)),
);
