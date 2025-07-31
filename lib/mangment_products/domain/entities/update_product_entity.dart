class UpdateProductEntity {
  final String? id;
  final String name;
  final double price;
  final dynamic image; // يمكن أن يكون String (رابط) أو XFile (ملف)
  final String categoryId;
  final String currency;
  final String shopId;
  final String description;

  UpdateProductEntity({
    this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.categoryId,
    required this.currency,
    required this.shopId,
    required this.description,
  });
}
