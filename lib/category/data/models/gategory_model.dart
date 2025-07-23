import 'package:app_vendor/category/domain/entity/gategory_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({required super.id, required super.name, required super.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['imageUrl'] ?? " ",
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'imageUrl': image};
  }

  CategoryEntity toEntity() => CategoryEntity(id: id, name: name, image: image);
}
