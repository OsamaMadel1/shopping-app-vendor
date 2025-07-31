import 'package:app_vendor/comments/domain/entities/comment_entity.dart';
import 'package:app_vendor/comments/domain/repositories/comment_repository.dart';

class GetCommentsByProductIdUseCase {
  final CommentRepository repository;

  GetCommentsByProductIdUseCase(this.repository);

  Future<List<CommentEntity>> call(String productId) {
    return repository.getCommentsByProductId(productId);
  }
}
