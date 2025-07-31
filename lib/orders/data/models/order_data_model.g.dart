// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDataModel _$OrderDataModelFromJson(Map<String, dynamic> json) =>
    OrderDataModel(
      id: json['id'] as String,
      customerId: json['customerId'] as String,
      shopId: json['shopId'] as String,
      orderDate: DateTime.parse(json['orderDate'] as String),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      orderState: OrderDataModel._orderStateFromJson(json['orderState']),
      orderItems: (json['orderItems'] as List<dynamic>)
          .map((e) => OrderDataItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderDataModelToJson(OrderDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'shopId': instance.shopId,
      'orderDate': instance.orderDate.toIso8601String(),
      'totalAmount': instance.totalAmount,
      'orderState': OrderDataModel._orderStateToJson(instance.orderState),
      'orderItems': instance.orderItems,
    };
