import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  //إرسال التوكن مع كل طلب HTTP باستخدام Dio
  final SharedPreferences prefs;

  AuthInterceptor(this.prefs);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = prefs.getString('auth_token');
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options); // يتابع الطلب
  }

  @override
  void onError(DioException error, ErrorInterceptorHandler handler) {
    if (error.response?.statusCode == 401) {
      print('⛔ Unauthorized: التوكن منتهي أو غير صالح');
      // TODO: تنفيذ تسجيل خروج أو إعادة التوجيه إلى شاشة الدخول
    }
    handler.next(error);
  }
}
