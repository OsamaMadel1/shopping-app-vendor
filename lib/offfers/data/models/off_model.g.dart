// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'off_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OffModel _$OffModelFromJson(Map<String, dynamic> json) => OffModel(
  id: json['id'] as String?,
  shopId: json['shopId'] as String,
  productId: json['productId'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  discountPercentage: (json['discountPercentage'] as num).toDouble(),
  newPrice: (json['newPrice'] as num).toDouble(),
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  image: json['imageUrl'] as String?,
);

Map<String, dynamic> _$OffModelToJson(OffModel instance) => <String, dynamic>{
  'id': instance.id,
  'shopId': instance.shopId,
  'productId': instance.productId,
  'name': instance.name,
  'description': instance.description,
  'discountPercentage': instance.discountPercentage,
  'newPrice': instance.newPrice,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'image': instance.image,
};
