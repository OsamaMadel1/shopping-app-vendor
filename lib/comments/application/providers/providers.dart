import 'package:app_vendor/authentication/application/providers/dio_provider.dart';
import 'package:app_vendor/comments/data/repositories/commet_repository_impl.dart';
import 'package:app_vendor/comments/data/sources/comment_remote_data_source.dart';
import 'package:app_vendor/comments/data/sources/comment_remote_data_source_impl.dart';
import 'package:app_vendor/comments/domain/repositories/comment_repository.dart';
import 'package:app_vendor/comments/domain/use_cases/get_comments_by_product_id_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commentRemoteDataSourceProvider = Provider<CommentRemoteDataSource>((
  ref,
) {
  final dio = ref.watch(dioProvider);
  return CommentRemoteDataSourceImpl(dio);
});

final commentRepositoryProvider = Provider<CommentRepository>((ref) {
  final remote = ref.watch(commentRemoteDataSourceProvider);
  return CommentRepositoryImpl(remote);
});

final getCommentsByProductIdUseCaseProvider =
    Provider<GetCommentsByProductIdUseCase>((ref) {
      final repo = ref.watch(commentRepositoryProvider);
      return GetCommentsByProductIdUseCase(repo);
    });
