import 'package:app_vendor/category/domain/entity/gategory_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({required super.id, required super.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name};
  }

  CategoryEntity toEntity() => CategoryEntity(id: id, name: name);
}
