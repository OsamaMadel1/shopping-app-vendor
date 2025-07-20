import 'package:app_vendor/category/application/category_state.dart';
import 'package:app_vendor/category/domain/usecase/add_category_use_case.dart';
import 'package:app_vendor/category/domain/usecase/category_all_catetories_use_case.dart';
import 'package:app_vendor/category/domain/usecase/delete_category_usc_case.dart';
import 'package:app_vendor/category/domain/usecase/update_category_usc_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryNotifier extends StateNotifier<CategoryState> {
  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  final AddCategoryUseCase addCategoryUseCase;
  final DeleteCategoryUscCase deleteCategoryUscCase;
  final UpdateCategoryUscCase updateCategoryUscCase;

  CategoryNotifier({
    required this.getAllCategoriesUseCase,
    required this.addCategoryUseCase,
    required this.deleteCategoryUscCase,
    required this.updateCategoryUscCase,
  }) : super(CategoryState.initial());

  Future<void> fetchCategories() async {
    state = state.copyWith(isLoading: true, categories: [], errorMessage: null);
    try {
      final categories = await getAllCategoriesUseCase();
      state = state.copyWith(isLoading: false, categories: categories);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> addCategory(String name) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await addCategoryUseCase(name);
      await fetchCategories(); // إعادة الجلب بعد الإضافة
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> deleteCategory(String id) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await deleteCategoryUscCase(id);
      await fetchCategories();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> updateCategory(String name) async {}
}
