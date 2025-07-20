// lib/utils/error_handler.dart

import 'package:dio/dio.dart';

class ErrorHandler {
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

        // ✅ استخراج الرسالة من errors إذا كانت موجودة
        if (data is Map<String, dynamic>) {
          if (data['errors'] != null &&
              data['errors'] is Map<String, dynamic>) {
            final errors = data['errors'] as Map<String, dynamic>;
            if (errors.isNotEmpty) {
              final firstKey = errors.keys.first;
              final messages = errors[firstKey];
              if (messages is List && messages.isNotEmpty) {
                return messages.first.toString();
              }
            }
          }

          if (data['message'] != null) {
            return data['message'].toString();
          }
        }

        if (statusCode == 400) {
          return 'طلب غير صالح. تحقق من البيانات المدخلة.';
        } else if (statusCode == 401) {
          return 'البريد الإلكتروني أو كلمة المرور غير صحيحة.';
        } else if (statusCode == 403) {
          return 'لا تملك صلاحية للوصول.';
        } else if (statusCode == 404) {
          return 'العنصر المطلوب غير موجود.';
        } else if (statusCode == 500) {
          return 'خطأ في الخادم. حاول لاحقًا.';
        }
      }

      return 'حدث خطأ غير متوقع. حاول لاحقًا.';
    }

    return 'حدث خطأ. حاول مرة أخرى.';
  }
}
