import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app_vendor/comments/domain/entities/comment_entity.dart';

part 'comment_state.freezed.dart';

@freezed
class CommentState with _$CommentState {
  const factory CommentState.initial() = _Initial;
  const factory CommentState.loading() = _Loading;
  const factory CommentState.loaded(List<CommentEntity> comments) = _Loaded;
  const factory CommentState.error(String message) = _Error;
}
