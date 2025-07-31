// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_data_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDataItemModel _$OrderDataItemModelFromJson(Map<String, dynamic> json) =>
    OrderDataItemModel(
      id: json['id'] as String,
      productName: json['productName'] as String,
      orderId: json['orderId'] as String,
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderDataItemModelToJson(OrderDataItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productName': instance.productName,
      'orderId': instance.orderId,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'price': instance.price,
    };
