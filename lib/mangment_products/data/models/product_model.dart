import 'package:app_vendor/mangment_products/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  final String?
  id; //لا نرسل id مع toJson() لأنه لا يُطلب من الـ API عند الإضافة أو التحديث.
  final String? categoryName; // جديد لتخزين اسم الفئة مثلا
  ProductModel({
    this.id,
    required super.name,
    required super.description,
    required super.price,
    required super.image,
    required super.categoryId,
    required super.currency,
    required super.shopId,
    this.categoryName,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      categoryId: json['categoryId'],
      currency: json['currency'],
      shopId: json['shopId'],
      categoryName: json['category']?['name'],
    );
  }

  // لن نحتاجه لإرسال المنتج مع الصورة، لأننا الآن نرسل بيانات فورم داتا وليس جيسون.
  // لذا يمكننا تركه كما هو أو حتى تجاهله للإرسال فقط.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'image': image,
      'categoryId': categoryId,
      'currency': currency,
      'shopId': shopId,
      'description': description,
    };
  }
}
