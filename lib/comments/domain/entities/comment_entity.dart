class CommentEntity {
  final String id;
  final String comment;
  final int rating;
  // final bool isApproved;
  // final bool isDeleted;
  final String productId;
  final String customerId;
  final DateTime createdAt;
  final int countLikes;
  final String customerFirstName;
  final String customerLastName;

  CommentEntity({
    required this.id,
    required this.comment,
    required this.rating,
    // required this.isApproved,
    // required this.isDeleted,
    required this.productId,
    required this.customerId,
    required this.createdAt,
    required this.countLikes,
    required this.customerFirstName,
    required this.customerLastName,
  });
}
