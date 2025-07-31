// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
  id: json['id'] as String,
  comment: json['comment'] as String,
  rating: (json['rating'] as num).toInt(),
  productId: json['productId'] as String,
  customerId: json['customerId'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  countLikes: (json['countLikes'] as num).toInt(),
  customer: CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'rating': instance.rating,
      'productId': instance.productId,
      'customerId': instance.customerId,
      'createdAt': instance.createdAt.toIso8601String(),
      'countLikes': instance.countLikes,
      'customer': instance.customer,
    };
