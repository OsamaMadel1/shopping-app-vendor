import 'package:app_vendor/mangment_products/domain/entities/update_product_entity.dart';

class UpdateProductModel extends UpdateProductEntity {
  UpdateProductModel({
    super.id,
    required super.name,
    required super.price,
    required super.image, // String أو XFile
    required super.categoryId,
    required super.currency,
    required super.shopId,
    required super.description,
  });

  factory UpdateProductModel.fromJson(Map<String, dynamic> json) {
    return UpdateProductModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
      categoryId: json['categoryId'] as String,
      currency: json['currency'] as String,
      shopId: json['shopId'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    // هنا نرسل رابط الصورة فقط (لا نرسل XFile في toJson لأنه ملف وليس String)
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image is String ? image : null,
      'categoryId': categoryId,
      'currency': currency,
      'shopId': shopId,
      'description': description,
    };
  }
}
