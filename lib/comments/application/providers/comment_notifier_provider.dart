import 'package:app_vendor/comments/application/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_vendor/comments/application/comment_notifier.dart';
import 'package:app_vendor/comments/application/comment_state.dart';

final commentNotifierProvider =
    StateNotifierProvider<CommentNotifier, CommentState>((ref) {
      final repo = ref.watch(commentRepositoryProvider);
      return CommentNotifier(repo);
    });
