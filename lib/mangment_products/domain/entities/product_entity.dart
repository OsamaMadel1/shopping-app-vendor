// domain/entities/product_create_entity.dart

class ProductEntity {
  final String? id; // اختياري: يستخدم في التعديل وجلب التفاصيل فقط
  final String name;
  final double price;
  final String image;
  final String categoryId;
  final String currency;
  final String shopId;
  final String description;
  final String? categoryName; // new

  ProductEntity({
    this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.categoryId,
    required this.currency,
    required this.shopId,
    required this.description,
    this.categoryName,
  });
}
