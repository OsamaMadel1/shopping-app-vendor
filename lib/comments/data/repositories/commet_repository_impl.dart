import 'package:app_vendor/comments/data/sources/comment_remote_data_source.dart';
import 'package:app_vendor/comments/domain/entities/comment_entity.dart';
import 'package:app_vendor/comments/domain/repositories/comment_repository.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentRemoteDataSource remote;

  CommentRepositoryImpl(this.remote);

  @override
  Future<List<CommentEntity>> getCommentsByProductId(String productId) async {
    final models = await remote.getCommentsByProductId(productId);
    return models.map((e) => e.toEntity()).toList();
  }
}
