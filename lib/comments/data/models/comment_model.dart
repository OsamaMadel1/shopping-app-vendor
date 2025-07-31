// comment_model.dart

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'customer_model.dart';
import '../../domain/entities/comment_entity.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel extends Equatable {
  final String id;
  final String comment;
  final int rating;
  // final bool isApproved;
  // final bool isDeleted;
  final String productId;
  final String customerId;
  final DateTime createdAt;
  final int countLikes;
  final CustomerModel customer;

  const CommentModel({
    required this.id,
    required this.comment,
    required this.rating,
    // required this.isApproved,
    // required this.isDeleted,
    required this.productId,
    required this.customerId,
    required this.createdAt,
    required this.countLikes,
    required this.customer,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  @override
  List<Object?> get props => [id];

  CommentEntity toEntity() => CommentEntity(
    id: id,
    comment: comment,
    rating: rating,
    // isApproved: isApproved,
    // isDeleted: isDeleted,
    productId: productId,
    customerId: customerId,
    createdAt: createdAt,
    countLikes: countLikes,
    customerFirstName: customer.firstName,
    customerLastName: customer.lastName,
  );
}
