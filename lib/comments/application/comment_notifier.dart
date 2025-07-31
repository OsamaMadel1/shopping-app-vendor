import 'package:app_vendor/api/errors/exceptions.dart';
import 'package:app_vendor/comments/application/comment_state.dart';
import 'package:app_vendor/comments/domain/repositories/comment_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentNotifier extends StateNotifier<CommentState> {
  final CommentRepository repository;

  CommentNotifier(this.repository) : super(const CommentState.initial());

  Future<void> getCommentsByProductId(String productId) async {
    state = const CommentState.loading();
    try {
      final comments = await repository.getCommentsByProductId(productId);
      state = CommentState.loaded(comments);
    } catch (e) {
      final message = Exceptions.getMessage(e);
      state = CommentState.error(message);
    }
  }
}
