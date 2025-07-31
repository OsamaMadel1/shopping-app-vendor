import 'package:app_vendor/api/errors/error_model.dart';
import 'package:app_vendor/api/errors/exceptions.dart';
import 'package:app_vendor/api/response/response_model.dart';
import 'package:app_vendor/comments/data/models/comment_model.dart';
import 'package:app_vendor/comments/data/sources/comment_remote_data_source.dart';
import 'package:dio/dio.dart';

class CommentRemoteDataSourceImpl implements CommentRemoteDataSource {
  final Dio dio;

  CommentRemoteDataSourceImpl(this.dio);

  @override
  Future<List<CommentModel>> getCommentsByProductId(String productId) async {
    try {
      final response = await dio.get(
        'Rate/comment',
        queryParameters: {'productId': productId},
      );

      final responseModel = ResponseModel<List<CommentModel>>.fromJson(
        response.data,
        (json) => (json as List<dynamic>)
            .map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

      if (!responseModel.succeeded) {
        // نرمي الاستثناء مع رسالة من ResponseModel
        throw Exceptions.getMessageFromErrorModel(
          ErrorModel(message: null, errors: responseModel.errors),
        );
      }

      return responseModel.data ?? [];
    } catch (e) {
      if (e is String) {
        // إذا كانت رسالة خطأ نصية من Exceptions.getMessageFromErrorModel
        throw Exception(e);
      }
      throw Exception(Exceptions.getMessage(e));
    }
  }
}
