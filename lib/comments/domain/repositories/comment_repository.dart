import 'package:app_vendor/comments/domain/entities/comment_entity.dart';

abstract class CommentRepository {
  Future<List<CommentEntity>> getCommentsByProductId(String productId);
}
