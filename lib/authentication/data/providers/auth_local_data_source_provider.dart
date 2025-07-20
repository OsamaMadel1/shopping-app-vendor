import 'package:app_vendor/authentication/data/providers/dio_provider.dart';
import 'package:app_vendor/authentication/data/source/local/auth_local_data_source.dart';
import 'package:app_vendor/authentication/data/source/local/auth_local_data_source_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  final prefs = ref.watch(
    sharedPrefsProvider,
  ); // تأكد من أنك توفر SharedPreferences
  return AuthLocalDataSourceImpl(prefs);
});
//يوفر نسخة من AuthLocalDataSourceImpl التي تتعامل مع SharedPreferences لحفظ التوكن واسترجاعه.
