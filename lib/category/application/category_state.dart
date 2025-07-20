import 'package:app_vendor/category/domain/entity/gategory_entity.dart';

class CategoryState {
  final bool isLoading;
  final List<CategoryEntity> categories;
  final String? errorMessage;

  const CategoryState({
    required this.isLoading,
    required this.categories,
    this.errorMessage,
  });

  factory CategoryState.initial() =>
      const CategoryState(isLoading: false, categories: [], errorMessage: null);

  CategoryState copyWith({
    bool? isLoading,
    List<CategoryEntity>? categories,
    String? errorMessage,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      errorMessage: errorMessage,
    );
  }
}
