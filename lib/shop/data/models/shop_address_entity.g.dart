// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_address_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopAddressModel _$ShopAddressModelFromJson(Map<String, dynamic> json) =>
    ShopAddressModel(
      id: json['id'] as String?,
      city: json['city'] as String,
      street: json['street'] as String,
      floor: json['floor'] as String,
      apartment: json['apartment'] as String,
    );

Map<String, dynamic> _$ShopAddressModelToJson(ShopAddressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'city': instance.city,
      'street': instance.street,
      'floor': instance.floor,
      'apartment': instance.apartment,
    };
