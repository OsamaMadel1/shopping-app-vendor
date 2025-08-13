// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopModel _$ShopModelFromJson(Map<String, dynamic> json) => ShopModel(
  id: json['id'] as String?,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  phone: json['phone'] as String,
  shopState: (json['shopState'] as num).toInt(),
  email: ShopEmailModel.fromJson(json['email'] as Map<String, dynamic>),
  address: ShopAddressModel.fromJson(json['address'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ShopModelToJson(ShopModel instance) => <String, dynamic>{
  'id': instance.id,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'phone': instance.phone,
  'shopState': instance.shopState,
  'email': instance.email,
  'address': instance.address,
};
