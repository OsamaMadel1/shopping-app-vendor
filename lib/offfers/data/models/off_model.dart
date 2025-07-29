import 'package:app_vendor/offfers/domain/entity/off_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'off_model.g.dart';

@JsonSerializable()
class OffModel {
  final String? id;
  final String shopId;
  final String productId;
  final String name;
  final String description;
  final double discountPercentage;
  final double newPrice;
  final DateTime startDate;
  final DateTime endDate;
  final String? image;

  OffModel({
    this.id,
    required this.shopId,
    required this.productId,
    required this.name,
    required this.description,
    required this.discountPercentage,
    required this.newPrice,
    required this.startDate,
    required this.endDate,
    this.image,
  });

  factory OffModel.fromJson(Map<String, dynamic> json) =>
      _$OffModelFromJson(json);

  Map<String, dynamic> toJson() => _$OffModelToJson(this);

  /// ✅ التحويل من Model إلى Entity
  OffEntity toEntity() {
    return OffEntity(
      id: id,
      shopId: shopId,
      productId: productId,
      name: name,
      description: description,
      discountPercentage: discountPercentage,
      newPrice: newPrice,
      startDate: startDate,
      endDate: endDate,
      image: image,
    );
  }

  /// ✅ التحويل من Entity إلى Model
  factory OffModel.fromEntity(OffEntity entity) {
    return OffModel(
      id: entity.id,
      shopId: entity.shopId,
      productId: entity.productId,
      name: entity.name,
      description: entity.description,
      discountPercentage: entity.discountPercentage,
      newPrice: entity.newPrice,
      startDate: entity.startDate,
      endDate: entity.endDate,
      image: entity.image,
    );
  }
}
