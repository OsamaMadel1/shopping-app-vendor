import 'package:dio/dio.dart';
import 'error_model.dart';

class Exceptions {
  /// ✅ يعالج الأخطاء القادمة من Dio
  static String getMessage(dynamic error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        return 'انتهت مهلة الاتصال بالخادم. حاول لاحقًا.';
      }

      if (error.type == DioExceptionType.connectionError) {
        return 'فشل الاتصال بالخادم. تأكد من وجود الإنترنت.';
      }

      if (error.response != null) {
        final statusCode = error.response?.statusCode;
        final data = error.response?.data;

        if (data is Map<String, dynamic>) {
          try {
            // نحاول تحويل الأخطاء مباشرة من errors
            final errorModel = ErrorModel(
              message: null,
              errors: (data['errors'] as Map?)?.map(
                (key, value) => MapEntry(
                  key.toString(),
                  List<String>.from(value as List<dynamic>),
                ),
              ),
            );

            final firstError = _extractFirstError(errorModel.errors);
            if (firstError != null && firstError.isNotEmpty) {
              return firstError;
            }
          } catch (_) {
            // فشل التحويل، تجاهل
          }
        }

        switch (statusCode) {
          case 400:
            return 'طلب غير صالح. تحقق من البيانات.';
          case 401:
            return 'البريد الإلكتروني أو كلمة المرور غير صحيحة.';
          case 403:
            return 'لا تملك صلاحية للوصول.';
          case 404:
            return 'العنصر المطلوب غير موجود.';
          case 500:
            return 'خطأ في الخادم. حاول لاحقًا.';
        }
      }

      return 'حدث خطأ غير متوقع. حاول لاحقًا.';
    }

    return 'حدث خطأ. حاول مرة أخرى.';
  }

  /// ✅ استخراج رسالة من ErrorModel
  static String getMessageFromErrorModel(ErrorModel? error) {
    if (error == null) return 'حدث خطأ غير متوقع.';

    final firstError = _extractFirstError(error.errors);
    if (firstError != null && firstError.isNotEmpty) {
      return firstError;
    }

    return error.message ?? 'حدث خطأ غير متوقع.';
  }

  /// 🔒 استخراج أول رسالة من errors
  static String? _extractFirstError(Map<String, List<String>>? errors) {
    if (errors == null || errors.isEmpty) return null;

    try {
      final firstEntry = errors.entries.first;
      if (firstEntry.value.isNotEmpty) {
        return firstEntry.value.first;
      }
    } catch (_) {}
    return null;
  }
}
