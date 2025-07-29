import 'package:json_annotation/json_annotation.dart';

part 'off_entity.g.dart';

@JsonSerializable()
class OffEntity {
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

  const OffEntity({
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

  factory OffEntity.fromJson(Map<String, dynamic> json) =>
      _$OffEntityFromJson(json);

  Map<String, dynamic> toJson() => _$OffEntityToJson(this);
}
