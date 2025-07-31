import 'package:app_vendor/comments/data/models/comment_model.dart';

abstract class CommentRemoteDataSource {
  Future<List<CommentModel>> getCommentsByProductId(String productId);
}
