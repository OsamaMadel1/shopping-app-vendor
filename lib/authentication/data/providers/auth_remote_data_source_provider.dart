import 'package:app_vendor/authentication/data/providers/dio_provider.dart';
import 'package:app_vendor/authentication/data/source/remote/auth_remote_data_source.dart';
import 'package:app_vendor/authentication/data/source/remote/auth_remote_data_source_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider); // تأكد من وجود dioProvider
  return AuthRemoteDataSourceImpl(dio);
});
//يوفر نسخة من AuthRemoteDataSourceImpl المسؤولة عن تسجيل الدخول والتسجيل باستخدام API.
