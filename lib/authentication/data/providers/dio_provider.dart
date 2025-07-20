import 'package:app_vendor/authentication/data/network/auth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dioProvider = Provider<Dio>((ref) {
  final prefs = ref.watch(
    sharedPrefsProvider,
  ); //إرسال التوكن مع كل طلب HTTP باستخدام Dio
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://multi-vendor-api.runasp.net/multi-vendor-api/',
      //headers: {'Content-Type': 'application/json'},from application/json or  'Content-Type': 'multipart/form-data'
    ),
  );
  dio.interceptors.add(
    AuthInterceptor(prefs),
  ); //إرسال التوكن مع كل طلب HTTP باستخدام Dio
  return dio;
});
//مزود لتوفير SharedPreferences لحفظ واسترجاع البيانات محليًا (مثل التوكن).
final sharedPrefsProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPrefsProvider must be overridden');
});
//ينشئ كائن Dio المستخدم لتنفيذ طلبات HTTP إلى الـ API.
